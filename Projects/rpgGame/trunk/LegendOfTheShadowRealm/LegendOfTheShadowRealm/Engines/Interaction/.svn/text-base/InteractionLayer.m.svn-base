//
//  InteractionLayer.m
//  LegendOfTheShadowRealm
//
//  Created by Jeremy Fuellert on 2012-11-30.
//
//

#import "Constants.h"
#import "Enemy.h"
#import "InteractionLayer.h"
#import "BaseNPC.h"
#import "MapLoader.h"
#import "Database.h"

#define DEFAULT_IMAGE_STRING Enemy_NPC_Image(PREFIX_PLAYER_IMAGE,(unsigned long long)1, South, ACTION_WALKING, 0)
#define BUFFER 4

@implementation InteractionLayer
@synthesize playerObject;
@synthesize NPCs;
@synthesize enemies;

- (void)generateInitialMap
{
    [super generateInitialMap];
    [self addListener:EVENT_NPC_ANIMATION_MOVED andSel:@selector(NPCTryMove:)];
    [self addListener:EVENT_ENEMY_ANIMATION_MOVED andSel:@selector(EnemyTryMove:)];
    [self addListener:EVENT_INTERACT_WITH_NPC andSel:@selector(checkNPCSNear:)];

    [self initPlayer];
    
    [self insertSubview:tileForeGroundContainer aboveSubview:self.playerObject];
    
    NPCs = [NSMutableSet new];
    enemies = [NSMutableSet new];
    _autoDestroySet = [NSMutableSet new];
    
     [self addListener:EVENT_NPC_CREATE andSel:@selector(initNPC:)];
    
    for (Tile *tile in currentTiles) {
        [self checkForNPCS:tile];
    }
    
   
}

-(void)checkNPCSNear:(UIEvent *)e
{
    for (BaseNPC *npc in NPCs) {
 
        [self checkPlayerNearNPCInteraction:npc andTileSize:self.playerObject.radius];
        
        if(npc.isBlockedByPlayer && !npc.inConversation && !self.playerObject.isAttacking)
            [self sendEvent:[NSString stringWithFormat:@"%@_%lld",EVENT_INTERACT_WITH_NPC,npc.uid]];
    }
}

//TEMP METHOD
- (void)initNPC:(NSNotification *)data
{
    NSDictionary *npcData = [(NSDictionary *)(NSDictionary *)[data object] retain];

    [self createNPC:npcData];
    [self destroy:npcData];
}


- (void)initPlayer
{
    UIImage *defaultImage = [UIImage imageNamed:DEFAULT_IMAGE_STRING];
    self.playerObject = [[Player alloc] initWithOrigin:PLAYER_POINT andImage:defaultImage];
    [self addSubview:self.playerObject];
}


/*
 * Add and Removal Handling for Enemy and NPC Objects
 */
- (void)createEnemy:(NSDictionary *)enemyData andTile:(Tile *)tile
{
    NSDictionary *data = [enemyData retain];
    
    /*
     * Use an out of bounds point to spawn
     * This spawn area should be in the tile buffer which the player is facing
     * This spawn area also has to check for tile ineraction to spawn correctly
     * If all tiles are blocked no spawn will occur
     */
    
    float enemyPointX = tile._x;
    float enemyPointY = tile._y;

    CGPoint enemyPoint = CGPointMake(enemyPointX, enemyPointY);
    Enemy *enemy = [[Enemy alloc]initWithOrigin:enemyPoint andData:data];
    
    [enemy startMovement];
    
    [self insertSubview:enemy belowSubview:playerObject];
    [enemies addObject:enemy];
    
    [self startEnemyNPCmovementCheckTimer];
    
    [self destroy:enemy];
    [self destroy:data];
}

- (void)createNPC:(NSArray *)npcData
{
    NSDictionary *data = [[npcData objectAtIndex:0] retain];
    
    BaseNPC *npc = [[BaseNPC alloc]initWithOrigin:CGPointMake([(Tile *)[npcData objectAtIndex:1] _x], [(Tile *)[npcData objectAtIndex:1] _y]) andData:data];
    
    [npc startMovement];
    
    [self insertSubview:npc belowSubview:playerObject];
    [NPCs addObject:npc];
    
    [self startEnemyNPCmovementCheckTimer];
    
    [self destroy:npc];
    [self destroy:data];
}

