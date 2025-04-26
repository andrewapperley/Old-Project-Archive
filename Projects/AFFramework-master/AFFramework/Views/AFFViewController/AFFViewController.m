//
//  AFFViewController.m
//  AFFramework
//
//  Created by Jeremy Fuellert on 2013-04-13.
//  Copyright (c) 2013 AFFramework. All rights reserved.
//
//  AFFViewController is a view controller class that adds basic view open and close animation functionality.
//  Animations may be altered to meet specific needs.
//  AFFViewController only handles single view instantiations.
//

#import "AFFView.h"
#import "AFFViewController.h"
#import "ARCHelper.h"
#import "UIView+AFFUIVew_pos_size.h"

/*
 * Animation constants
 */
const float animateInTime = 0.35f;
const float animateOutTime = 0.35f;
UIViewAnimationOptions animationInOptions = UIViewAnimationOptionCurveEaseInOut;
UIViewAnimationOptions animationOutOptions = UIViewAnimationOptionCurveEaseInOut;

@implementation AFFViewController
@synthesize isOpen;
@synthesize isOpening;
@synthesize isClosed;
@synthesize isClosing;

AFFEventSynthesize(AFFEventInstance, evtOpening);
AFFEventSynthesize(AFFEventInstance, evtOpened);

AFFEventSynthesize(AFFEventInstance, evtClosing);
AFFEventSynthesize(AFFEventInstance, evtClosed);

+ (id)controller
{
    return [[[self alloc] init] ah_autorelease];
}

- (id)init
{
    self = [super initWithNibName:nil bundle:nil];
    if(self)
    {
        views = [[NSMutableArray alloc] initWithCapacity:1];
        self.view = nil;
        isOpen = FALSE;
        isOpening = FALSE;
        isClosed = FALSE;
        isClosing = FALSE;
    }
    return self;
}

/*
 * Open view handling
 */
- (void)open:(AFFView *)lview
{
    [self open:lview from:CGPointZero to:CGPointZero];
}

/*
 * Synced view opening.
 * The view new view must be in ready state for the current view to be shown out at the
 * same time the new view is shown in.
 */
- (void)open:(AFFView *)lview from:(CGPoint)openPoint to:(CGPoint)toPoint andCloseCurrentViewTo:(CGPoint)closePoint
{
    AFFView *tempView = [lview ah_retain];
    
    if(tempView.isReady)
    {
        [self performSyncClose:[AFFEvent eventWithSender:tempView andData:nil andEventName:nil] openFrom:[NSValue valueWithCGPoint:openPoint] to:[NSValue valueWithCGPoint:toPoint] andCurrentClosePoint:[NSValue valueWithCGPoint:closePoint]];
    } else {
        [[tempView evtReady] addHandlerOneTime:AFFHandlerWithArgs(@selector(performSyncClose:openFrom:to:), tempView, [NSValue valueWithCGPoint:openPoint], [NSValue valueWithCGPoint:toPoint], [NSValue valueWithCGPoint:closePoint])];
        [[tempView evtReadyFailed] addHandlerOneTime:AFFHandler(@selector(onViewFailedToOpen:))];
    }
        
    [tempView ah_release];
    tempView = nil;
}

- (void)performSyncClose:(AFFEvent *)event openFrom:(NSValue *)openPoint to:(NSValue *)toPoint andCurrentClosePoint:(NSValue *)closePoint
{
    [self closeTo:[closePoint CGPointValue]];
    [self open:(AFFView *)event.sender from:[openPoint CGPointValue] to:[toPoint CGPointValue]];
}

/*
 * Regular view opening
 */
