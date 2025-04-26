//
//  Enemy.m
//  LegendOfTheShadowRealm
//
//  Created by Andrew Apperley on 2012-12-15.
//
//

#import "AttackNotification.h"
#import "Enemy.h"
#import "Database.h"
#import "ResourceBar.h"
#import "Shell.h"
@implementation Enemy
@synthesize attackSpeed;

- (id)initWithOrigin:(CGPoint)frame andData:(NSDictionary *)data
{
    self = [super initWithOrigin:frame andData:data];
    if(self)
    {
        self.attackSpeed = MAX(0, 1 - self.speed * BATTLE_SYSTEM_SPEED_SCALE);
        playerLevel = [playerDatabase level];
        isAttacking = FALSE;
        
        [self initHealthBar];
    }
    return self;
}

/*
 * Health bar
 */
- (void)initHealthBar
{
    //Make healthbar
    CGRect frame = CGRectMake(2, -6, self._width, 6);
    
    healthBar = [[ResourceBar alloc] initWithFrame:frame andMinValue:0.0 andMaxValue:self.health andCurrenValue:self.health andBackgroundImage:ASSET_VISUAL_ENEMY_HEALTH_BAR_BACKGROUND andFillImage:ASSET_VISUAL_ENEMY_HEALTH_BAR_FILL andFrameImage:ASSET_VISUAL_ENEMY_HEALTH_BAR_FRAME];
    
    [self addSubview:healthBar];
}

/*
 * Send attack event if the player is in range of the enemy
 */
- (void)attack
{
    if(!isAttacking)
    {
        isAttacking = TRUE;
        [self onAttack];

        float enemyMissChance = (BATTLE_SYSTEM_BASE_MISS_CHANCE * playerLevel) - (self.dexterity / (playerLevel / BATTLE_SYSTEM_GEAR_SCALE));
        
        BOOL canHit = arc4random_uniform(100) > enemyMissChance;
        
        if(canHit)
        {
            float minWeaponDamage = self.minWeaponDamage + (self.weaponStrength * BATTLE_SYSTEM_STRENGTH_SCALE);
            float maxWeaponDamage = self.maxWeaponDamage + (self.weaponStrength * BATTLE_SYSTEM_STRENGTH_SCALE);
                    
            float minDamage = (self.strength / BATTLE_SYSTEM_STRENGTH_SCALE) + minWeaponDamage;
            float maxDamage = (self.strength / BATTLE_SYSTEM_STRENGTH_SCALE) + maxWeaponDamage;
            	
            float randomBaseDamage = arc4random_uniform(maxDamage) + minDamage;	        
            float damage = MAX(0, randomBaseDamage - ([playerDatabase armor] / 4));
            
            [self sendEvent:EVENT_BATTLESYSTEM_ENEMY_ATTACK andObject:[NSNumber numberWithFloat:damage]];
        }
    }
}

- (void)onAttack
{
    [timer invalidate];
    timer = nil;
    
    [self startAttackAnimation];
    [self performSelector:@selector(setNotAttacking) withObject:nil afterDelay:self.attackSpeed];
}

- (void)setNotAttacking
{
    isAttacking = FALSE;
    [timer invalidate];
    timer = nil;
}

- (void)startAttackAnimation
{
    _isWalking = FALSE;
    _isRunning = FALSE;
    [self setAction:ACTION_ATTACK];
    [self setNumberOfStates:3];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:self.attackSpeed target:self selector:@selector(incrementState) userInfo:nil repeats:TRUE];
}

- (void)kill
{
    [UIView animateWithDuration:1.0f animations:^{
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        
        //Send Quest Event Notification
        [self sendEvent:EVENT_QUEST_KILL andObject:[NSNumber numberWithUnsignedLongLong:self.uid]];
    }];
}

- (void)hit:(NSNumber *)ldamage
{
    self.health -= [ldamage floatValue];

    healthBar.currentValue = self.health;
    
    int damage = [ldamage intValue];
    NSString *damageString = [NSString stringWithFormat:@"%d", damage];
    
    CGRect frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    
    AttackNotification *notification = [[AttackNotification alloc] initWithFrame:frame andText:damageString andType:DamageDealt];
    
    [self addSubview:notification];
    [self destroy:notification];
}

- (void)miss
{
    CGRect frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    
    AttackNotification *notification = [[AttackNotification alloc] initWithFrame:frame andText:@"Miss" andType:Miss];
    
    [self addSubview:notification];
    [self destroy:notification];
}

- (void)dealloc
{
    [timer invalidate];
    timer = nil;
    [self destroy:healthBar];
    
    [super dealloc];
}

@end
