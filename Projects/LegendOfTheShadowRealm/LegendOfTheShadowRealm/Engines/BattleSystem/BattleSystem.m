//
//  BattleSystem.m
//  LegendOfTheShadowRealm
//
//  Created by Jeremy Fuellert on 2012-12-23.
//
//

#import "BattleSystem.h"
#import "Constants.h"
#import "Database.h"
#import "Enemy.h"
#import "LootTable.h"
#import "ZoneNotification.h"

@implementation BattleSystem
@synthesize lootTable;

- (id)initWithFrame:(CGRect)frame andMap:(NSString *)currentMap
{
    currentMapFile = [currentMap retain];
    currentZoneNumber = 0;
    percentageToSpawn = BATTLE_SYSTEM_SPAWN_PERCENT;
    maxEnemiesAllowedOnScreen = 0;
    checkForSpawnPixel = 0;
        
    [self addListener:EVENT_BATTLESYSTEM_ZONE_NEW andSel:@selector(refreshZoneName:)];
    [self addListener:EVENT_BATTLESYSTEM_ENEMY_ATTACK andSel:@selector(attackPlayer:)];
    [self addListener:EVENT_BATTLESYSTEM_ENEMY_KILL andSel:@selector(onEnemyKilled:)];
    [self addListener:EVENT_BATTLESYSTEM_PLAYER_ATTACK andSel:@selector(attackEnemy)];

    self = [super initWithFrame:frame];
    if(self)
    {
        lootTable = [LootTable new];
    }

    return self;
}

-(void)createLootTable
{
    [lootTable loadTableForZone:self.centerTile.zoneName];
}

/*
 * Zone refresh handling
 */
- (void)refreshZoneName:(NSNotification *)notification
{
    int zoneNumber = [(NSNumber *)[notification object] intValue];
    
    if(currentZoneNumber != zoneNumber)
    {
        
        //If the map file is different then the current the load a new map from shell, otherwise show new zone ui
        NSString *newMapFile = [[[mapDatabase mapFromRowId:zoneNumber] retain] autorelease];
        
        currentZoneNumber = zoneNumber;
        
        //Send Quest Event Notification
        [self sendEvent:EVENT_QUEST_DISCOVER andObject:[NSNumber numberWithUnsignedLongLong:currentZoneNumber]];
        
        [playerDatabase setCurrentMap:newMapFile];
        [self destroy:currentZone];
        currentZone = [[mapDatabase zoneFromRowId:currentZoneNumber] retain];


        if(![currentMapFile isEqualToString:newMapFile])
        {
            [self destroy:currentMapFile];
            currentMapFile = [newMapFile retain];
            [self loadNewMap:newMapFile];
        }
        
        //Load new loot table
        [lootTable loadTableForZone:currentZoneNumber];
        
        maxEnemiesAllowedOnScreen = [mapDatabase enemiesAllowedPerScreenFromZone:currentZone];
        [self popZoneChangeNotification];
    }
}

- (void)loadNewMap:(NSString *)mapFile
{
    [[Shell shell] loadNewMap:mapFile];
}

//UI pop-up for entering a different zone
- (void)popZoneChangeNotification
{
    [self sendEventOnce:EVENT_NOTIFICATION_ZONE_ENETERED andObject:currentZone];
}

/*
 * Enemy spawning
 */
- (void)refreshTile:(Tile *)tile
{
    [super refreshTile:tile];
    
    checkForSpawnPixel ++;
    
    if(checkForSpawnPixel >= TILE_WIDTH)
    {
        [self checkForNewSpawns:tile];
        checkForSpawnPixel = 0;
    }
}

- (int)enemiesOnScreen
{
    return self.enemies ? [self.enemies count] : 0;
}

