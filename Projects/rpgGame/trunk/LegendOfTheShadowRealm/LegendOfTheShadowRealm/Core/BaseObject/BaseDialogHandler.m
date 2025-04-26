//
//  BaseDialogHandler.m
//  LegendOfTheShadowRealm
//
//  Created by Andrew Apperley on 2013-03-05.
//
//

#import "BaseDialogHandler.h"
#import "BaseDialog.h"
#import "BaseButton.h"
#import "Constants.h"
@implementation BaseDialogHandler
@synthesize _dialogSet, queue;
- (id)initWithFrame:(CGRect)frame andDialogSet:(NSArray *)dialogSet
{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        self.userInteractionEnabled = FALSE;
        _dialogSet = [NSArray arrayWithArray:dialogSet];
        queue = [NSMutableArray new];
        [self setupGestures];
        [self addListener:EVENT_VIEW_READY andSel:@selector(showintEvent:)];
        [self addListener:EVENT_SHOW_OUT andSel:@selector(showOut:)];
    }
    return self;
}

-(void)setupGestures
{
    UISwipeGestureRecognizer *swipeUp = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(onGesture:)];
    swipeUp.numberOfTouchesRequired = 2;
    swipeUp.direction = UISwipeGestureRecognizerDirectionUp;
    [self addGestureRecognizer:swipeUp];
    [self destroy:swipeUp];
}

- (void)onGesture:(UIEvent *)event
{
    if(((UISwipeGestureRecognizer *)event).direction == UISwipeGestureRecognizerDirectionUp)
    {
        [self sendEventOnce:EVENT_SHOW_OUT andObject:[NSNumber numberWithInt:0]];
    }
}

-(void)addView:(Class)view andDirection:(int)direction
{
    
    [queue addObject:view];
    if(!addingView && !active){
        addingView = TRUE;
        active = TRUE;
        [self prepareView:direction];
    }
}

-(void)eliminateShownOutView
{
    [queue removeObjectAtIndex:0];
}

-(void)prepareView:(int)direction
{
   if(currentDialog)
       [self destroy:currentDialog];
    
    currentDialogString = (Class)[queue lastObject];
    currentDialog = [[currentDialogString alloc] initWithFrame:self.frame];
    
    switch (direction) {
        case UP:
            currentDialog.dialogStage._x = (self._width - currentDialog.dialogStage._width)/2;
            currentDialog.dialogStage._y = - currentDialog.dialogStage._height;
            break;
        case RIGHT:
            currentDialog.dialogStage._y = (self._height - currentDialog.dialogStage._height)/2;
            currentDialog._x = self._width;
            break;
        case DOWN:
            currentDialog.dialogStage._x = (self._width - currentDialog.dialogStage._width)/2;
            currentDialog.dialogStage._y = currentDialog.dialogStage._height;
            break;
        case LEFT:
            currentDialog.dialogStage._y = (self._height - currentDialog.dialogStage._height)/2;
            currentDialog.dialogStage._x = - self._width;
            break;
        default:
            currentDialog.dialogStage._x = (self._width - currentDialog.dialogStage._width)/2;
            currentDialog.dialogStage._y = - currentDialog.dialogStage._height;
    }

    currentDialog.blocker.alpha = 0.0f;
    [self addSubview:currentDialog];
    [self sendEvent:EVENT_VIEW_READY andObject:[NSNumber numberWithInt:direction]];
}

-(void)showintEvent:(NSNotification *)object
{
    [self showIn:[[object object] intValue]];
}

-(void)showIn:(int)direction
{
    [UIView animateWithDuration:1.0f animations:^(){
        
        currentDialog.blocker.alpha = 0.7f;
        switch (direction) {
            case UP:
                currentDialog.dialogStage._y = (self._height - currentDialog.dialogStage._height)/2;
                break;
            case RIGHT:
                currentDialog.dialogStage._x = (self._width - currentDialog.dialogStage._width)/2;
                break;
            case DOWN:
                currentDialog.dialogStage._y = (self._height - currentDialog.dialogStage._height)/2;
                break;
            case LEFT:
                currentDialog.dialogStage._x = (self._width - currentDialog.dialogStage._width)/2;
                break;
            default:
                currentDialog.dialogStage._y = (self._height - currentDialog.dialogStage._height)/2;
                
        }

        
    
    } completion:^(BOOL done){
        if(done) {
            self.userInteractionEnabled = YES;
            addingView = FALSE;
        }
    }];
    
    [self eliminateShownOutView];
}

-(void)showOut:(NSNotification *)direction
{
    int _direction = (int)[direction.object intValue];
    //0 = up
    //1 = right
    //2 = down
    //3 = left
    currentDialog.userInteractionEnabled = FALSE;
    [UIView animateWithDuration:1.0f animations:^(){
    
        currentDialog.blocker.alpha = 0.0f;
        switch (_direction) {
            case UP:
                currentDialog.dialogStage._y = -self._height;
                break;
            case RIGHT:
                currentDialog.dialogStage._x = self._width;
                break;
            case DOWN:
                currentDialog.dialogStage._y = self._height;
                break;
            case LEFT:
                currentDialog.dialogStage._x = -self._width;
                break;
            default:
                currentDialog.dialogStage._y = -self._height;
        
        }
    } completion:^(BOOL done){
        if(done) {
            [currentDialog removeFromSuperview];
            [currentDialog release];
            currentDialog = nil;
            if([queue count] > 0) {
                switch (_direction) {
                    case UP:
                        [self prepareView:DOWN];
                        break;
                    case RIGHT:
                        [self prepareView:LEFT];
                        break;
                    case DOWN:
                        [self prepareView:UP];
                        break;
                    case LEFT:
                        [self prepareView:RIGHT];
                        break;
                    default:
                        [self prepareView:UP];
                }
            } else if(!currentDialog){
                self.userInteractionEnabled = NO;
                active = FALSE;
            }
        }
    }];
}

-(void)dealloc
{
    [self destroy:queue];
    [self destroy:_dialogSet];
    [self destroy:currentDialog];
    
    [super dealloc];
}

@end
