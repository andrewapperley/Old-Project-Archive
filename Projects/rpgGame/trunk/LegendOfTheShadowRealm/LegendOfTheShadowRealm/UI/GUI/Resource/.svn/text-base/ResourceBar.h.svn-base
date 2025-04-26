//
//  ResourceBar.h
//  LegendOfTheShadowRealm
//
//  Created by Jeremy Fuellert on 2013-01-18.
//
//

#import "BaseView.h"

@class BaseImage;

@interface ResourceBar : BaseView
{
    BaseImage *background;
    BaseImage *backgroundFrame;
    BaseImage *fill;
    
    NSString *backgroundImage;
    NSString *fillImage;
    NSString *frameImage;
}

@property (nonatomic, assign) float minValue;
@property (nonatomic, assign) float currentValue;
@property (nonatomic, assign) float maxValue;

- (id)initWithFrame:(CGRect)frame andMinValue:(float)lminValue andMaxValue:(float)lmaxValue andCurrenValue:(float)lcurrentValue andBackgroundImage:(NSString *)lbackgroundImage andFillImage:(NSString *)lfillImage andFrameImage:(NSString *)lframeImage;
- (id)initWithFrame:(CGRect)frame andMinValue:(float)lminValue andMaxValue:(float)lmaxValue andCurrenValue:(float)lcurrentValue;

- (void)update;

@end