- (void)checkForNewSpawns:(Tile *)tile
{
    if([self enemiesOnScreen] >= maxEnemiesAllowedOnScreen) return;
        
    percentageToSpawn = MIN(percentageToSpawn += BATTLE_SYSTEM_SPAWN_INCREMENT, 100);

    BOOL canSpawn = (uint)arc4random_uniform(100) <= percentageToSpawn;
    
    if(canSpawn && tile.walkable && tile.imageId > 0)
        [self spawnNewEnemy:tile];
}

- (void)spawnNewEnemy:(Tile *)tile
{
    //Select a random enemy from the current zone to create
    NSArray *enemiesArray = [[enemyDatabase enemiesFromZone:currentZone] retain];
    
    uint randomEnemyEntry = (uint)arc4random_uniform([enemiesArray count]);
    NSDictionary *enemyToCreate = [[enemiesArray objectAtIndex:randomEnemyEntry] retain];
    
    [self createEnemy:enemyToCreate andTile:tile];
    [self destroy:enemyToCreate];
    [self destroy:enemiesArray];
    percentageToSpawn -= BATTLE_SYSTEM_SPAWN_INCREMENT;
}

/*
 * Enemy attack
 */
- (void)attackPlayer:(NSNotification *)damage
{
    [self attackPlayerWithDamage:(NSNumber *)[damage object]];
}

- (void)attackPlayerWithDamage:(NSNumber *)damage
{
    float damageDone = [damage floatValue];
    playerDatabase.health -= damageDone;
    
    
    if(playerDatabase.health <= 0.0f)
    {
        [self.playerObject kill];
    }
}

/*
 * Player attack
 */
- (void)attackEnemy
{    
    //Calculate player damage
    if(!self.playerObject.isAttacking && [self enemiesOnScreen] > 0)
    {
        [self.playerObject attack];
        int playerLevel = [playerDatabase level];
        float dexterity = [playerDatabase dexterity];
        
        float playerMissChance = (BATTLE_SYSTEM_BASE_MISS_CHANCE * playerLevel) - (dexterity / (playerLevel / BATTLE_SYSTEM_GEAR_SCALE));
        
        NSSet *enemiesSet = [[NSSet alloc] initWithSet:self.enemies];
        
        if(enemiesSet && enemiesSet.count > 0)
        {
            for(Enemy *enemy in enemiesSet)
            {
                Enemy *_enemy = [enemy retain];
                
                //Check if the enemy can be hit, if they are in range, and if the player is facing them
                BOOL canHit = arc4random_uniform(100) > playerMissChance;
                BOOL canAttack = [self checkIfPlayerIsFacingEnemyAndIsInRange:enemy];
                
                /*
                 * Generate attack damage
                 */
                if(canAttack)
                {
                    if(canHit)
                    {
                        float weaponStrength = [playerDatabase weaponStrength];
                        float strength = [playerDatabase strength];
                        
                        float minWeaponDamage = [playerDatabase minWeaponDamage] + (weaponStrength * BATTLE_SYSTEM_STRENGTH_SCALE);
                        float maxWeaponDamage = [playerDatabase maxWeaponDamage] + (weaponStrength * BATTLE_SYSTEM_STRENGTH_SCALE);
                        
                        float minDamage = (strength / BATTLE_SYSTEM_STRENGTH_SCALE) + minWeaponDamage;
                        float maxDamage = (strength / BATTLE_SYSTEM_STRENGTH_SCALE) + maxWeaponDamage;
                        
                        float randomBaseDamage = arc4random_uniform(maxDamage) + minDamage;
                        float damage = MAX(0, randomBaseDamage - ([_enemy armor] / 4));
                        
                        [self attackEnemy:_enemy withDamage:[NSNumber numberWithFloat:damage]];
                        [self.playerObject tryForRandomProc];
                    } else {
                        [_enemy miss];
                    }
                    
                    [self destroy:_enemy];
                    
                    //Make sure only one enemy capable of being attacked is attacked at a time
                    break;
                }
                [self destroy:_enemy];
            }
        }
        [self destroy:enemiesSet];
    }
}