- (void)destroyEnemy:(Enemy*)enemy
{
    if(enemies && enemies.count > 0)
    {
        if([enemies member:enemy] != nil)
        {
            [enemies removeObject:enemy];
            [self destroy:enemy];
        }
    }
    
    [self destroy:enemy];
    [self endEnemyNPCmovementCheckTimer];
}

- (void)destroyNPC:(BaseNPC *)npc
{
    if(NPCs && NPCs.count > 0)
    {
        if([NPCs member:npc] != nil)
        {
            [NPCs removeObject:npc];
            [self destroy:npc];
        }
    }
    [self destroy:npc];
    
    [self endEnemyNPCmovementCheckTimer];
}

- (void)startEnemyNPCmovementCheckTimer
{
    if(![enemyNPCmovementCheckTimer isValid] && enemyNPCmovementCheckTimer == nil)
        enemyNPCmovementCheckTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(enemyNPCmovementCheck) userInfo:nil repeats:YES];
}

- (void)endEnemyNPCmovementCheckTimer
{
    if(NPCs.count == 0 && enemies.count == 0)
    {
        [enemyNPCmovementCheckTimer invalidate];
        enemyNPCmovementCheckTimer = nil;
    }
}

//This is here to check if an npc / enemy can move based on player position changes
- (void)enemyNPCmovementCheck
{
    if(NPCs.count > 0)
    {
        for(BaseNPC *npc in NPCs)
        {
            [self checkPlayerNearNPCInteraction:npc andTileSize:npc.radius];
            if(!npc.isBlockedByPlayer)
            {
                if(!npc.isRunning && !npc.isWalking)
                    [npc changeRandomDirection];
            }
        }
    }
    
    if(enemies.count > 0)
    {
        for(Enemy *enemy in enemies)
        {
            [self checkPlayerNearEnemyInteraction:enemy andTileSize:enemy.radius];
            [self checkEnemyAttackInteraction:enemy andRange:enemy.range];
            if(!enemy.isBlockedByPlayer)
            {
                if(!enemy.isFollowingPlayer)
                {
                    if(!enemy.isRunning && !enemy.isWalking)
                        [enemy changeRandomDirection];
                }
            }
        }
    }
}

/*
 * Player Movement Handling
 */
- (void)moveMapWithPoint:(CGPoint)point
{
    CGPoint pointToMove = [self defineInteraction:point andObjectFrame:self.playerObject.frame];
    pointToMove = [self setPlayerToNPCMovementInteraction: pointToMove];
    pointToMove = [self setPlayerToEnemyMovementInteraction: pointToMove];
    
    [super moveMapWithPoint:pointToMove];
}

- (CGPoint)defineInteraction:(CGPoint)point andObjectFrame:(CGRect)frame
{
    for(Tile *tile in currentTiles)
    {
        if(!tile.walkable)
        {
            CGPoint tilePoint = tile.frame.origin;
            
            //Block
            if(tile.blocked)
            {
                point = [self checkTypeBlocked:tilePoint andPoint:point andObjectFrame:frame];
            }
            //Exit House
            else if (tile.exitHouse)
            {
                //do nothing
            }
            //Water
            else if (tile.water)
            {
                point = [self checkTypeWater:tilePoint andPoint:point andObjectFrame:frame];
            }
            //Enter house
            else if (tile.enterHouse)
            {
                //do nothing
            }
            //Flamable
            else if (tile.flameable)
            {
                point = [self checkTypeFlamable:tilePoint andPoint:point andObjectFrame:frame];
            }
        }
    }
    return point;
}

