//
//  AFFSwipeViewController.h
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

#import "AFFViewController.h"

enum SwipeDirection
{
    SwipeRight         = 1 << 0,
    SwipeLeft          = 1 << 1,
    SwipeUp            = 1 << 2,
    SwipeDown          = 1 << 3,
    SwipeHorizontal    = SwipeLeft | SwipeRight,
    SwipeVertical      = SwipeUp | SwipeDown,
    SwipeAll           = SwipeRight | SwipeLeft | SwipeUp | SwipeDown
};

typedef NSUInteger SwipeDirection;

@interface AFFSwipeViewController : AFFViewController
{
    @protected
    UIView *stage;
}

//Default number of touches = 1

- (id)initWithDirections:(SwipeDirection)directions;
- (id)initWithDirections:(SwipeDirection)directions andNumberOfTouches:(uint)numberOfTouches;

AFFEventCreate(AFFEventInstance, evtSwipedUp);
AFFEventCreate(AFFEventInstance, evtSwipedRight);
AFFEventCreate(AFFEventInstance, evtSwipedDown);
AFFEventCreate(AFFEventInstance, evtSwipedLeft);

@end
