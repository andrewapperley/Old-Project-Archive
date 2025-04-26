//
//  Animation.m
//  GLTesting
//
//  Created by Andrew Apperley on 2013-07-17.
//  Copyright (c) 2013 Andrew Apperley. All rights reserved.
//

#import "Animation.h"
#import "BaseShape.h"
@implementation Animation

@synthesize duration = _duration, elapsedTime = _elapsedTime, positonDelta = _positonDelta, parent = _parent;

- (id)init
{
    self = [super init];
    if(self)
    {
        _duration = 0;
        _elapsedTime = 0;
        _positonDelta = GLKVector2Make(0, 0);
    }
    return self;
}

- (void)update:(NSTimeInterval)dt
{
    _elapsedTime += dt;
    
    if (_elapsedTime > _duration)
        dt -= _elapsedTime - _duration;
    
    GLKVector2 positionIncrement = GLKVector2MultiplyScalar(_positonDelta, dt/_duration);
    _parent.position = GLKVector2Add(_parent.position, positionIncrement);
    
    GLKVector2 scaleIncrement = GLKVector2MultiplyScalar(_scaleDelta, dt/_duration);
    _parent.scale = GLKVector2Add(_parent.scale, scaleIncrement);
    
    GLKVector4 colourIncrement = GLKVector4MultiplyScalar(_colourDelta, dt/_duration);
    _parent.colour = GLKVector4Add(_parent.colour, colourIncrement);
    
    _parent.rotation += _roationDelta * dt;
    
    [self checkAnimation];
}

- (void)stopAnimation{
    [_parent popAnimation:self];
    return;
}

- (void)checkAnimation
{
    if(_elapsedTime > _duration){
        [self stopAnimation];
    }

}

- (void)dealloc
{
    [_parent release];
    _parent = nil;
    
    [super dealloc];
}

@end