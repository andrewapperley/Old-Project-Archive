//
//  BaseEnemy.m
//  LegendOfTheShadowRealm
//
//  Created by Andrew Apperley on 2012-12-15.
//
//

#import "BaseEnemy.h"

@implementation BaseEnemy
@synthesize isFollowingPlayer = _isFollowingPlayer;
@synthesize runSpeed;
@synthesize health;
@synthesize experience;
@synthesize strength;
@synthesize dexterity;
@synthesize stamina;
@synthesize speed;
@synthesize range;
@synthesize armor;
@synthesize minWeaponDamage;
@synthesize maxWeaponDamage;
@synthesize weaponStrength;

- (id)initWithOrigin:(CGPoint)frame andData:(NSDictionary *)data
{
    self = [super initWithOrigin:frame andImage:nil];
    if (self) {
        self.userInteractionEnabled = FALSE;
        _isFollowingPlayer = FALSE;
        boundsPosition = CGPointZero;
        
        [self setData:data];
    }
    
    return self;
}

- (void)setData:(NSDictionary *)ldictionary
{
    NSDictionary *dictionary = [ldictionary retain];
    
    self.uid = (unsigned long long)[(NSNumber *)[dictionary objectForKey:@"uid"] unsignedLongLongValue];
    self.boundsX = (int)[(NSNumber *)[dictionary objectForKey:@"boundsX"] intValue];
    self.boundsY = (int)[(NSNumber *)[dictionary objectForKey:@"boundsY"] intValue];
    self.speed = (float)[(NSNumber *)[dictionary objectForKey:@"speed"] floatValue];
    self.directionChangeTime = (float)[(NSNumber *)[dictionary objectForKey:@"directionChangeTime"] floatValue];
    self.map = [(NSString *)[dictionary objectForKey:@"map"] retain];
    self.zone = [(NSString *)[dictionary objectForKey:@"zone"] retain];
    self.radius = (float)[(NSNumber *)[dictionary objectForKey:@"radius"] floatValue];
    self.runSpeed = (float)[(NSNumber *)[dictionary objectForKey:@"runSpeed"] floatValue];
    self.health = (float)[(NSNumber *)[dictionary objectForKey:@"health"] floatValue];
    self.experience = (float)[(NSNumber *)[dictionary objectForKey:@"experience"] floatValue];
    self.strength = (float)[(NSNumber *)[dictionary objectForKey:@"strength"] floatValue];
    self.dexterity = (float)[(NSNumber *)[dictionary objectForKey:@"dexterity"] floatValue];
    self.stamina = (float)[(NSNumber *)[dictionary objectForKey:@"stamina"] floatValue];
    self.speed = (float)[(NSNumber *)[dictionary objectForKey:@"speed"] floatValue];
    self.range = (float)[(NSNumber *)[dictionary objectForKey:@"radius"] floatValue];
    self.armor = (float)[(NSNumber *)[dictionary objectForKey:@"armor"] floatValue];
    self.activeSkills = (NSArray *)[dictionary objectForKey:@"activeSkills"];
    self.minWeaponDamage = (float)[(NSNumber *)[dictionary objectForKey:@"minWeaponDamage"] floatValue];
    self.maxWeaponDamage = (float)[(NSNumber *)[dictionary objectForKey:@"maxWeaponDamage"] floatValue];
    self.weaponStrength = (float)[(NSNumber *)[dictionary objectForKey:@"weaponStrength"] floatValue];
    
    [self destroy:dictionary];
    
    //Set default image
    NSString *imageName = Enemy_NPC_Image(self.prefix, self.uid, self.direction, ACTION_IDLE, 0);
    UIImage *image = [UIImage imageNamed:imageName];
    [self setImage:image];
}

- (void)startMovement
{
    [self stop];
    [self changeRandomDirection];
    
    if(self.speed >= MAX_VELOCITY || self.speed <= - MAX_VELOCITY)
        [self startRun];
    else
        [self startWalk];
}

- (void)stopMovement
{
    movePoint.x = 0.0f;
    movePoint.y = 0.0f;
}

