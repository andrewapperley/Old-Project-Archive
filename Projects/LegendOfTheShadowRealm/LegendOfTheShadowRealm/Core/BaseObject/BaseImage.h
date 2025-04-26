//
//  BaseImage.h
//  LegendOfTheShadowRealm
//
//  Created by Jeremy Fuellert on 2012-12-02.
//
//

#import "BaseView.h"
#import "BaseLayer.h"
#import <QuartzCore/QuartzCore.h>

@class CAAnimation;

@interface BaseImage : BaseView

@property (nonatomic, assign) int rotation;
@property (nonatomic, retain) UIImage *image;
@property (nonatomic, retain) BaseLayer *imageLayer;
@property (nonatomic, retain) NSString *name;

- (id)initWithFrame:(CGRect)frame andImage:(UIImage *)image;
- (id)initWithOrigin:(CGPoint)frame andImage:(UIImage *)image;
- (id)initWithFrame:(CGRect)frame andColor:(UIColor*)color;

- (void)addAnimation:(CAAnimation *)animation forKey:(NSString *)key;
- (void)stopAnimationForKey:(NSString *)key;
- (void)stopAllAnimations;

- (CAAnimation *)animationForKey:(NSString *)key;
- (NSArray *)allAnimationKeys;

@end
