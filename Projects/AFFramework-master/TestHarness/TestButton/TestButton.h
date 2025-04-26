//
//  TestButton.h
//  AFFramework
//
//  Created by Jeremy Fuellert on 2013-04-07.
//  Copyright (c) 2013 AFFramework. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TestButton : UIButton

AFFEventCreate(AFFEventInstance, evtInstanceClick);
AFFEventCreate(AFFEventClass, evtClassClick);

@end
