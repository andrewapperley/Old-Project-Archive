//
//  BaseEnemy.h
//  LegendOfTheShadowRealm
//
//  Created by Andrew Apperley on 2012-12-15.
//
//

#import "BaseAISystem.h"

@interface BaseEnemy : BaseAISystem
{
    @protected
    CGPoint boundsPosition;
}

@property (nonatomic, readonly) BOOL isFollowingPlayer;
@property (nonatomic, readonly) BOOL isAttackingPlayer;

@property (nonatomic, assign) float runSpeed;
@property (nonatomic, assign) float health;
@property (nonatomic, assign) float experience;
@property (nonatomic, assign) float strength;
@property (nonatomic, assign) float dexterity;
@property (nonatomic, assign) float stamina;
@property (nonatomic, assign) float speed;
@property (nonatomic, assign) float range;
@property (nonatomic, assign) float armor;
@property (nonatomic, assign) float minWeaponDamage;
@property (nonatomic, assign) float maxWeaponDamage;
@property (nonatomic, assign) float weaponStrength;

- (id)initWithOrigin:(CGPoint)frame andData:(NSDictionary *)data;
- (void)startMovement;
- (void)stopMovement;
- (void)setFollowing;

@end
