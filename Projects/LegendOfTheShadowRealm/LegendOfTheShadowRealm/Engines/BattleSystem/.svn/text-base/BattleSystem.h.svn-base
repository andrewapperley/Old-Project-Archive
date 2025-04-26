//
//  BattleSystem.h
//  LegendOfTheShadowRealm
//
//  Created by Jeremy Fuellert on 2012-12-23.
//
//

#import "InteractionLayer.h"

@class LootTable;

@interface BattleSystem : InteractionLayer
{
    @private
    
    //Zone
    NSString *currentMapFile;
    
    NSString *currentZone;
    int currentZoneNumber;
    
    //Spawning
    uint checkForSpawnPixel;
    uint percentageToSpawn;
    int maxEnemiesAllowedOnScreen;
}

@property (nonatomic, retain) LootTable *lootTable;

- (id)initWithFrame:(CGRect)frame andMap:(NSString *)currentMap;
- (void)spawnNewEnemy:(Tile *)tile;

- (void)attackPlayerWithDamage:(NSNumber *)damage;
- (void)attackEnemy:(Enemy *)enemy withDamage:(NSNumber *)damage;
- (BOOL)checkIfPlayerIsFacingEnemyAndIsInRange:(Enemy *)lenemy;
- (void)killEnemy:(Enemy *)enemy;

@end
