//
//  Scene.h
//  GLTesting
//
//  Created by Andrew Apperley on 2013-07-07.
//  Copyright (c) 2013 Andrew Apperley. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>

@interface Scene : NSObject

- (void)update:(NSTimeInterval)dt;
- (void)render;

@property GLKVector4 clearColor;
@property float left, right, top, bottom;
@property(readonly) GLKMatrix4 projectionMatrix;
@property(readonly, retain)NSMutableArray *objects;

@end
