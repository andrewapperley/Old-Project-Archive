//
//  UIView+AFFUIVew_pos_size.m
//  AFFramework
//
//  Created by Andrew Apperley on 2013-04-11.
//  Copyright (c) 2013 AFFramework. All rights reserved.
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

- (void)setAffHeight:(float)affHeight
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
    [self setAffHeight:self.affHeight];
}

@end