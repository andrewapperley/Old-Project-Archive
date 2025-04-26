//
//  TestButton.m
//  AFFramework
//
//  Created by Jeremy Fuellert on 2013-04-07.
//  Copyright (c) 2013 AFFramework. All rights reserved.
//

#import "TestButton.h"

@implementation TestButton

AFFEventSynthesize(AFFEventInstance, evtInstanceClick);
AFFEventSynthesize(AFFEventClass, evtClassClick);

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addTarget:self action:@selector(onClick) forControlEvents:UIControlEventTouchUpInside];
//        [self addHandler:AFFHandlerWithArgs(@selector(onClickWithNumber:), [NSNumber numberWithInt:10]) forControlEvent:UIControlEventTouchUpInside];
//        [self addHandler:AFFHandler(@selector(onClick)) forControlEvent:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)onClickWithNumber:(NSNumber *)number
{
    NSLog(@"number : %@", number);
}


- (void)onClick
{
    [[self evtInstanceClick] send:[NSNumber numberWithInt:100]];
    [[TestButton evtClassClick] send];
}

@end