- (void)startWalk
{
    _isWalking = TRUE;
    _isRunning = FALSE;
    [self setAction:ACTION_WALKING];
    [self setNumberOfStates:3];
    
    if(![timer isValid] && timer == nil)
    {
        timer = [NSTimer scheduledTimerWithTimeInterval:SPRITE_ANIMATION_WALK_DURATION target:self selector:@selector(incrementState) userInfo:nil repeats:YES];
        
        timer = [NSTimer scheduledTimerWithTimeInterval:SPRITE_ANIMATION_WALK_DURATION target:self selector:@selector(moveEnemy) userInfo:nil repeats:YES];
        
        timer = [NSTimer scheduledTimerWithTimeInterval:self.directionChangeTime target:self selector:@selector(changeRandomDirection) userInfo:nil repeats:YES];
    }
}

- (void)startRun
{
    _isRunning = TRUE;
    _isWalking = FALSE;
    [self setAction:ACTION_WALKING];
    [self setNumberOfStates:3];
    
    if(![timer isValid] && timer == nil)
    {
        timer = [NSTimer scheduledTimerWithTimeInterval:SPRITE_ANIMATION_RUN_DURATION target:self selector:@selector(incrementState) userInfo:nil repeats:YES];
        
        timer = [NSTimer scheduledTimerWithTimeInterval:SPRITE_ANIMATION_RUN_DURATION target:self selector:@selector(moveEnemy) userInfo:nil repeats:YES];
        
        timer = [NSTimer scheduledTimerWithTimeInterval:self.directionChangeTime target:self selector:@selector(changeRandomDirection) userInfo:nil repeats:YES];
    }
}

- (void)setFollowing
{
    _isFollowingPlayer = TRUE;
}

- (void)moveEnemy
{
    if(self.isBlockedByPlayer) return;
    
    if(!_isFollowingPlayer)
    {
        if(![self isOkayToMoveInBounds])
        {
            [self changeRandomDirection];
            return;
        }
    } else {
        
        if(self.isRunning || self.isWalking)
        {
            [timer invalidate];
            timer = nil;
        }
                
        if(self._x + self._width > PLAYER_POINT.x + (TILE_WIDTH / 2))
            movePoint.x = self.speed;
        
        else if(self._x < PLAYER_POINT.x - (TILE_WIDTH / 2))
            movePoint.x = - self.speed;
        
        if(self._y + self._height > PLAYER_POINT.y + (TILE_WIDTH / 2))
            movePoint.y = self.speed;
        
        else if(self._y < PLAYER_POINT.y - (TILE_WIDTH / 2))
            movePoint.y = - self.speed;
        
        if(self._x == PLAYER_POINT.x - TILE_WIDTH ||
           self._x + self._width == PLAYER_POINT.x)
            movePoint.x = 0.0f;
        
        if(self._y == PLAYER_POINT.y - TILE_WIDTH ||
           self._y + self._height == PLAYER_POINT.y)
            movePoint.y = 0.0f;
    }
    
    //Send move event to Interaction Layer
    NSDictionary *sendValues = [NSDictionary dictionaryWithObjectsAndKeys:self, @"enemy", [NSValue valueWithCGPoint:CGPointMake(movePoint.x, movePoint.y)], @"move", nil];
    
    [self sendEventOnce:EVENT_ENEMY_ANIMATION_MOVED andObject:sendValues];
}

- (BOOL)isOkayToMoveInBounds
{
    if(boundsPosition.x + movePoint.x > self.boundsX * TILE_WIDTH ||
       boundsPosition.y + movePoint.y > self.boundsY * TILE_HEIGHT ||
       boundsPosition.x + movePoint.x < 0 ||
       boundsPosition.y + movePoint.y < 0)
    {
        return FALSE;
    }
    
    boundsPosition.x += movePoint.x;
    boundsPosition.y += movePoint.y;
    
    return TRUE;
}

/*
 * Send death event if health is <= 0
 */
- (void)setHealth:(float)lhealth
{
    health = lhealth;
    [self checkHealth];
}

- (void)checkHealth
{
    if(self.health <= 0.0f)
    {
        [self sendEvent:EVENT_BATTLESYSTEM_ENEMY_KILL andObject:self];
    }
}

- (NSString *)prefix
{
    return PREFIX_ENEMY_IMAGE;
}


@end