//
//  AppDelegate.m
//  TestHarness
//
//  Created by Jeremy Fuellert on 2013-04-07.
//  Copyright (c) 2013 AFFramework. All rights reserved.
//

#import "AppDelegate.h"
#import "AFFGesturedViewController.h"
#import "ViewController.h"
#import "TestView.h"

@implementation AppDelegate

- (void)dealloc
{
    AFFRemoveAllEvents();

}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.viewController = [[AFFGesturedViewController alloc] initWithDirections:SwipeAll andMinPinchVelocity:1.0f];
    [[self.viewController evtOpening] addHandler:AFFHandler(@selector(openingView))];
    [[self.viewController evtOpened] addHandler:AFFHandler(@selector(openedView))];
    [[self.viewController evtClosing] addHandler:AFFHandler(@selector(closingView))];
    [[self.viewController evtClosed] addHandler:AFFHandler(@selector(closedView))];
    
    [[self.viewController evtSwipedDown] addHandler:AFFHandler(@selector(swipeDown))];
    [[self.viewController evtSwipedUp] addHandler:AFFHandler(@selector(swipeUp))];
    [[self.viewController evtSwipedLeft] addHandler:AFFHandler(@selector(swipeLeft))];
    [[self.viewController evtSwipedRight] addHandler:AFFHandler(@selector(swipeRight))];
    
    [[self.viewController evtPinchedIn] addHandler:AFFHandler(@selector(pinchIn))];
    [[self.viewController evtPinchedOut] addHandler:AFFHandler(@selector(pinchOut))];
    
    [self.window setBackgroundColor:[UIColor whiteColor]];
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    [self createOpenButton];
    
    return YES;
}

- (void)createOpenButton
{
    UIButton *testButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 20, 50, 50)];
    testButton.backgroundColor = [UIColor cyanColor];
    [testButton addTarget:self action:@selector(openTestView) forControlEvents:UIControlEventTouchUpInside];
    [self.window addSubview:testButton];
    
    
    testView1 = [[TestView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    testView1.backgroundColor = [UIColor blueColor];
    
    [self.viewController open:testView1 from:CGPointMake(0, ScreenHeight) to:CGPointZero];
    
}

- (void)openTestView
{
    TestView *testView = [[TestView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    [self.viewController open:testView from:CGPointMake(- ScreenWidth, 0) to:CGPointMake(0, 0) andCloseCurrentViewTo:CGPointMake(ScreenWidth, 0)];
}

- (void)openingView
{
    Log(@"AppDelegate - openingView");
}

- (void)openedView
{
    Log(@"AppDelegate - openedView");
}

- (void)closingView
{
    Log(@"AppDelegate - closingView");
}

- (void)closedView
{
    Log(@"AppDelegate - closedView");
}

- (void)swipeLeft
{
    Log(@"AppDelegate - swipeLeft");
}

- (void)swipeRight
{
    Log(@"AppDelegate - swipeRight");
}

- (void)swipeUp
{
    Log(@"AppDelegate - swipeUp");
}

- (void)swipeDown
{
    Log(@"AppDelegate - swipeDown");
}

- (void)pinchIn
{
    Log(@"AppDelegate - pinchIn");
}
- (void)pinchOut
{
    Log(@"AppDelegate - pinchOut");
}

@end
