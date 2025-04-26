//
//  AFFGesturedViewController.m
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

#import "AFFGesturedViewController.h"
#import "ARCHelper.h"

const short DEFAULT_NUM_SWIPE_TOUCHES = 1;
const short DEFAULT_MIN_VELOCITY = 1.0f;

@implementation AFFGesturedViewController

AFFEventSynthesize(AFFEventInstance, evtPinchedIn);
AFFEventSynthesize(AFFEventInstance, evtPinchedOut);

/*
 * Constructors
 */
- (id)initWithDirections:(SwipeDirection)directions
{
    return [self initWithDirections:directions andNumberOfTouches:DEFAULT_NUM_SWIPE_TOUCHES andMinPinchVelocity:DEFAULT_MIN_VELOCITY];
}

- (id)initWithDirections:(SwipeDirection)directions andMinPinchVelocity:(float)lminVelocity
{
    return [self initWithDirections:directions andNumberOfTouches:DEFAULT_NUM_SWIPE_TOUCHES andMinPinchVelocity:lminVelocity];
}

- (id)initWithDirections:(SwipeDirection)directions andNumberOfTouches:(uint)numberOfTouches
{
    return [self initWithDirections:directions andNumberOfTouches:numberOfTouches andMinPinchVelocity:DEFAULT_MIN_VELOCITY];
}

- (id)initWithDirections:(SwipeDirection)directions andNumberOfTouches:(uint)numberOfTouches andMinPinchVelocity:(float)lminVelocity
{
    self = [super initWithDirections:directions andNumberOfTouches:numberOfTouches];
    if(self)
    {
        minVelocity = lminVelocity;
        [self createPinchGestures];
    }
    return self;
}

- (void)createPinchGestures
{
    UIPinchGestureRecognizer *pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(onPinch:)];
    [stage addGestureRecognizer:pinchGesture];
    
    [pinchGesture ah_release];
    pinchGesture = nil;
}

- (void)onPinch:(UIPinchGestureRecognizer *)pinchGesture
{    
    if(pinchGesture.velocity > minVelocity)
        [[self evtPinchedOut] send];
    else if(pinchGesture.velocity < - minVelocity)
        [[self evtPinchedIn] send];
}

- (void)dealloc
{
    AFFRemoveAllEvents();
    
    [super ah_dealloc];
}

@end
