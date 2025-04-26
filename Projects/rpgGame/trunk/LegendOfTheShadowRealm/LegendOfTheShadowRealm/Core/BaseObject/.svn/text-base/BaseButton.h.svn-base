//
//  BaseButton.h
//  LegendOfTheShadowRealm
//
//  Created by Andrew Apperley on 2012-11-30.
//
//

#import <UIKit/UIKit.h>
#import "BaseFrameUtility.h"
#import "EventCenter.h"
#import "MasterSkin.h"

@interface BaseButton : UIButton<EventCenter, BaseFrameUtility>

- (void)addHandler:(SEL)action forControlEvent:(UIControlEvents)controlEvent;
- (void)removeHandler:(SEL)action forControlEvents:(UIControlEvents)controlEvents;
- (void)removeAllHandlers;

- (void)destroy;
- (void)destroyAndRemove;
- (void)destroy:(id)object;
- (void)destroyAndRemove:(id)object;

- (void)removeAllSubviews;
- (void)removeAllSubviewsAtIndex:(int)index;

-(id)initWithImageBackground:(UIImage *)image andSelected:(UIImage *)selected andDisabled:(UIImage *)disabled andPoint:(CGPoint)point withDelay:(BOOL)delay;

-(id)initWithImageBackground:(UIImage *)image andPoint:(CGPoint)point withDelay:(BOOL)delay;


@end
