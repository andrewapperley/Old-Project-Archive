//
//  AppDelegate.h
//  TestHarness
//
//  Created by Jeremy Fuellert on 2013-04-07.
//  Copyright (c) 2013 AFFramework. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AFFGesturedViewController;
@class TestView;

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    TestView *testView1;
}

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) AFFGesturedViewController *viewController;

@end
