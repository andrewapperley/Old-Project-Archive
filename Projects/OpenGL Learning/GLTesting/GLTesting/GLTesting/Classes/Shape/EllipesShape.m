//
//  EllipesShape.m
//  GLTesting
//
//  Created by Andrew Apperley on 2013-07-09.
//  Copyright (c) 2013 Andrew Apperley. All rights reserved.
//

#import "EllipesShape.h"

#define ELLIPSE_RESOLUTION 64


@implementation EllipesShape

@synthesize radiusX = _radiusX, radiusY = _radiusY;

-(int)numVertices {
    return ELLIPSE_RESOLUTION;
}

-(void)updateVertices {
    for (int i = 0; i < ELLIPSE_RESOLUTION; i++){
        float theta = ((float)i) / ELLIPSE_RESOLUTION * M_TAU;
        self.vertices[i] = GLKVector2Make(cos(theta)*_radiusX, sin(theta)*_radiusY);
    }
}

-(float)radiusX {
    return _radiusX;
}

-(void)setRadiusX:(float)__radiusX {
    _radiusX = __radiusX;
    [self updateVertices];
}

-(float)radiusY {
    return _radiusY;
}

-(void)setRadiusY:(float)__radiusY {
    _radiusY = __radiusY;
    [self updateVertices];
}

@end