- (BOOL)checkIfPlayerIsFacingEnemyAndIsInRange:(Enemy *)lenemy
{
    if(!lenemy) return FALSE;
    
    Enemy *enemy = [lenemy retain];
    float enemyX = enemy._x;
    float enemyY = enemy._y;
    float enemyWidth = enemy._width;
    float playerX = self.playerObject._x;
    float playerY = self.playerObject._y;
    float playerWidth = self.playerObject._width;
    float playerHeight = self.playerObject._height;
    float range = [playerDatabase range] * TILE_WIDTH;
    BOOL canAttack = FALSE;
    
    switch (self.playerObject.direction)
    {
        /*
         * First line of each statement checks for general position
         * Secnod line of each statement checks for position within tile range and player position 
         * Third line of each statement checks for the counter co-ordinate to fit the direction
         *
         * TILE_WIDTH is added to N, S, E, W to make an attack buffer area
         */
        
        case NorthWest:
            canAttack = enemyX < playerX &&
                        enemyX + enemyWidth + range + BUFFER > playerX &&
                        enemyY < playerY && enemyY + range + BUFFER > playerY;
            break;
        case North:
            canAttack = enemyX >= playerX - TILE_WIDTH && enemyX - enemyWidth + TILE_WIDTH <= playerX + playerWidth &&
                        enemyY < playerY && enemyY + range + BUFFER > playerY;
            break;
        case NorthEast:
            canAttack = enemyX > playerX + playerWidth &&
                        enemyX - range - BUFFER < playerX &&
                        enemyY < playerY && enemyY + range + BUFFER > playerY;
            break;
        case West:
            canAttack = enemyX < playerX &&
                        enemyX + enemyWidth + range + BUFFER > playerX &&
                        enemyY >= playerY - TILE_HEIGHT && enemyY <= playerY + playerHeight + TILE_HEIGHT;
            break;
        case East:
            canAttack = enemyX > playerX + playerWidth &&
                        enemyX - range - BUFFER < playerX + playerWidth &&
                        enemyY >= playerY - TILE_HEIGHT && enemyY <= playerY + playerHeight + TILE_HEIGHT;
            break;
        case SouthWest:
            canAttack = enemyX < playerX &&
                        enemyX + enemyWidth + range + BUFFER > playerX &&
                        enemyY > playerY && enemyY - range - BUFFER < playerY;
            break;
        case South:
        case Idle:
            canAttack = enemyX >= playerX - TILE_WIDTH && enemyX - enemyWidth + TILE_WIDTH <= playerX + playerWidth &&
                        enemyY > playerY && enemyY - range - BUFFER < playerY;
            break;
        case SouthEast:
            canAttack = enemyX > playerX + playerWidth &&
                        enemyX - range - BUFFER < playerX &&
                        enemyY > playerY && enemyY - range - BUFFER < playerY;
            break;
    }
    
    [self destroy:enemy];
    
    return canAttack;
}

- (void)attackEnemy:(Enemy *)enemy withDamage:(NSNumber *)damage
{
    if(enemy)
        [enemy hit:damage];
}

/*
 * Kill enemy
 */
- (void)onEnemyKilled:(NSNotification *)enemy
{
    [self killEnemy:(Enemy *)[enemy object]];
}

- (void)killEnemy:(Enemy *)enemy
{
    if(enemy)
    {
        Enemy *_enemy = [enemy retain];
        [_enemy kill];
        [self destroyEnemy:_enemy];
        [lootTable tryForReward];
    }
        
    if([self enemiesOnScreen] < maxEnemiesAllowedOnScreen)
    {
        percentageToSpawn = MIN(percentageToSpawn += BATTLE_SYSTEM_SPAWN_INCREMENT, 100);
    }
}

- (void)dealloc
{
    [self destroy:currentZone];
    [self destroy:currentMapFile];
    [self destroy:lootTable];
    
    [super dealloc];
}

@end