- (CGPoint)setPlayerToNPCMovementInteraction:(CGPoint)point
{
    if(NPCs.count > 0)
    {
        for(BaseNPC *npc in NPCs)
        {        
            CGRect frame = npc.frame;
            
            BOOL blockN = frame.origin.y < playerObject.frame.origin.y &&
            frame.origin.y + frame.size.height + BUFFER > playerObject.frame.origin.y &&
            frame.origin.x + frame.size.width > playerObject.frame.origin.x - BUFFER &&
            frame.origin.x + BUFFER < playerObject.frame.origin.x + playerObject.frame.size.width;
            
            BOOL blockS = frame.origin.y > playerObject.frame.origin.y &&
            frame.origin.y < playerObject.frame.origin.y + playerObject.frame.size.height + BUFFER &&
            frame.origin.x + frame.size.width > playerObject.frame.origin.x - BUFFER &&
            frame.origin.x + BUFFER < playerObject.frame.origin.x + playerObject.frame.size.width;
            
            BOOL blockW = frame.origin.x < playerObject.frame.origin.x &&
            frame.origin.x + frame.size.width + BUFFER > playerObject.frame.origin.x &&
            frame.origin.y + frame.size.height > playerObject.frame.origin.y - BUFFER &&
            frame.origin.y + BUFFER < playerObject.frame.origin.y + playerObject.frame.size.height;
            
            BOOL blockE = frame.origin.x > playerObject.frame.origin.x + playerObject.frame.size.width &&
            frame.origin.x < playerObject.frame.origin.x + playerObject.frame.size.width + BUFFER &&
            frame.origin.y + frame.size.height > playerObject.frame.origin.y - BUFFER &&
            frame.origin.y + BUFFER < playerObject.frame.origin.y + playerObject.frame.size.height;
            
            //Handle points based on blocks
            if(blockN)
                if(point.y != 0.0)
                    point.y = MAX(point.y , 0.0);
            
            if(blockS)
                if(point.y != 0.0)
                    point.y = MIN(point.y , 0.0);
            
            if(blockW)
                if(point.x != 0.0)
                    point.x = MAX(point.x , 0.0);
            
            if(blockE)
                if(point.x != 0.0)
                    point.x = MIN(point.x , 0.0);
            
            if(blockN || blockW || blockW || blockE)
            {
                [npc stop];
                [npc setOpposingDirectionToPlayer:playerObject];
            }
        }
    }
    return point;
}

- (CGPoint)checkTypeBlocked:(CGPoint)tile andPoint:(CGPoint)point andObjectFrame:(CGRect)frame
{
    //The first line of each Boolean is to check whether or not the player is in south, north, east, or west of a tile.
    //The second line is to compare their position in relation to the buffer and sizing.
    //The third line is to compare the exact size of the tile to make sure only individual tiles are targeted
    BOOL blockN = frame.origin.y > tile.y &&
                frame.origin.y < tile.y + TILE_HEIGHT + BUFFER &&
                frame.origin.x + frame.size.width > tile.x - BUFFER && frame.origin.x + BUFFER < tile.x + TILE_WIDTH;
    
    BOOL blockS = frame.origin.y < tile.y &&
                frame.origin.y + frame.size.height > tile.y - BUFFER &&
                frame.origin.x + frame.size.width > tile.x - BUFFER && frame.origin.x + BUFFER < tile.x + TILE_WIDTH;
    
    BOOL blockW = frame.origin.x + BUFFER > tile.x + TILE_WIDTH &&
                frame.origin.x < tile.x + TILE_WIDTH + BUFFER &&
                frame.origin.y + frame.size.height > tile.y - BUFFER && frame.origin.y + BUFFER < tile.y + TILE_HEIGHT;
    
    BOOL blockE = frame.origin.x + frame.size.width + BUFFER > tile.x &&
                frame.origin.x < tile.x + BUFFER &&
                frame.origin.y + frame.size.height > tile.y - BUFFER && frame.origin.y + BUFFER < tile.y + TILE_HEIGHT;

    //Handle points based on blocks
    if(blockN)
        if(point.y != 0.0)
            point.y = MAX(point.y , 0.0);
    
    if(blockS)
        if(point.y != 0.0)
            point.y = MIN(point.y , 0.0);
    
    if(blockW)
        if(point.x != 0.0)
            point.x = MAX(point.x , 0.0);
    
    if(blockE)
        if(point.x != 0.0)
            point.x = MIN(point.x , 0.0);
    
    return point;
}

