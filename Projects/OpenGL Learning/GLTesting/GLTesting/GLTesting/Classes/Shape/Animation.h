//
//  Animation.h
//  GLTesting
//
//  Created by Andrew Apperley on 2013-07-17.
//  Copyright (c) 2013 Andrew Apperley. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseShape.h"
#import <GLKit/GLKit.h>

@interface Animation : NSObject

@property NSTimeInterval duration;
@property(readonly) NSTimeInterval elapsedTime;
@property GLKVector2 positonDelta, scaleDelta;
@property GLKVector4 colourDelta;
@property float roationDelta;
@property(nonatomic, retain) BaseShape *parent;

- (void)update:(NSTimeInterval)dt;
- (void)stopAnimation;
@end