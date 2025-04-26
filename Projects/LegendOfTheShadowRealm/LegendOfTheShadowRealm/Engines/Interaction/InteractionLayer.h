//
//  InteractionLayer.h
//  LegendOfTheShadowRealm
//
//  Created by Jeremy Fuellert on 2012-11-30.
//
//

#import "MapLayer.h"

@class Player;
@class BaseNPC;
@class Enemy;

@interface InteractionLayer : MapLayer
{
    @private
    NSMutableSet *_autoDestroySet;
    NSTimer *enemyNPCmovementCheckTimer;
}

@property (nonatomic, retain) Player *playerObject;
@property (nonatomic, retain) NSMutableSet *NPCs;
@property (nonatomic, retain) NSMutableSet *enemies;

- (void)createEnemy:(NSDictionary *)enemyData andTile:(Tile *)tile;
- (void)destroyEnemy:(Enemy *)enemy;

- (void)createNPC:(NSDictionary *)npcData;
- (void)destroyNPC:(BaseNPC *)npc;

@end