- (CGPoint)checkTypeWarpPoint:(CGPoint)tile andPoint:(CGPoint)point andObjectFrame:(CGRect)frame
{
    return point;
}

- (CGPoint)checkTypeWater:(CGPoint)tile andPoint:(CGPoint)point andObjectFrame:(CGRect)frame
{
    return point;
}

- (CGPoint)checkTypeFlamable:(CGPoint)tile andPoint:(CGPoint)point andObjectFrame:(CGRect)frame
{
    return point;
}

/*
 * NPC Movement Handling
 */
- (void)moveNPC:(int)lX andY:(int)lY
{
    if(NPCs.count > 0)
    {
        for (BaseNPC *npc in NPCs)
        {
            npc._x -= lX;
            npc._y -= lY;
            
            [self checkMapOutOfBounds:npc];
        }
    }
    
    if(enemies.count > 0)
    {
        for(Enemy *enemy in enemies)
        {
            enemy._x -= lX;
            enemy._y -= lY;
            
            [self checkMapOutOfBounds:enemy];
        }
    }
    
//    if([_autoDestroySet count] > 0)
//        [self deleteOutOfBoundsObjects];
}

- (void)NPCTryMove:(NSNotification *)dictionary
{
    BaseNPC *npc = [(BaseNPC *)[(NSDictionary *)[dictionary object] objectForKey:@"npc"] retain];
    NSValue *move = [(NSValue *)[(NSDictionary *)[dictionary object] objectForKey:@"move"] retain];
    CGPoint _move = (CGPoint)[move CGPointValue];
    
    //Check for object collision
    _move = [self defineInteraction:_move andObjectFrame:npc.frame];
        
    if(!npc.isBlockedByPlayer)
    {
        if(!npc.isRunning && !npc.isWalking)
        {
            [npc startMovement];
        }
        npc._x -= _move.x;
        npc._y -= _move.y;
    } else {
        if(npc.isRunning || npc.isWalking)
        {
            [npc stop];
        }
    }
    
    [self destroy:npc];
    [self destroy:move];
}

- (void)checkPlayerNearNPCInteraction:(BaseAISystem *)object andTileSize:(int)tileSize
{
    BaseAISystem *npc = [object retain];
    CGRect frame = npc.frame;
    
    //This method compares how close an npc object is to the player using a given tile size
    int offset = tileSize * TILE_WIDTH;
    
                //North
    BOOL near = ((frame.origin.y - offset < playerObject.frame.origin.y &&
                  frame.origin.y + offset + frame.size.height + BUFFER > playerObject.frame.origin.y &&
                  frame.origin.x + offset + frame.size.width > playerObject.frame.origin.x - BUFFER &&
                  frame.origin.x - offset + BUFFER < playerObject.frame.origin.x + playerObject.frame.size.width) ||
    
                //South
                 (frame.origin.y + offset > playerObject.frame.origin.y &&
                  frame.origin.y + offset < playerObject.frame.origin.y + playerObject.frame.size.height + BUFFER &&
                  frame.origin.x + offset + frame.size.width > playerObject.frame.origin.x - BUFFER &&
                  frame.origin.x - offset + BUFFER < playerObject.frame.origin.x + playerObject.frame.size.width) ||
                 
                //West
                 (frame.origin.x - offset < playerObject.frame.origin.x &&
                  frame.origin.x + offset + frame.size.width + BUFFER > playerObject.frame.origin.x &&
                  frame.origin.y + offset + frame.size.height > playerObject.frame.origin.y - BUFFER &&
                  frame.origin.y - offset + BUFFER < playerObject.frame.origin.y + playerObject.frame.size.height) ||
    
                 //East
                 (frame.origin.x + offset > playerObject.frame.origin.x + playerObject.frame.size.width &&
                  frame.origin.x - offset < playerObject.frame.origin.x + playerObject.frame.size.width + BUFFER &&
                  frame.origin.y + offset + frame.size.height > playerObject.frame.origin.y - BUFFER &&
                  frame.origin.y - offset + BUFFER < playerObject.frame.origin.y + playerObject.frame.size.height));
    
    npc.isBlockedByPlayer = near;
    
    if(near)
    {
        if(npc.isRunning || npc.isWalking)
        {
            [npc stop];
        }
        [npc setOpposingDirectionToPlayer:playerObject];
    }
    
    [self destroy:npc];
}

