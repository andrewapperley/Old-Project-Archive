//
//  RectangleShape.m
//  GLTesting
//
//  Created by Andrew Apperley on 2013-07-09.
//  Copyright (c) 2013 Andrew Apperley. All rights reserved.
//

#import "RectangleShape.h"

@implementation RectangleShape

@synthesize width = _width, height = _height;

-(int)numVertices {
    return 4;
}

-(void)updateVertices {
    self.vertices[0] = GLKVector2Make( _width/2.0, -_height/2.0);
    self.vertices[1] = GLKVector2Make( _width/2.0,  _height/2.0);
    self.vertices[2] = GLKVector2Make(-_width/2.0,  _height/2.0);
    self.vertices[3] = GLKVector2Make(-_width/2.0, -_height/2.0);
}

-(float)width {
    return _width;
}

-(void)setWidth:(float)__width {
    _width = __width;
    [self updateVertices];
}

-(float)height {
    return _height;
}

-(void)setHeight:(float)__height {
    _height = __height;
    [self updateVertices];
}

@end
