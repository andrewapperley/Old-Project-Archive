//
//  Player.m
//  LegendOfTheShadowRealm
//
//  Created by Jeremy Fuellert on 2012-12-09.
//
//

#import "AttackNotification.h"
#import "Player.h"
#import "Database.h"
#import "Proc.h"

@implementation Player
@synthesize attackSpeed;
@synthesize currentWeaponType = _currentWeaponType;
@synthesize isAttacking = _isAttacking;

- (id)initWithOrigin:(CGPoint)frame andImage:(UIImage *)image
{
    self.uid = 01;
    
    self = [super initWithOrigin:frame andImage:image];
    if(self)
    {
        _isAttacking = FALSE;
        
        [self setCurrentWeaponType:[playerDatabase weaponType]];
        
        //Movement handling
        [self addListener:EVENT_PLAYER_ANIMATION_START andSel:@selector(startAnimationWalk:)];
        [self addListener:EVENT_PLAYER_ANIMATION_STOP andSel:@selector(stop)];
        
        //Health handling
        [self addListener:EVENT_PLAYER_HEALTH_GAIN andSel:@selector(healthIncreased:)];
        [self addListener:EVENT_PLAYER_HEALTH_LOSS andSel:@selector(healthDecreased:)];
        
        //Skills refresh
        [self addListener:EVENT_PLAYER_REFRESH_SKILLS_ACTIVE andSel:@selector(databaseRefreshSkills)];
        
        //Health regeneration
        [self addListener:EVENT_PLAYER_REFRESH_PASSIVE_REGEN andSel:@selector(databaseRefreshPassiveHealthRegen)];
        
        [self idle];
        [self initHealthRegenTimer];
        
        //Database refresh calls
        [self databaseRefreshSkills];
        [self databaseRefreshPassiveHealthRegen];
    }
    return self;
}

/*
 * Passive health regeneration
 */
- (void)initHealthRegenTimer
{
    [NSTimer scheduledTimerWithTimeInterval:10.0f target:self selector:@selector(tickPassiveHealthRenegeration) userInfo:nil repeats:YES];
}

- (void)databaseRefreshPassiveHealthRegen
{
    //Tick for a percentage of max health
    healthRegeneration = PLAYER_PASSIVE_HEALTH_REGENERATION * [playerDatabase health_max];
}

- (void)tickPassiveHealthRenegeration
{
    playerDatabase.health += healthRegeneration;
}

/*
 * Notifications
 */
- (void)healthIncreased:(NSNotification *)number
{
    int health = [(NSNumber *)[number object] intValue];
    NSString *healthString = [NSString stringWithFormat:@"%d", health];
    
    CGRect frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    
    AttackNotification *notification = [[AttackNotification alloc] initWithFrame:frame andText:healthString andType:Heal];
    
    [self addSubview:notification];
    [self destroy:notification];
}

- (void)healthDecreased:(NSNotification *)number
{
    int health = [(NSNumber *)[number object] intValue];
    NSString *healthString = [NSString stringWithFormat:@"%d", health];
    
    CGRect frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        
    AttackNotification *notification = [[AttackNotification alloc] initWithFrame:frame andText:healthString andType:DamageTaken];
    
    [self addSubview:notification];
    [self destroy:notification];
}

/*
 * Attack animation
 */
- (BOOL)isAttacking
{
    return _isAttacking;
}

- (void)attack
{    
//    [self setAction:ACTION_ATTACK];
    [self setNumberOfStates:3];
     self.attackSpeed = MAX(0, 1 - [playerDatabase speed] * BATTLE_SYSTEM_SPEED_SCALE);
        
    if(!_isAttacking)
    {
        _isAttacking = TRUE;

        if(![timer isValid] && timer == nil)
            timer = [NSTimer scheduledTimerWithTimeInterval:self.attackSpeed / self.numberOfStates target:self selector:@selector(incrementState) userInfo:nil repeats:TRUE];
        
        [self startAttackAnimation];
        [self performSelector:@selector(setNotAttacking) withObject:nil afterDelay:self.attackSpeed];
    }
}

- (void)startAttackAnimation
{
    [UIView animateWithDuration:self.attackSpeed animations:^{
        //TODO : Something
    }];
}

- (void)setNotAttacking
{
    _isAttacking = FALSE;
    [timer invalidate];
    timer = nil;
}

- (void)setCurrentWeaponType:(int)currentWeaponType
{
    _currentWeaponType = currentWeaponType;
    [playerDatabase setWeaponType:_currentWeaponType];
}

- (int)currentWeaponType
{
    return _currentWeaponType;
}

//COMMENT OUT WITH FINAL PLAYER ART
//- (void)refreshImage
//{
//    [self setImage:[UIImage imageNamed:Player_Image([self prefix],[self uid], [self currentWeaponType], [self direction], [self action], [self state])]];
//}

/*
 * Proc Handling (Active Skills)
 *
 * A skill proc is randomly started based on a percentage of that proc running.
 * Each time the player attacks there is a chance to proc a skill method.
 * There can only be on type of a specific skill allowed active at once.
 */
- (void)databaseRefreshSkills
{
    NSArray *activeSkillNames = [playerDatabase activeSkills];
    NSMutableArray *_activeSkills = [NSMutableArray new];
    
    if(activeSkillNames != nil && activeSkillNames.count > 0)
    {
        for(uint i = 0; i < activeSkillNames.count; i++)
        {
            Proc *proc = [[Proc alloc] initWithFrame:CGRectMake(self._width / 2, self._height / 2 + 8, 0, 0) andSkillName:(NSString *)[activeSkillNames objectAtIndex:i]];
            [_activeSkills addObject:proc];
            [self destroy:proc];
        }
    }
        
    self.activeSkills = [NSArray arrayWithArray:_activeSkills];
    [self destroy:_activeSkills];
}

/*
 * Proc directional handling
 */
- (void)setDirection:(uint)direction
{
    [super setDirection:direction];
    [self changeApplicableProcDirections];
    
}

- (void)changeApplicableProcDirections
{
    for(Proc *proc in self.activeSkills)
    {
        if(proc.isActive)
        {
            [proc changeDirection];
        }
    }
}

/*
 * Proc triggering
 */
- (void)tryForRandomProc
{   
    for(Proc *proc in self.activeSkills)
    {
        if(!proc.isActive)
        {
            if([proc tryForProc])
            {
                [self insertSubview:proc atIndex:0];
                [proc start];
            }            
        }
    }
}

- (void)stopAllProcs
{
    for(Proc *proc in self.activeSkills)
    {
        if(proc.isActive)
        {
            [proc stop];
        }
    }
}

- (void)kill
{
    //TODO : Handle Player Death
    NSLog(@"Player has died!");
//    
//    [UIView animateWithDuration:1.0f animations:^{
//        self.alpha = 0.0;
//        [self stopAllProcs];
//    } completion:^(BOOL finished) {
//        [self removeFromSuperview];
//    }];
}

- (NSString *)prefix
{
    return PREFIX_PLAYER_IMAGE;
}
- (void)dealloc
{
    [super dealloc];
}

@end
