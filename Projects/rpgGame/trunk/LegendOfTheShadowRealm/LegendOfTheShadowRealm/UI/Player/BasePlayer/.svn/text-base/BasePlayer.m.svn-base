//
//  BasePlayer.m
//  LegendOfTheShadowRealm
//
//  Created by Jeremy Fuellert on 2012-12-10.
//
//

#import "BasePlayer.h"
#import "Database.h"
#import "ImageCacheUtil.h"

#define IMAGE_CACHE_LIMIT   50

@implementation BasePlayer

@synthesize uid;
@synthesize numberOfStates;
@synthesize prefix;
@synthesize action;

@synthesize boundsX;
@synthesize boundsY;
@synthesize speed;
@synthesize directionChangeTime;
@synthesize map;
@synthesize zone;

@synthesize isWalking = _isWalking;
@synthesize isRunning = _isRunning;
@synthesize activeSkills = _activeSkills;

- (id)initWithOrigin:(CGPoint)frame andImage:(UIImage *)image
{
    self = [super initWithOrigin:frame andImage:image];
    if (self) {
        
        self.userInteractionEnabled = FALSE;
        //Disables all animations
        self.layer.actions = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                              [NSNull null], @"onOrderIn",
                              [NSNull null], @"onOrderOut",
                              [NSNull null], @"sublayers",
                              [NSNull null], @"contents",
                              [NSNull null], @"bounds",
                              [NSNull null], @"frame",
                              [NSNull null], @"position",
                              nil];
        images = [NSMutableSet new];
        
        [self setImage:image];
        [self idle];
        
        _isWalking = FALSE;
        _isRunning = FALSE;
    }
    return self;
}

- (void)setActiveSkills:(NSArray *)activeSkills
{
    if(_activeSkills) [self destroy:_activeSkills];
    
    _activeSkills = [activeSkills retain];
}
- (NSArray *)activeSkills
{
    return _activeSkills;
}

- (void)setImage:(UIImage *)image
{
    [super setImage:image];
    
    self._width = image.size.width;
    self._height = image.size.height;
    self.imageLayer.frame = CGRectMake(0, 0, image.size.width, image.size.height);
}

@synthesize direction = _direction;
- (uint)direction
{
    return _direction;
}

- (void)setDirection:(uint)direction
{
    _direction = direction;
    [self refreshImage];
}

@synthesize state = _state;
- (int)state
{
    return _state;
}

- (void)setState:(int)state
{
    _state = state;
}

/*
 * Animation Handling
 */
- (void)startAnimationWalk:(id)lrun
{
    BOOL run = [[lrun object] boolValue];
    
    if(run)
    {
        if(!_isRunning)
        {
            if(_isWalking)
            {
                [self stop];
            }
            
            [self startRun];
        }
    } else
    {
        if(!_isWalking)
        {
            if(_isRunning)
            {
                [self stop];
            }
            
            [self startWalk];
        }
    }
}

- (void)startWalk
{
    if(![timer isValid] && timer == nil)
    {
        _isWalking = TRUE;
        _isRunning = FALSE;
        
        [self setAction:ACTION_WALKING];
        [self setNumberOfStates:3];
        
        timer = [NSTimer scheduledTimerWithTimeInterval:SPRITE_ANIMATION_WALK_DURATION target:self selector:@selector(incrementState) userInfo:nil repeats:YES];
    }
}

- (void)startRun
{
    if(![timer isValid] && timer == nil)
    {
        _isRunning = TRUE;
        _isWalking = FALSE;
        
        [self setAction:ACTION_WALKING];
        [self setNumberOfStates:3];
        
        timer = [NSTimer scheduledTimerWithTimeInterval:SPRITE_ANIMATION_RUN_DURATION target:self selector:@selector(incrementState) userInfo:nil repeats:YES];
    }
}

- (void)idle
{
    [self setAction:ACTION_IDLE];
    [self setDirection:Idle];
    [self stop];
}

- (void)stop
{
    [timer invalidate];
    timer = nil;

    [self setState:0];
    [self setNumberOfStates:1];
    [self refreshImage];

    _isWalking = FALSE;
    _isRunning = FALSE;
}

/*
 * Image State Handling
 */
- (void)refreshImage
{
    NSString *imageName = Enemy_NPC_Image([self prefix],[self uid], [self direction], [self action], [self state]);

    [self setImage:[ImageCacheUtil addImage:imageName toSet:images andCapacity:IMAGE_CACHE_LIMIT]];
}

- (void)incrementState
{    
    _state ++;
    if(_state == numberOfStates) _state = 0;
    [self refreshImage];
}

- (void)decrementState
{
    _state --;
    if(_state < 0) _state = numberOfStates;
    [self refreshImage]; 
}


- (void)dealloc
{
    [self stop];
    [self destroy:_activeSkills];
    [self destroy:map];
    [self destroy:zone];
    [self destroy:images];
    
    [super dealloc];
}

@end
