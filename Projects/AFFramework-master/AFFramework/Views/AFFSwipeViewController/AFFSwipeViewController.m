//
//  AFFSwipeViewController.m
//  AFFramework
//
//  Created by Jeremy Fuellert on 2013-04-15.
//  Copyright (c) 2013 AFFramework. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person
//  obtaining a copy of this software and associated documentation
//  files (the "Software"), to deal in the Software without
//  restriction, including without limitation the rights to use,
//  copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the
//  Software is furnished to do so, subject to the following
//  conditions:
//
//  The above copyright notice and this permission notice shall be
//  included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
//  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
//  OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
//  HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
//  WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
//  OTHER DEALINGS IN THE SOFTWARE.
//

#import "AFFSwipeViewController.h"
#import "ARCHelper.h"

const short DEFAULT_NUM_TOUCHES = 1;

@implementation AFFSwipeViewController

AFFEventSynthesize(AFFEventInstance, evtSwipedUp);
AFFEventSynthesize(AFFEventInstance, evtSwipedRight);
AFFEventSynthesize(AFFEventInstance, evtSwipedDown);
AFFEventSynthesize(AFFEventInstance, evtSwipedLeft);

- (id)initWithDirections:(SwipeDirection)directions
{
    return [self initWithDirections:directions andNumberOfTouches:DEFAULT_NUM_TOUCHES];
}

- (id)initWithDirections:(SwipeDirection)directions andNumberOfTouches:(uint)numberOfTouches
{
    self = [super init];
    if(self)
    {
        [self createStage];
        [self createGestures:directions andTouchesRequired:numberOfTouches];
    }
    return self;
}

- (void)createStage
{
    stage = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    self.view = stage;
}

- (void)createGestures:(NSUInteger)directions andTouchesRequired:(uint)numTouches
{
    if((directions & SwipeRight) == SwipeRight)
        [self createGestureRecognizer:SwipeRight andNumTouches:numTouches andSelector:@selector(onSwipeRight)];
    
    if((directions & SwipeLeft) == SwipeLeft)
        [self createGestureRecognizer:SwipeLeft andNumTouches:numTouches andSelector:@selector(onSwipeLeft)];
    
    if((directions & SwipeUp) == SwipeUp)
        [self createGestureRecognizer:SwipeUp andNumTouches:numTouches andSelector:@selector(onSwipeUp)];
    
    if((directions & SwipeDown) == SwipeDown)
        [self createGestureRecognizer:SwipeDown andNumTouches:numTouches andSelector:@selector(onSwipeDown)];
}

- (void)createGestureRecognizer:(NSUInteger)direction andNumTouches:(uint)numTouches andSelector:(SEL)selector
{
    UISwipeGestureRecognizer *swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:selector];
    swipeGesture.direction = direction;
    swipeGesture.numberOfTouchesRequired = numTouches;
    [stage addGestureRecognizer:swipeGesture];
    
    [swipeGesture ah_release];
    swipeGesture = nil;
}

/*
 * Swipe selectors
 */
- (void)onSwipeRight
{
    [[self evtSwipedRight] send];
}

- (void)onSwipeLeft
{
    [[self evtSwipedLeft] send];
}

- (void)onSwipeUp
{
    [[self evtSwipedUp] send];
}

- (void)onSwipeDown
{
    [[self evtSwipedDown] send];
}

- (void)dealloc
{
    [stage ah_release];
    stage = nil;
    
    AFFRemoveAllEvents();
    
    [super ah_dealloc];
}

@end