/*
 * Enemy Movement Handling
 */
- (void)EnemyTryMove:(NSNotification *)dictionary
{
    Enemy *enemy = [(Enemy *)[(NSDictionary *)[dictionary object] objectForKey:@"enemy"] retain];
    NSValue *move = [(NSValue *)[(NSDictionary *)[dictionary object] objectForKey:@"move"] retain];
    CGPoint _move = (CGPoint)[move CGPointValue];
    
    //Check for object collision
    _move = [self defineInteraction:_move andObjectFrame:enemy.frame];
    
    if(!enemy.isBlockedByPlayer)
    {
        if(!enemy.isRunning && !enemy.isWalking)
        {
            [enemy startMovement];
        }
        enemy._x -= _move.x;
        enemy._y -= _move.y;
    } else {
        if(enemy.isRunning || enemy.isWalking)
        {
            [enemy stop];
        }
    }
    
    [self destroy:enemy];
    [self destroy:move];
}

- (CGPoint)setPlayerToEnemyMovementInteraction:(CGPoint)point
{
    if(enemies.count > 0)
    {
        for(Enemy *enemy in enemies)
        {
            CGRect frame = enemy.frame;
            
            BOOL blockN = frame.origin.y < playerObject.frame.origin.y &&
            frame.origin.y + frame.size.height + BUFFER > playerObject.frame.origin.y &&
            frame.origin.x + frame.size.width > playerObject.frame.origin.x - BUFFER &&
            frame.origin.x + BUFFER < playerObject.frame.origin.x + playerObject.frame.size.width;
            
            BOOL blockS = frame.origin.y > playerObject.frame.origin.y &&
            frame.origin.y < playerObject.frame.origin.y + playerObject.frame.size.height + BUFFER &&
            frame.origin.x + frame.size.width > playerObject.frame.origin.x - BUFFER &&
            frame.origin.x + BUFFER < playerObject.frame.origin.x + playerObject.frame.size.width;
            
            BOOL blockW = frame.origin.x < playerObject.frame.origin.x &&
            frame.origin.x + frame.size.width + BUFFER > playerObject.frame.origin.x &&
            frame.origin.y + frame.size.height > playerObject.frame.origin.y - BUFFER &&
            frame.origin.y + BUFFER < playerObject.frame.origin.y + playerObject.frame.size.height;
            
            BOOL blockE = frame.origin.x > playerObject.frame.origin.x + playerObject.frame.size.width &&
            frame.origin.x < playerObject.frame.origin.x + playerObject.frame.size.width + BUFFER &&
            frame.origin.y + frame.size.height > playerObject.frame.origin.y - BUFFER &&
            frame.origin.y + BUFFER < playerObject.frame.origin.y + playerObject.frame.size.height;
            
            //Handle points based on blocks
            if(blockN)
                if(point.y != 0.0)
                    point.y = MAX(point.y , 0.0);
            
            if(blockS)
                if(point.y != 0.0)
                    point.y = MIN(point.y , 0.0);
            
            if(blockW)
                if(point.x != 0.0)
                    point.x = MAX(point.x , 0.0);
            
            if(blockE)
                if(point.x != 0.0)
                    point.x = MIN(point.x , 0.0);
            
            if(blockN || blockW || blockW || blockE)
            {
                [enemy stopMovement];
                [enemy setOpposingDirectionToPlayer:playerObject];
            }
        }
    }
    return point;
}

