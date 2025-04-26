//
//  BaseScrollView.h
//  LegendOfTheShadowRealm
//
//  Created by Andrew Apperley on 2012-11-30.
//
//

#import <UIKit/UIKit.h>
#import "BaseFrameUtility.h"
#import "EventCenter.h"
#import "MasterSkin.h"

@interface BaseScrollView : UIScrollView<EventCenter, BaseFrameUtility>

- (void)destroy;
- (void)destroyAndRemove;
- (void)destroy:(id)object;
- (void)destroyAndRemove:(id)object;

- (void)removeAllSubviews;
- (void)removeAllSubviewsAtIndex:(int)index;


@end
