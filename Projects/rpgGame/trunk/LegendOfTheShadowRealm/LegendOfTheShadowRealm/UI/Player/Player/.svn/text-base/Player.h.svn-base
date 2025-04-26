//
//  Player.h
//  LegendOfTheShadowRealm
//
//  Created by Jeremy Fuellert on 2012-12-09.
//
//

#import "BasePlayer.h"

@interface Player : BasePlayer
{
    @public
    float healthRegeneration;
}

@property (nonatomic, assign) float attackSpeed;
@property (nonatomic, assign) int currentWeaponType;
@property (nonatomic, assign) BOOL isAttacking;

- (void)attack;
- (void)kill;

- (void)tryForRandomProc;
- (void)stopAllProcs;

@end
