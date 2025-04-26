//
//  UIView+AFFUIVew_pos_size.m
//  AFFramework
//
//  Created by Andrew Apperley on 2013-04-11.
//  Copyright (c) 2013 AFFramework. All rights reserved.
//

#import "UIView+AFFUIVew_pos_size.h"

@implementation UIView (AFFUIVew_pos_size)

@dynamic affX;
- (float)affX
{
    return self.frame.origin.x;
}

- (void)setAffX:(float)affX
{
    [self setFrame:CGRectMake(affX, self.affY, self.affWidth, self.affHeight)];
}

@dynamic affY;
- (float)affY
{
    return self.frame.origin.y;
}

- (void)setAffY:(float)affY
{
    [self setFrame:CGRectMake(self.affX, affY, self.affWidth, self.affHeight)];
}

@dynamic affWidth;
- (float)affWidth
{
    return self.frame.size.width;
}

- (void)setAffWidth:(float)affWidth
{
    [self setFrame:CGRectMake(self.affX, self.affY, affWidth * self.affScaleX, self.affHeight)];
}

@dynamic affHeight;
- (float)affHeight
{
    return self.frame.size.height;
}

- (void)setAffheight:(float)affHeight
{
    [self setFrame:CGRectMake(self.affX, self.affY, self.affWidth, affHeight * self.affScaleY)];
}

@dynamic affScaleX;
static float scaleX = 1.0f;
- (float)affScaleX
{
    return scaleX;
}

- (void)setAffScaleX:(float)affScaleX
{
    scaleX = affScaleX;
    [self setAffWidth:self.affWidth];
}


@dynamic affScaleY;
static float scaleY = 1.0f;
- (float)affScaleY
{
    return scaleY;
}

- (void)setAffScaleY:(float)affScaleY
{
    scaleY = affScaleY;
    [self setAffheight:self.affHeight];
}

@end
