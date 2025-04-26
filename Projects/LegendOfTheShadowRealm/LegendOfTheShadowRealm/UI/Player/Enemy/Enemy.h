//
//  Enemy.h
//  LegendOfTheShadowRealm
//
//  Created by Andrew Apperley on 2012-12-15.
//
//

#import "BaseEnemy.h"

@class ResourceBar;

@interface Enemy : BaseEnemy
{
    @private
    BOOL isAttacking;
    ResourceBar *healthBar;
    
    int playerLevel;
}

@property(nonatomic, assign)float attackSpeed;

- (void)attack;
- (void)hit:(NSNumber *)ldamage;
- (void)kill;
- (void)miss;

@end
