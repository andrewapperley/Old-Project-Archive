//
//  BaseShape.m
//  GLTesting
//
//  Created by Andrew Apperley on 2013-07-08.
//  Copyright (c) 2013 Andrew Apperley. All rights reserved.
//

#import "BaseShape.h"
#import "Animation.h"

@implementation BaseShape


@synthesize colour = _colour, useConstantColour = _useConstantColour, vertexColours, textureCoordinates, position = _position, rotation = _rotation, scale = _scale, children = _children, parent = _parent, modelViewMatrix = _modelViewMatrix, velocity = _velocity, acceleration = _acceleration, angularVelocity = _angularVelocity, angularAcceleration = _angularAcceleration, animations = _animations;

- (id)init
{
    self = [super init];
    if (self)
    {
        _children = [NSMutableArray new];
        effect = [GLKBaseEffect new];
        _useConstantColour = TRUE;
        _colour = GLKVector4Make(1, 1, 1, 1);
        _scale = GLKVector2Make(1, 1);
        _position = GLKVector2Make(0,0);
        texture = nil;
        _rotation = 0;
        _animations = [NSMutableArray new];
        animatedOnce = FALSE;
    }
        
    return self;
}

-(int)numVertices {
    return 0;
}

- (GLKVector4 *)vertexColours {
    if (vertexColourData == nil)
        vertexColourData = [[NSMutableData dataWithLength:sizeof(GLKVector4)*self.numVertices] retain];
    return [vertexColourData mutableBytes];
}

-(void)renderInScene:(Scene *)scene {
    
    glEnable(GL_BLEND);
    glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
    
    if (_useConstantColour) {
        effect.useConstantColor = true;
        effect.constantColor = _colour;
    }
    
    if (texture) {
        effect.texture2d0.envMode = GLKTextureEnvModeReplace;
        effect.texture2d0.target = GLKTextureTarget2D;
        effect.texture2d0.name = texture.name;
    }
    
    
    effect.transform.projectionMatrix = scene.projectionMatrix;
    
    effect.transform.modelviewMatrix = self.modelViewMatrix;
    
    
    [effect prepareToDraw];
    
    glEnableVertexAttribArray(GLKVertexAttribPosition);
    glVertexAttribPointer(GLKVertexAttribPosition, 2, GL_FLOAT, GL_FALSE, 0, self.vertices);
    
    if (!_useConstantColour) {
        glEnableVertexAttribArray(GLKVertexAttribColor);
        glVertexAttribPointer(GLKVertexAttribColor, 4, GL_FLOAT, GL_FALSE, 0, self.vertexColours);
    }
    
    if (texture != nil) {
        glEnableVertexAttribArray(GLKVertexAttribTexCoord0);
        glVertexAttribPointer(GLKVertexAttribTexCoord0, 2, GL_FLOAT, GL_FALSE, 0, self.textureCoordinates);
    }
    
    glDrawArrays(GL_TRIANGLE_FAN, 0, self.numVertices);
    glDisableVertexAttribArray(GLKVertexAttribPosition);
    
    if(texture)
        glDisableVertexAttribArray(GLKVertexAttribTexCoord0);
    
    if (!_useConstantColour)
        glDisableVertexAttribArray(GLKVertexAttribColor);
    
    glDisable(GL_BLEND);
    
    [_children makeObjectsPerformSelector:@selector(renderInScene:) withObject:scene];

}

- (GLKMatrix4)modelViewMatrix
{
    GLKMatrix4 modelMatrix = GLKMatrix4Multiply(GLKMatrix4MakeTranslation(_position.x, _position.y, 0), GLKMatrix4MakeZRotation(_rotation));
    
    modelMatrix = GLKMatrix4Multiply(modelMatrix, GLKMatrix4MakeScale(_scale.x, _scale.y, 1));
    
    if (_parent != nil)
        modelMatrix = GLKMatrix4Multiply(_parent.modelViewMatrix, modelMatrix);
    
    return modelMatrix;
}

- (GLKVector2 *)vertices {
    if (!vertexData)
        vertexData = [[NSMutableData dataWithLength:sizeof(GLKVector2) *self.numVertices] retain];
    return [vertexData mutableBytes];
}

- (void)setTextureImage:(UIImage *)image
{
    NSError *error;
    texture = [[GLKTextureLoader textureWithCGImage:image.CGImage options:[NSDictionary dictionaryWithObject:[NSNumber numberWithBool:TRUE] forKey:GLKTextureLoaderOriginBottomLeft] error:&error] retain];
    if(error)
        NSLog(@"Issue with loading texture. %@",error);
}

- (GLKVector2 *)textureCoordinates {
    if (!textureCoordinateData)
        textureCoordinateData = [[NSMutableData dataWithLength:sizeof(GLKVector2)*self.numVertices] retain];
    return [textureCoordinateData mutableBytes];
}

- (void)addChild:(BaseShape *)child
{
    child.parent = self;
    
    [_children addObject:child];
}

- (void)update:(NSTimeInterval)dt
{
    if(_animations.count)
        [((Animation *)_animations[0]) update:dt];
    
    _angularVelocity += _angularAcceleration * dt;
    _rotation += _angularVelocity * dt;
    
    GLKVector2 changeInVelocity = GLKVector2MultiplyScalar(_acceleration, dt);
    _velocity = GLKVector2Add(_velocity, changeInVelocity);
    
    GLKVector2 distanceTraveled = GLKVector2MultiplyScalar(_velocity, dt);
    _position = GLKVector2Add(_position, distanceTraveled);
}

- (void)pushAnimation:(void (^)(void))animationBlock andDuration:(float)duration
{
    GLKVector4 currentColour = _colour;
    GLKVector2 currentPosition = _position;
    float currentRotation = _rotation;
    GLKVector2 currentScale = _scale;
    
    animationBlock();
    
    Animation *animation = [Animation new];
    animation.duration = duration;
    
    animation.positonDelta = GLKVector2Subtract(_position, animatedOnce ? lastPosition : currentPosition);
    animation.colourDelta = GLKVector4Subtract(_colour, animatedOnce ? lastColour : currentColour);
    animation.roationDelta = self.rotation - ( animatedOnce ? lastRotation : currentRotation);
    animation.scaleDelta = GLKVector2Subtract(_scale, animatedOnce ? lastScale : currentScale);
    
    [self saveAnimationChanges];
    
    _colour = currentColour;
    _position = currentPosition;
    _rotation = currentRotation;
    _scale = currentScale;
    
    [_animations addObject:animation];
    [animation setParent:self];
    
    [animation release];
    animation = nil;
    
    animatedOnce = TRUE;
}

- (void)saveAnimationChanges
{
    lastColour = _colour;
    lastPosition = _position;
    lastRotation = _rotation;
    lastScale = _scale;
}

- (void)popAnimation:(Animation *)a
{
    if(_animations.count)
        [_animations removeObjectIdenticalTo:a];
}

- (void)dealloc
{
    [vertexData release];
    vertexData = nil;
    
    [effect release];
    effect = nil;
    
    [vertexColourData release];
    vertexColourData = nil;
    
    [texture release];
    texture = nil;
    
    [textureCoordinateData release];
    textureCoordinateData = nil;
    
    [_children release];
    _children = nil;
    
    if(_parent){
        [_parent release];
        _parent = nil;
    }
    
    [_animations release];
    _animations = nil;
    
    [super dealloc];
}
@end
