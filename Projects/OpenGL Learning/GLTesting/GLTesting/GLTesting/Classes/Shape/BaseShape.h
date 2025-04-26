//
//  BaseShape.h
//  GLTesting
//
//  Created by Andrew Apperley on 2013-07-08.
//  Copyright (c) 2013 Andrew Apperley. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>
#import "Scene.h"

@class Animation;

#define M_TAU (2*M_PI)

@interface BaseShape : NSObject
{
    NSMutableData *vertexData;
    NSMutableData *vertexColourData;
    NSMutableData *textureCoordinateData;
    GLKBaseEffect *effect;
    GLKTextureInfo *texture;
    
    BOOL animatedOnce;
    
    //last animation changes
    GLKVector4 lastColour;
    GLKVector2 lastPosition;
    float lastRotation;
    GLKVector2 lastScale;
}

- (void)renderInScene:(Scene *)scene;
- (void)setTextureImage:(UIImage *)image;
- (void)addChild:(BaseShape *)child;
- (void)update:(NSTimeInterval)dt;
- (void)pushAnimation:(void (^)(void))animationBlock andDuration:(float)duration;
- (void)popAnimation:(Animation *)a;

@property(readonly) int numVertices;
@property(readonly) GLKVector2 *vertices;
@property(readonly) GLKVector4 *vertexColours;
@property GLKVector4 colour;
@property BOOL useConstantColour;
@property(readonly) GLKVector2 *textureCoordinates;
@property GLKVector2 position;
@property float rotation;
@property GLKVector2 scale;
@property(readonly, nonatomic, retain) NSMutableArray *children;
@property(nonatomic, retain) BaseShape *parent;
@property(readonly) GLKMatrix4 modelViewMatrix;
@property GLKVector2 velocity;
@property GLKVector2 acceleration;
@property float angularVelocity, angularAcceleration;
@property(nonatomic, retain, readonly) NSMutableArray *animations;
@end