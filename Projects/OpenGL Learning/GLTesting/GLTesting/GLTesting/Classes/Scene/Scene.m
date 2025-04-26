//
//  Scene.m
//  GLTesting
//
//  Created by Andrew Apperley on 2013-07-07.
//  Copyright (c) 2013 Andrew Apperley. All rights reserved.
//

#import "Scene.h"
#import "BaseShape.h"
#import "SpriteSheetManager.h"
@implementation Scene

@synthesize clearColor = _clearColor, left = _left, right = _right, top = _top, bottom = _bottom, objects = _objects;

- (id)init
{
    self = [super init];
    if(self)
        _objects = [NSMutableArray new];
    
    SpriteSheetManager *testSheetManager = [SpriteSheetManager new];
    
    return self;
}

- (void)update:(NSTimeInterval)dt
{
    [_objects enumerateObjectsUsingBlock:^(BaseShape *o, NSUInteger idx, BOOL *stop)
    {
        [o update:dt];
    }];
}

-(void)render {
    glClearColor(_clearColor.r, _clearColor.g, _clearColor.b, _clearColor.a);
    glClear(GL_COLOR_BUFFER_BIT);
    
    [_objects makeObjectsPerformSelector:@selector(renderInScene:) withObject:self];
}

-(GLKMatrix4)projectionMatrix {
    return GLKMatrix4MakeOrtho(_left, _right, _bottom, _top, 1, -1);
}

- (void)dealloc
{
    [_objects release];
    _objects = nil;
    
    [super dealloc];
}
@end
