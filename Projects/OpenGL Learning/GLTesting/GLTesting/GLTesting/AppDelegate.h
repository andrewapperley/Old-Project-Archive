//
//  AppDelegate.h
//  GLTesting
//
//  Created by Andrew Apperley on 2013-07-06.
//  Copyright (c) 2013 Andrew Apperley. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GLKit/GLKit.h>
#import "Scene.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, GLKViewControllerDelegate, GLKViewDelegate>
{
    Scene *scene;
}
@property (strong, nonatomic) UIWindow *window;

@end