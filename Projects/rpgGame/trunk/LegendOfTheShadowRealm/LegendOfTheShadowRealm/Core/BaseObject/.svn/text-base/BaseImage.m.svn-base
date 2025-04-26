//
//  BaseImage.m
//  LegendOfTheShadowRealm
//
//  Created by Jeremy Fuellert on 2012-12-02.
//
//

#import "BaseImage.h"

@implementation BaseImage

@synthesize imageLayer;
@synthesize name;

- (id)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame andImage:nil];
}

- (id)initWithOrigin:(CGPoint)origin andImage:(UIImage *)image
{
    return [self initWithFrame:CGRectMake(origin.x, origin.y, image.size.width, image.size.height) andImage:image];
}

- (id)initWithFrame:(CGRect)frame andImage:(UIImage *)image
{
    self = [super initWithFrame:frame];
    if (self)
    {
        imageLayer = [BaseLayer layer];
        //Disables all animations
        self.layer.actions = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                              [NSNull null], @"onOrderIn",
                              [NSNull null], @"onOrderOut",
                              [NSNull null], @"sublayers",
                              [NSNull null], @"contents",
                              [NSNull null], @"bounds",
                              [NSNull null], @"frame",
                              [NSNull null], @"position",
                              nil];
        imageLayer.actions = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                              [NSNull null], @"onOrderIn",
                              [NSNull null], @"onOrderOut",
                              [NSNull null], @"sublayers",
                              [NSNull null], @"contents",
                              [NSNull null], @"bounds",
                              [NSNull null], @"frame",
                              [NSNull null], @"position",                              nil];
        
        
        [self.layer addSublayer:imageLayer];
        if([[UIDevice currentDevice].systemVersion floatValue] >= 6.0) {
            self.layer.drawsAsynchronously = TRUE;
            imageLayer.drawsAsynchronously = TRUE;
        }
        if(image)
        {
            [self setImage:image];
            [self setFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height)];
            imageLayer.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        } else {
            [self setFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height)];
        }
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame andColor:(UIColor*)color;
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self.layer setBackgroundColor:color.CGColor];
        [self setFrame:frame];
    }
    return self;
}

@synthesize rotation = _rotation;
- (void)setRotation:(int)degrees
{
    _rotation = DEGREES_TO_RADIANS(degrees);
    self.transform = CGAffineTransformMakeRotation(_rotation);
}

- (int)rotation
{
    return _rotation;
}

@synthesize image = _image;
- (void)setImage:(UIImage *)image
{
    if(_image)
    {
        [self destroy:_image];
    }
    _image = [image retain];

     imageLayer.contents = (id)_image.CGImage;
}

- (UIImage *)image
{
    return _image;
}

/*
 * Animations
 */
- (void)addAnimation:(CAAnimation *)animation forKey:(NSString *)key
{
    [self.layer addAnimation:animation forKey:key];
}

- (void)stopAnimationForKey:(NSString *)key
{
    [self.layer removeAnimationForKey:key];
}

- (void)stopAllAnimations
{
    [self.layer removeAllAnimations];
}

- (CAAnimation *)animationForKey:(NSString *)key
{
    return [self.layer animationForKey:key];
}

- (NSArray *)allAnimationKeys
{
    return [self.layer animationKeys];
}



@end
