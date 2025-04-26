//
//  RegularPolygon.m
//  GLTesting
//
//  Created by Andrew Apperley on 2013-07-10.
//  Copyright (c) 2013 Andrew Apperley. All rights reserved.
//

#import "RegularPolygon.h"

@implementation RegularPolygon

@synthesize numSides = _numSides, radius = _radius;

-(id)initWithNumSides:(int)__numSides {
    self = [super init];
    if (self) {
        _numSides = __numSides;
    }
    return self;
}

-(int)numVertices {
    return _numSides;
}

-(void)updateVertices {
    for (int i = 0; i < _numSides; i++){
        float theta = ((float)i) / _numSides * M_TAU;
        self.vertices[i] = GLKVector2Make(cos(theta)*_radius, sin(theta)*_radius);
    }
}

-(float)radius {
    return _radius;
}

-(void)setRadius:(float)__radius {
    _radius = __radius;
    [self updateVertices];
}

@end