- (void)open:(AFFView *)lview from:(CGPoint)openPoint to:(CGPoint)toPoint
{
    //The current view should be cleaned up before adding a new one.
    //If not then a warning would be issued due to improper removal of the previous view.
    //In this case please make sure to close the current view or open the new view with a close point.
    if(views && views.count >= 2)
    {
        @throw [NSException exceptionWithName:@"AFFViewControllerInvalidViewUsage" reason:[NSString stringWithFormat:@"\nView was not properly closed : %@ \nUse one of the following methods to close the view beforehand : \n\'%@\'\n\'%@\'\n\'%@\'", self.currentView, NSStringFromSelector(@selector(close)),NSStringFromSelector(@selector(closeTo:)), NSStringFromSelector(@selector(open:from:to:andCloseCurrentViewTo:))] userInfo:nil];
    }
    
    AFFView *view = [lview ah_retain];
    view.parentViewController = self;
    
    //Set starting point
    view.affX = openPoint.x;
    view.affY = openPoint.y;
    
    if(view.isReady)
    {
        [self onViewReadyToOpen:[AFFEvent eventWithSender:view andData:nil andEventName:nil] fromPoint:[NSValue valueWithCGPoint:toPoint]];
    } else {
        [[view evtReady] addHandlerOneTime:AFFHandlerWithArgs(@selector(onViewReadyToOpen:fromPoint:), [NSValue valueWithCGPoint:toPoint])];
        [[view evtReadyFailed] addHandlerOneTime:AFFHandler(@selector(onViewFailedToOpen:))];
    }
    
    [view ah_release];
    view = nil;
}

- (void)onViewFailedToOpen:(AFFEvent *)event
{
    NSLog(@"\nWarning - View failed to open : %@", event.sender);
}

- (void)onViewReadyToOpen:(AFFEvent *)event fromPoint:(NSValue *)toPoint
{
    if(!isOpening)
    {
        AFFView *view = event.sender;
        [self.view addSubview:view];
        
        self.view.userInteractionEnabled = FALSE;
        [[self evtOpening] send];
        isOpening = TRUE;
        
        //Animation
        [UIView animateWithDuration:animateInTime delay:0.0f options:animationInOptions animations:^{
            view.affX = [toPoint CGPointValue].x;
            view.affY = [toPoint CGPointValue].y;
        } completion:^(BOOL finished) {
            isClosing = FALSE;
            isClosed = FALSE;
            isOpening = FALSE;
            isOpen = TRUE;
            
            [self viewWasOpened:view];
            
            [[self evtOpened] send];
            self.view.userInteractionEnabled = TRUE;
        }];
    }
}

/*
 * Close view
 */
- (void)close
{
    [self closeTo:CGPointZero];
}

- (void)closeTo:(CGPoint)closePoint
{
    if(!isClosing && self.currentView != nil)
    {
        self.view.userInteractionEnabled = FALSE;
        
        AFFView *viewToClose = self.currentView;
        
        [[self evtClosing] send];
        isClosing = TRUE;
        
        //Animation
        [UIView animateWithDuration:animateOutTime delay:0.0f options:animationOutOptions animations:^{
            viewToClose.affX = closePoint.x;
            viewToClose.affY = closePoint.y;
        } completion:^(BOOL finished) {
            isClosing = FALSE;
            isClosed = TRUE;
            isOpening = FALSE;
            isOpen = FALSE;
                        
            [[self evtClosed] send];
            self.view.userInteractionEnabled = TRUE;
            
            [self viewWasClosed];
        }];
    }
}

/*
 * View addition and removal
 */
- (void)viewWasOpened:(AFFView *)view;
{
    [views addObject:view];
}

- (void)viewWasClosed
{
    AFFView *view = self.currentView;
    [view removeFromSuperview];
    [views removeObjectAtIndex:0];
}

/*
 * Accessing views
 */
- (AFFView *)currentView
{
    if(views.count > 0)
        return (AFFView *)[views objectAtIndex:0];
    return nil;
}

- (AFFView *)newView
{
    if(views.count > 0)
        return (AFFView *)[views lastObject];
    return nil;
}

- (void)dealloc
{    
    [views ah_release];
    views = nil;
    
    AFFRemoveAllEvents();
    
    [super ah_dealloc];
}

@end