- (void)checkPlayerNearEnemyInteraction:(Enemy *)object andTileSize:(int)tileSize
{
    Enemy *enemy = [object retain];
    CGRect frame = enemy.frame;
    
    //This method compares how close an enemy object is to the player using a given tile size
    int offset = tileSize * TILE_WIDTH;
    
    BOOL blocked = ((frame.origin.y - offset < playerObject.frame.origin.y &&
                  frame.origin.y + frame.size.height + BUFFER > playerObject.frame.origin.y &&
                  frame.origin.x + frame.size.width > playerObject.frame.origin.x - BUFFER &&
                  frame.origin.x + BUFFER < playerObject.frame.origin.x + playerObject.frame.size.width) ||
                 
                 //South
                 (frame.origin.y > playerObject.frame.origin.y &&
                  frame.origin.y < playerObject.frame.origin.y + playerObject.frame.size.height + BUFFER &&
                  frame.origin.x + frame.size.width > playerObject.frame.origin.x - BUFFER &&
                  frame.origin.x + BUFFER < playerObject.frame.origin.x + playerObject.frame.size.width) ||
                 
                 //West
                 (frame.origin.x < playerObject.frame.origin.x &&
                  frame.origin.x + frame.size.width + BUFFER > playerObject.frame.origin.x &&
                  frame.origin.y + frame.size.height > playerObject.frame.origin.y - BUFFER &&
                  frame.origin.y + BUFFER < playerObject.frame.origin.y + playerObject.frame.size.height) ||
                 
                 //East
                 (frame.origin.x > playerObject.frame.origin.x + playerObject.frame.size.width &&
                  frame.origin.x < playerObject.frame.origin.x + playerObject.frame.size.width + BUFFER &&
                  frame.origin.y + frame.size.height > playerObject.frame.origin.y - BUFFER &&
                  frame.origin.y + BUFFER < playerObject.frame.origin.y + playerObject.frame.size.height));
    
                //North
    BOOL near = ((frame.origin.y - offset < playerObject.frame.origin.y &&
                  frame.origin.y + offset + frame.size.height + BUFFER > playerObject.frame.origin.y &&
                  frame.origin.x + offset + frame.size.width > playerObject.frame.origin.x - BUFFER &&
                  frame.origin.x - offset + BUFFER < playerObject.frame.origin.x + playerObject.frame.size.width) ||
                 
                 //South
                 (frame.origin.y + offset > playerObject.frame.origin.y &&
                  frame.origin.y + offset < playerObject.frame.origin.y + playerObject.frame.size.height + BUFFER &&
                  frame.origin.x + offset + frame.size.width > playerObject.frame.origin.x - BUFFER &&
                  frame.origin.x - offset + BUFFER < playerObject.frame.origin.x + playerObject.frame.size.width) ||
                 
                 //West
                 (frame.origin.x - offset < playerObject.frame.origin.x &&
                  frame.origin.x + offset + frame.size.width + BUFFER > playerObject.frame.origin.x &&
                  frame.origin.y + offset + frame.size.height > playerObject.frame.origin.y - BUFFER &&
                  frame.origin.y - offset + BUFFER < playerObject.frame.origin.y + playerObject.frame.size.height) ||
                 
                 //East
                 (frame.origin.x + offset > playerObject.frame.origin.x + playerObject.frame.size.width &&
                  frame.origin.x - offset < playerObject.frame.origin.x + playerObject.frame.size.width + BUFFER &&
                  frame.origin.y + offset + frame.size.height > playerObject.frame.origin.y - BUFFER &&
                  frame.origin.y - offset + BUFFER < playerObject.frame.origin.y + playerObject.frame.size.height));
    
    enemy.isBlockedByPlayer = blocked;
    
    if(near || blocked)
    {
        if(near && !enemy.isFollowingPlayer) [enemy setFollowing];
        if(blocked) [enemy stop];
        
        [enemy setOpposingDirectionToPlayer:playerObject];
    }
    
    [self destroy:enemy];
}

