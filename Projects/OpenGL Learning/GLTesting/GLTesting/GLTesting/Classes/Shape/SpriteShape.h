//
//  SpriteShape.h
//  GLTesting
//
//  Created by Andrew Apperley on 2013-07-15.
//  Copyright (c) 2013 Andrew Apperley. All rights reserved.
//

#import "RectangleShape.h"

@interface SpriteShape : RectangleShape

- (id)initWithImage:(UIImage *)image andPointRatio:(float)pRatio;

@end