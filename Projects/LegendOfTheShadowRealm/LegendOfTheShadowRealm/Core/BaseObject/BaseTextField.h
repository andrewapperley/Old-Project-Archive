//
//  BaseTextField.h
//  LegendOfTheShadowRealm
//
//  Created by Andrew Apperley on 2013-03-12.
//
//

#import <UIKit/UIKit.h>

#import "BaseFrameUtility.h"
#import "EventCenter.h"
#import "MasterSkin.h"

@interface BaseTextField : UITextField<EventCenter, BaseFrameUtility>

- (void)destroy;
- (void)destroyAndRemove;
- (void)destroy:(id)object;
- (void)destroyAndRemove:(id)object;


@end
