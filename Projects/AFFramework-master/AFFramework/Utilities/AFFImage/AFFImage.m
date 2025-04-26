//
//  AFFImage.m
//  AFFramework
//
//  Created by Jeremy Fuellert on 2012-12-02.
//
//
//  Permission is hereby granted, free of charge, to any person
//  obtaining a copy of this software and associated documentation
//  files (the "Software"), to deal in the Software without
//  restriction, including without limitation the rights to use,
//  copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the
//  Software is furnished to do so, subject to the following
//  conditions:
//
//  The above copyright notice and this permission notice shall be
//  included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
//  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
//  OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
//  HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
//  WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
//  OTHER DEALINGS IN THE SOFTWARE.
//

#import "AFFImage.h"
#import "ARCHelper.h"

@implementation AFFImage
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
        imageLayer = [CALayer layer];
        
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
                              [NSNull null], @"position",
                              nil];
        
        
        [self.layer addSublayer:imageLayer];
        if([[UIDevice currentDevice].systemVersion floatValue] >= 6.0)
        {
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
    }
    return self;
}

@synthesize rotation = _rotation;
- (void)setRotation:(int)degrees
{
    _rotation = (M_PI * degrees / 180.0f);
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
        [_image ah_release];
        _image = nil;
    }
    _image = [image ah_retain];

     imageLayer.contents = (id)_image.CGImage;
}

- (UIImage *)image
{
    return _image;
}

- (void)dealloc
{
    if(_image && _image != nil)
    {
        [_image ah_release];
        _image = nil;
    }
    [super ah_dealloc];
}

@end
