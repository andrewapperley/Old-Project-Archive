//
//  SpriteShape.m
//  GLTesting
//
//  Created by Andrew Apperley on 2013-07-15.
//  Copyright (c) 2013 Andrew Apperley. All rights reserved.
//

#import "SpriteShape.h"

@implementation SpriteShape

- (id)initWithImage:(UIImage *)image andPointRatio:(float)pRatio
{
    self = [super init];
    if(self)
    {
        self.width = image.size.width /  pRatio;
        self.height = image.size.height / pRatio;
        
        [self setTextureImage:image];
        self.textureCoordinates[0] = GLKVector2Make(1,0);
        self.textureCoordinates[1] = GLKVector2Make(1,1);
        self.textureCoordinates[2] = GLKVector2Make(0,1);
        self.textureCoordinates[3] = GLKVector2Make(0,0);
    }
    return self;
}

@end
