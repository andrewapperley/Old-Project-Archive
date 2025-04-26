//
//  TestView.m
//  AFFramework
//
//  Created by Jeremy Fuellert on 2013-04-13.
//  Copyright (c) 2013 AFFramework. All rights reserved.
//

#import "AFFViewController.h"
#import "TestView.h"

@implementation TestView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor greenColor]];
        [self createUI];
    }
    return self;
}

- (void)createUI
{
    UIButton *testButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 20, 50, 50)];
    testButton.backgroundColor = [UIColor yellowColor];
    [testButton addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:testButton];
    
    
    [[self evtReady] send];
}

- (void)close
{
    [self.parentViewController closeTo:CGPointMake(0, - ScreenHeight)];
}

@end