- (void)checkEnemyAttackInteraction:(Enemy *)object andRange:(float)tileSize
{    
    Enemy *enemy = [object retain];
    
    if(enemy.isAttackingPlayer)
    {
        [self destroy:enemy];
        return;
    }
    
    CGRect frame = enemy.frame;
    
    //This method compares if the enemy can attack the player given it's range
    int offset = MAX(1, (tileSize - 1)) * TILE_WIDTH;
    
                //North
    BOOL canAttack = ((frame.origin.y - offset < playerObject.frame.origin.y &&
                  frame.origin.y + offset + frame.size.height + BUFFER > playerObject.frame.origin.y &&
                  frame.origin.x + offset + frame.size.width > playerObject.frame.origin.x - BUFFER &&
                  frame.origin.x - offset + BUFFER < playerObject.frame.origin.x + playerObject.frame.size.width) ||
                 
                 //South
                 (frame.origin.y + offset > playerObject.frame.origin.y &&
                  frame.origin.y + offset < playerObject.frame.origin.y + playerObject.frame.size.height + BUFFER &&
                  frame.origin.x + offset + frame.size.width > playerObject.frame.origin.x - BUFFER &&
                  frame.origin.x - offset + BUFFER < playerObject.frame.origin.x + playerObject.frame.size.width) ||
                 
                 //West
                 (frame.origin.x - offset + frame.size.width < playerObject.frame.origin.x &&
                  frame.origin.x - offset + frame.size.width + BUFFER > playerObject.frame.origin.x &&
                  frame.origin.y + offset + frame.size.height > playerObject.frame.origin.y - BUFFER &&
                  frame.origin.y - offset + BUFFER < playerObject.frame.origin.y + playerObject.frame.size.height) ||
                 
                 //East
                 (frame.origin.x + offset > playerObject.frame.origin.x + playerObject.frame.size.width &&
                  frame.origin.x - offset < playerObject.frame.origin.x + playerObject.frame.size.width + BUFFER &&
                  frame.origin.y + offset + frame.size.height > playerObject.frame.origin.y - BUFFER &&
                  frame.origin.y - offset + BUFFER < playerObject.frame.origin.y + playerObject.frame.size.height));
    
    if(canAttack)
        [enemy attack]; 
    
    [self destroy:enemy];
}

- (void)checkForNPCS:(Tile *)tile
{
    for (NSDictionary *object in [[[Shell shell]worldMap] objectForKey:NPC]) {
        
        if(tile.point.x == ((int)[[object objectForKey:@"spawnX"] intValue] / TILE_WIDTH) &&
           (tile.point.y == (int)[[object objectForKey:@"spawnY"] intValue]  / TILE_WIDTH))
        {
            for (BaseNPC *npc in NPCs) {
                if(npc.uid == (int)[[object objectForKey:@"UID"] intValue])
                    return;
            }
            [self sendEvent:EVENT_NPC_CREATE andObject:[NSArray arrayWithObjects:[npcDatabase npcFromUid:(unsigned int)[[object objectForKey:@"UID"] intValue]],tile, nil]];
        }
    }

}

- (void)refreshMap
{
    [super refreshMap];
    [enemies removeAllObjects];
    [NPCs removeAllObjects];
    for (BasePlayer *object in self.subviews) {
        if ([object isKindOfClass:[Enemy class]]) {
            [self destroyAndRemove:object];
        } else if ([object isKindOfClass:[BaseNPC class]])
        {
            [self destroyAndRemove:object];
        }
    }
}

- (void)refreshTile:(Tile *)tile
{
    [super refreshTile:tile];
     [self checkForNPCS:tile];
}

/*
 * Check for out of bounds from map
 */
- (void)checkMapOutOfBounds:(BasePlayer *)object
{
    if(object._x >= (SCREEN_WIDTH + (TILE_WIDTH * 3)) || object._x <= ( -(TILE_WIDTH * 3)) || object._y >= (SCREEN_HEIGHT + (TILE_HEIGHT * 3)) || object._y <= ( -(TILE_HEIGHT * 3)))
    {
        [_autoDestroySet addObject:object];
    }
}

/*
 * Destroy enemies and npcs off the map
 */
- (void)deleteOutOfBoundsObjects
{
    for(Enemy *enemy in _autoDestroySet)
    {
        [self destroyEnemy:enemy];
    }
    
    for(BaseNPC *npc in _autoDestroySet)
    {
        [self destroyNPC:npc];
    }
    
    [_autoDestroySet removeAllObjects];
}

- (void)dealloc
{
    [self destroyAndRemove:self.playerObject];
    [self destroy:NPCs];
    [self destroy:enemies];
    [self destroy:_autoDestroySet];
    [super dealloc];
}


@end
