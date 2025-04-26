//
//  ResourceBar.m
//  LegendOfTheShadowRealm
//
//  Created by Jeremy Fuellert on 2013-01-18.
//
//

#import "BaseImage.h"
#import "ResourceBar.h"

@implementation ResourceBar
@synthesize minValue = _minValue;
@synthesize currentValue = _currentValue;
@synthesize maxValue = _maxValue;

- (id)initWithFrame:(CGRect)frame andMinValue:(float)lminValue andMaxValue:(float)lmaxValue andCurrenValue:(float)lcurrentValue
{
    return [self initWithFrame:frame andMinValue:lminValue andMaxValue:lmaxValue andCurrenValue:lcurrentValue andBackgroundImage:nil andFillImage:nil andFrameImage:nil];
}

- (id)initWithFrame:(CGRect)frame andMinValue:(float)lminValue andMaxValue:(float)lmaxValue andCurrenValue:(float)lcurrentValue andBackgroundImage:(NSString *)lbackgroundImage andFillImage:(NSString *)lfillImage andFrameImage:(NSString *)lframeImage
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.userInteractionEnabled = FALSE;
        self.clipsToBounds = FALSE;
        
        _minValue = lminValue;
        _currentValue = lcurrentValue;
        _maxValue = lmaxValue;
        backgroundImage = lbackgroundImage;
        fillImage = lfillImage;
        frameImage = lframeImage;
        
        [self setupUI];
        [self update];
    }
    return self;
}

/*
 * Min Value
 */
- (void)setMinValue:(float)minValue
{
    _minValue = minValue;
    [self update];
}

- (float)minValue
{
    return _minValue;
}

/*
 * Max Value
 */
- (void)setMaxValue:(float)maxValue
{
    _maxValue = maxValue;
    [self update];
}

- (float)maxValue
{
    return _maxValue;
}

/*
 * Current Value
 */
- (void)setCurrentValue:(float)currentValue
{
    _currentValue = currentValue;
    [self update];
}

- (float)currentValue
{
    return _currentValue;
}

/*
 * UI Handling
 */
- (void)setupUI
{    
    background = [[BaseImage alloc] initWithOrigin:CGPointZero andImage:[UIImage imageNamed:backgroundImage]];
    fill = [[BaseImage alloc] initWithOrigin:CGPointZero andImage:[UIImage imageNamed:fillImage]];
    backgroundFrame = [[BaseImage alloc] initWithOrigin:CGPointZero andImage:[UIImage imageNamed:frameImage]];

    background._x = (self._width - background._width) / 2;
    fill._x = (self._width - fill._width) /2;
    backgroundFrame._x = (self._width - backgroundFrame._width) / 2;
    
    fill.layer.anchorPoint = CGPointMake(0.5, 0.5);
    if([[UIDevice currentDevice].systemVersion floatValue] >= 6.0) {
        fill.layer.drawsAsynchronously = TRUE;
    }
    
    [self addSubview:background];
    [self addSubview:fill];
    [self addSubview:backgroundFrame];
}

- (void)update
{
    //Fill width percentage        
    fill.imageLayer._scaleX = MAX(_currentValue / _maxValue, 0.0f);
}


- (void)dealloc
{
    [self destroyAndRemove:background];
    [self destroyAndRemove:backgroundFrame];
    [self destroyAndRemove:fill];
    
    [super dealloc];
}

@end
