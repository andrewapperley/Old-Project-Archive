//
//  AFFView.h
//  AFFramework
//
//  Created by Jeremy Fuellert on 2013-04-13.
//  Copyright (c) 2013 AFFramework. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFFEventCenter.h"

@class AFFViewController;

@interface AFFView : UIView

@property (nonatomic, assign) AFFViewController *parentViewController;
@property (nonatomic, readonly) BOOL isReady;

AFFEventCreate(AFFEventInstance, evtReady);
AFFEventCreate(AFFEventInstance, evtReadyFailed);

@end
