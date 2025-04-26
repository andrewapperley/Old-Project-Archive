//
//  MapLayer.m
//  LegendOfTheShadowRealm
//
//  Created by Andrew Apperley on 2012-11-18.
//
//

#import "Constants.h"
#import "Database.h"
#import "InteractionLayer.h"
#import "MapLayer.h"
#import "MapLoader.h"
#import "Shell.h"
#import "AnimatedTile.h"
#import <QuartzCore/QuartzCore.h>

@implementation MapLayer
@synthesize mapIsMoving = _mapIsMoving;
@synthesize centerTile;
@synthesize mapStartingPostion;
@synthesize tileImages;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

               
        self.frame = frame;
        self.clipsToBounds = TRUE;
        //Create tile image cache
        tileImages = [NSMutableSet new];
        _mapIsMoving = FALSE;
        //array to hold the tiles that are displayed on the screen
        currentTiles = [NSMutableArray new];
        //x cords for all the tiles in current tiles, used for sorting them easily
        tileXCords = [NSMutableArray new];
        //y cords for all the tiles in current tiles, used for sorting them easily
        tileYCords = [NSMutableArray new];
        //array used to hold the tiles that are marked for destroy, then emptied once the enumeration is complete
        destroyArray = [NSMutableArray new];
        //array to hold the new tiles that are yet to be merged with the current tiles
        newTiles = [NSMutableArray new];
        if([[UIDevice currentDevice].systemVersion floatValue] >= 6.0) {
            self.layer.drawsAsynchronously = TRUE;
        }
        mapStartingPostion = CGPointZero;
        //base view to hold the displayed tiles at index 0
        tileContainer = [[BaseView alloc]initWithFrame:frame];
        //base view to hold the displayed tiles at index 1
        tileForeGroundContainer = [[BaseView alloc]initWithFrame:frame];
        [self addSubview:tileContainer];
        [self startTimer];
                
        //If the current map is the world map the use that position
        if([[playerDatabase currentMap] isEqualToString:MAP_ZONE_WORLD])
            mapStartingPostion = CGPointMake([playerDatabase worldPositionX], [playerDatabase worldPositionY]);
        else
            mapStartingPostion = CGPointMake([playerDatabase dungeonPositionX], [playerDatabase dungeonPositionY]);
        
        [self addListener:EVENT_CIRCLEPAD_MOVE_START andSel:@selector(moveMap:)];
        [self addListener:EVENT_CIRCLEPAD_MOVE_STOP andSel:@selector(stopMapMovement)];
        [self generateInitialMap];
              
        
    }
    return self;
}

/*
 * This function takes the starting x/y and searches for that tile in the World Map, then starts generating tiles
 * based off of that point. The properties are then set to each tile (collision type, zone number, zindex, imageID)
 */
- (void)generateInitialMap
{
    int count = -1;
    int row = 0;
    int rowAmount =  TILE_SCREEN_WIDTH + TILE_SCREEN_BUFFER;
    int amountOfRows =  TILE_SCREEN_HEIGHT + TILE_SCREEN_BUFFER;
    int tileNumber = 0;
    int type = Walkable;
    int maxWorldRows = [[Shell shell]worldTileHeight]-1;
    int maxWorldColumns = [[Shell shell] worldTileWidth]-1;
    int zone = 0;
    
    for (int i = 0; i < TILE_SCREEN_AMOUNT; i++) {
        
        type = [[[[[[[Shell shell]worldMap] objectForKey:COLLISION] objectAtIndex:MIN(mapStartingPostion.y + row, maxWorldRows)]objectAtIndex:MIN(mapStartingPostion.x + i,maxWorldColumns)] objectForKey:@"gid"] intValue];
        
       tileNumber = [[[[[[[Shell shell] worldMap] objectForKey:GROUND] objectAtIndex:MIN(mapStartingPostion.y + row, maxWorldRows)]objectAtIndex:MIN(mapStartingPostion.x + i,maxWorldColumns)] objectForKey:@"gid"] intValue];
        
        zone = [[[[[[[Shell shell]worldMap] objectForKey:ZONE] objectAtIndex:MIN(mapStartingPostion.y + row, maxWorldRows)]objectAtIndex:MIN(mapStartingPostion.x + i,maxWorldColumns)] objectForKey:@"gid"] intValue];
        
        NSString *tileHash = [[NSString alloc] initWithString:[NSString stringWithFormat:@"%d_%@",[[[[[[[Shell shell]worldMap] objectForKey:HASH] objectAtIndex:MIN(mapStartingPostion.y + row, maxWorldRows)]objectAtIndex:MIN(mapStartingPostion.x + i,maxWorldColumns)] objectForKey:@"gid"] intValue], GROUND]];
        
        if(mapStartingPostion.x + i < 0 || mapStartingPostion.x + i > [[Shell shell]worldTileWidth]-1
           || mapStartingPostion.y + row < 0 || mapStartingPostion.y + row > [[Shell shell]worldTileHeight]-1) tileNumber = 0;
        
        NSDictionary *tileData = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:tileNumber], @"imageId", [NSNumber numberWithInt:type], @"type", [NSNumber numberWithInt:zone], @"zone", [NSNumber numberWithBool:FALSE], @"zindex",tileHash, @"tileHash", nil];
        
        Tile *tile = [[Tile alloc]initWithTile:tileData andPoint:CGPointMake(mapStartingPostion.x + i, mapStartingPostion.y + row) andFrame:CGRectMake(TILE_WIDTH *count - ((TILE_SCREEN_BUFFER /2) * TILE_WIDTH), TILE_HEIGHT *row - ((TILE_SCREEN_BUFFER /2) * TILE_WIDTH), TILE_WIDTH, TILE_HEIGHT)];
                
        [currentTiles addObject:tile];
        [tileXCords addObject:[NSNumber numberWithFloat:tile._x]];
        [tileYCords addObject:[NSNumber numberWithFloat:tile._y]];
        
        tileNumber = [[[[[[[Shell shell]worldMap] objectForKey:FOREGROUND] objectAtIndex:MIN(mapStartingPostion.y + row, maxWorldRows)]objectAtIndex:MIN(mapStartingPostion.x + i,maxWorldColumns)] objectForKey:@"gid"] intValue];
        
        if(tileNumber > 0)
        {
            NSString *tileHash = [[NSString alloc] initWithString:[NSString stringWithFormat:@"%d_%@",[[[[[[[Shell shell]worldMap] objectForKey:HASH] objectAtIndex:MIN(mapStartingPostion.y + row, maxWorldRows)]objectAtIndex:MIN(mapStartingPostion.x + i,maxWorldColumns)] objectForKey:@"gid"] intValue], GROUND]];
            
            NSDictionary *tileDataFore = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:tileNumber], @"imageId", [NSNumber numberWithBool:TRUE], @"zindex",tileHash, @"tileHash", nil];
        
            Tile *tileFore = [[Tile alloc]initWithTile:tileDataFore andPoint:CGPointMake(mapStartingPostion.x + i, mapStartingPostion.y + row) andFrame:CGRectMake(TILE_WIDTH *count - ((TILE_SCREEN_BUFFER /2) * TILE_WIDTH), TILE_HEIGHT *row - ((TILE_SCREEN_BUFFER /2) * TILE_WIDTH), TILE_WIDTH, TILE_HEIGHT)];
            
            [currentTiles addObject:tileFore];
            [tileForeGroundContainer.layer insertSublayer:tileFore above:tileFore];
            [self destroy:tileFore];
            [self destroy:tileHash];
          
        }
        for (NSDictionary *object in [[[Shell shell]worldMap] objectForKey:ANIMATED]) {
            
            if(tile.point.x == ((int)[[object objectForKey:@"spawnX"] intValue] / TILE_WIDTH) &&
               (tile.point.y == (int)[[object objectForKey:@"spawnY"] intValue]  / TILE_WIDTH))
            {
                for (AnimatedTile *aniT in currentTiles) {
                    if(aniT.imageId == (int)[[object objectForKey:@"UID"] intValue])
                        return;
                }
                AnimatedTile *tileAni = [[AnimatedTile alloc] initWithTile:(int)[[object objectForKey:@"UID"] intValue] andPoint:CGPointMake(mapStartingPostion.x + i, mapStartingPostion.y + row) andFrame:CGRectMake(TILE_WIDTH *count - ((TILE_SCREEN_BUFFER /2) * TILE_WIDTH), TILE_HEIGHT *row - ((TILE_SCREEN_BUFFER /2) * TILE_WIDTH), TILE_WIDTH, TILE_HEIGHT)];
                [currentTiles addObject:tileAni];
                [tileForeGroundContainer.layer addSublayer:tileAni];
            }
        }

        
        
        count++;
        
        [self destroy:tileHash];
        
        if(count == rowAmount+1 && row != amountOfRows-1){
            i = 0;
            count = 0;
            row++;
        }
        if(row == amountOfRows-1 && count == rowAmount+2) {
            break;
        }

        [tileContainer.layer insertSublayer:tile below:tile];

        //center
        if(tile._x <= ((SCREEN_WIDTH) /2) &&
           tile._x + TILE_WIDTH >= ((SCREEN_WIDTH ) /2) &&
           tile._y <= ((SCREEN_HEIGHT ) /2) &&
           tile._y + TILE_WIDTH >= ((SCREEN_HEIGHT ) /2) &&
           !tile.fore)
        {
            centerTile = tile;
            
        }

        [self destroy:tile];
        
       
//        NSLog(@"Initial Map Zone Number: %d",tile.zoneName);
        [self createLootTable];
        
    }
}
//Requires to be overwritten
-(void)createLootTable{}
//This function is called on a 5 second timer(may change) and saves a new location to start at relaunch
- (void)updatePlayerPosition
{
    
    int startingX = centerTile.point.x - CENTER_TILE_OFFSET_X;
    int startingY = centerTile.point.y - CENTER_TILE_OFFSET_Y;
    
    mapStartingPostion = CGPointMake(MAX(0, startingX), MAX(0, startingY));
   
    if([[playerDatabase currentMap] isEqualToString:MAP_ZONE_WORLD])
    {
        [playerDatabase setWorldPositionX:(int)mapStartingPostion.x];
        [playerDatabase setWorldPositionY:(int)mapStartingPostion.y];
    } else {
        [playerDatabase setDungeonPositionX:(int)mapStartingPostion.x];
        [playerDatabase setDungeonPositionY:(int)mapStartingPostion.y];
    }
}

/*
 * Map movement
 */

- (void)moveMap:(id)lpoint
{
   
    [self moveMapWithPoint:[[lpoint object] CGPointValue]];
}

- (void)moveMapWithPoint:(CGPoint)point
{
   
    _mapIsMoving = TRUE;
    moveMapCount += 20;
    
    if(moveMapCount >= TILE_WIDTH ) {
        moveMapCount = 0;
       [self moveMapAnimation:point];
    }
    
}
//Takes the point of acceleration from the circle pad event and translates all the tiles in that direction at that speed
- (void)moveMapAnimation:(CGPoint)point
{
   
    moveX = MAX(- MAX_VELOCITY, MIN(floorf(point.x), MAX_VELOCITY));
    moveY = MAX(- MAX_VELOCITY, MIN(floorf(point.y), MAX_VELOCITY));
    
    if(moveX == 0 && moveY == 0)
    {
        [[[[Shell shell] battleSystem] playerObject] stop];
        return;
    }
    
    for (Tile *tile in currentTiles)
    {
        tile._x -= moveX;
        tile._y -= moveY;
    }
    [self sortTiles];
    
    refreshCount += 20;
    
    [self moveNPC:moveX andY:moveY];
    if(refreshCount >= TILE_WIDTH ) {
        refreshCount = 0;
        
        [self checkForNewTiles];
    
    }
}

/*
 * Requires Override
 */
- (void)moveNPC:(int)lX andY:(int)lY {}


//This function will loop through all the tiles that are currently displayed and check if they are within or over a buffer point, if they are then they are reset to the same point but on the opposite side of the screen and then refreshed. If the tile has a zindex amount more than 0 they are marked for destroy
- (void)checkForNewTiles
{
    
    for (Tile* tile in currentTiles)
    {
        
        //right
        if(tile._x < - (TILE_WIDTH * (TILE_SCREEN_BUFFER/2))){
            
            
            tile.point = CGPointMake((tile.point.x + ( TILE_SCREEN_WIDTH + TILE_SCREEN_BUFFER)), (tile.point.y));
            tile._x = MIN([[tileXCords objectAtIndex:[tileXCords count]-2] floatValue] + TILE_WIDTH, ((TILE_SCREEN_WIDTH + (TILE_SCREEN_BUFFER/2))*TILE_WIDTH));
                    if(tile.fore == TRUE) {
                        [destroyArray addObject:tile ];
            
                    } else {
                        [self refreshTile:tile];
                    }
            
        }

        //left
        if(tile._x > ((TILE_SCREEN_WIDTH + (TILE_SCREEN_BUFFER/2))*TILE_WIDTH)) {
            
            tile.point = CGPointMake((tile.point.x - ( TILE_SCREEN_WIDTH + TILE_SCREEN_BUFFER)), (tile.point.y));
            tile._x = MAX([[tileXCords objectAtIndex:1] floatValue] - TILE_WIDTH, - (TILE_WIDTH * (TILE_SCREEN_BUFFER/2)));
                   if(tile.fore == TRUE) {
                        [destroyArray addObject:tile];
            
                    } else {
                        [self refreshTile:tile];
                    }
            
        }
        
        //up
        if(tile._y > ((TILE_SCREEN_HEIGHT + (TILE_SCREEN_BUFFER/2))*TILE_WIDTH)){
            
            tile.point = CGPointMake((tile.point.x) , (tile.point.y - ( TILE_SCREEN_HEIGHT + TILE_SCREEN_BUFFER)));
            tile._y = MAX([[tileYCords objectAtIndex:1] floatValue] - TILE_WIDTH, - (TILE_WIDTH * TILE_SCREEN_BUFFER/2));
                  if(tile.fore == TRUE) {
                      [destroyArray addObject:tile ];
            
                  } else {
                      [self refreshTile:tile];
                  }
            
        }

 
        //down
        if(tile._y < - (TILE_WIDTH * TILE_SCREEN_BUFFER/2)){
            
            tile.point = CGPointMake((tile.point.x) , (tile.point.y + ( TILE_SCREEN_HEIGHT + TILE_SCREEN_BUFFER)));
            tile._y = MIN([[tileYCords objectAtIndex:[tileYCords count]-2] floatValue] + TILE_WIDTH, ((TILE_SCREEN_HEIGHT + (TILE_SCREEN_BUFFER/2))*TILE_WIDTH));
                        if(tile.fore == TRUE) {
                            [destroyArray addObject:tile ];
            
                        } else {
                            [self refreshTile:tile];
                        }

        }
        
        //center
        if(tile._x  <= ((SCREEN_WIDTH) /2) &&
           tile._x + TILE_WIDTH >= ((SCREEN_WIDTH ) /2) &&
           tile._y  <= ((SCREEN_HEIGHT ) /2) &&
           tile._y + TILE_WIDTH >= ((SCREEN_HEIGHT ) /2) &&
           !tile.fore)
        {
            if(tile.zoneName != centerTile.zoneName)
                [self sendEventOnce:EVENT_BATTLESYSTEM_ZONE_NEW andObject:[NSNumber numberWithInt:tile.zoneName]];
           
            centerTile = tile;
            
            //Send center tile zone number to BattleSystem
            if(tile.enterHouse)
                [self sendEventOnce:[NSString stringWithFormat:@"%@_%@_%d",EVENT_MAP_TILE_HOUSE_INTERACTION,centerTile.tileHash, !centerTile.fore]];
            if(tile.exitHouse)
                [self sendEventOnce:[NSString stringWithFormat:@"%@_%@_%d",EVENT_MAP_TILE_HOUSE_REVERSE_INTERACTION,centerTile.tileHash, !centerTile.fore]];
        }

        
    }
    
    if([destroyArray count] > 0)
    {
        [currentTiles removeObjectsInArray:destroyArray];
        [self destroyTilesFromArray:destroyArray];
        [destroyArray removeAllObjects];
    }
    if([newTiles count] > 0){
        
        [currentTiles addObjectsFromArray:newTiles];
        [newTiles removeAllObjects];
        
    }

}

//destroys all tiles that are in the array
- (void)destroyTilesFromArray:(NSMutableArray *)array
{
    if([array count] > 0){
        for (Tile *tile in array)
        {
            if(tile) {
                [tile removeFromSuperlayer];
                tile = nil;
                [tile release];
            }
        }
    }
}

//sorts the arrays of x/y cords from lowest to highest
- (void)sortTiles
{
    [tileXCords removeAllObjects];
    [tileYCords removeAllObjects];
    
    for(int i = 0; i < [currentTiles count]-1; i++ ) {
        [tileXCords addObject:[NSNumber numberWithFloat:[[currentTiles objectAtIndex:i] _x]] ];
        [tileYCords addObject:[NSNumber numberWithFloat:[[currentTiles objectAtIndex:i] _y]] ];
    }
    lowestToHighest = [NSSortDescriptor sortDescriptorWithKey:@"self" ascending:YES];
      
    [tileXCords sortUsingDescriptors:[NSArray arrayWithObject:lowestToHighest]];
    [tileYCords sortUsingDescriptors:[NSArray arrayWithObject:lowestToHighest]];
    
}

//refreshes the tiles with new properties and then checks that point in the foreground tile set, if one is found then it is created and placed on the map
- (void)refreshTile:(Tile *)tile
{
    
    float column =  MAX( 0 , MIN( tile.point.x , [[Shell shell]worldTileWidth]-1 ) );
    
    float row = MAX( 0 , MIN( tile.point.y , [[Shell shell]worldTileHeight]-1 ) );
    
    
    int tileNumber = 0;
    int typeNumber = [[[[[[[Shell shell]worldMap] objectForKey:COLLISION] objectAtIndex:row]objectAtIndex:column] objectForKey:@"gid"] intValue];
    int zoneNumber = [[[[[[[Shell shell]worldMap] objectForKey:ZONE] objectAtIndex:row]objectAtIndex:column] objectForKey:@"gid"] intValue];
    NSString *tileHash = [NSString stringWithFormat:@"%d_%@",[[[[[[[Shell shell]worldMap] objectForKey:HASH] objectAtIndex:row]objectAtIndex:column] objectForKey:@"gid"] intValue],GROUND];
    
    tileNumber = [[[[[[[Shell shell]worldMap] objectForKey:GROUND] objectAtIndex:row]objectAtIndex:column] objectForKey:@"gid"] intValue];
    
    
    
    if(tile.point.x < 0 || tile.point.x > [[Shell shell]worldTileWidth]-1
       || tile.point.y < 0 || tile.point.y > [[Shell shell]worldTileHeight]-1){
     
        tileNumber = 0;
        typeNumber = 0;
    }
    
    
    [tile refreshImage:tileNumber];
    [tile refreshInteraction:typeNumber];
    [tile refreshZone:zoneNumber];
    [tile refreshHash:tileHash];

    //Check for ForeGround Tiles at this point
    tileNumber = [[[[[[[Shell shell]worldMap] objectForKey:FOREGROUND] objectAtIndex:row]objectAtIndex:column] objectForKey:@"gid"] intValue];
    
    if(tileNumber > 0){
        
        
        NSString *tileHashFore = [[NSString stringWithFormat:@"%d_%@",[[[[[[[Shell shell]worldMap] objectForKey:HASH] objectAtIndex:row]objectAtIndex:column] objectForKey:@"gid"] intValue],GROUND] autorelease];
        
        NSDictionary *tileData = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:tileNumber], @"imageId", [NSNumber numberWithInt:typeNumber], @"type",[NSNumber numberWithBool:TRUE], @"zindex",tileHashFore, @"tileHash", nil];
        
        Tile *tileNew = [[Tile alloc]initWithTile:tileData andPoint:CGPointMake(tile.point.x, tile.point.y) andFrame:CGRectMake(tile._x, tile._y , TILE_WIDTH, TILE_HEIGHT)];
        
        [newTiles addObject:tileNew];
        [tileForeGroundContainer.layer addSublayer:tileNew];
        
        [self destroy:tileNew];
    }
    
    for (NSDictionary *object in [[[Shell shell]worldMap] objectForKey:ANIMATED]) {
        
        if(tile.point.x == ((int)[[object objectForKey:@"spawnX"] intValue] / TILE_WIDTH) &&
           (tile.point.y == (int)[[object objectForKey:@"spawnY"] intValue]  / TILE_WIDTH))
        {
            for (AnimatedTile *aniT in currentTiles) {
                if(aniT.imageId == (int)[[object objectForKey:@"UID"] intValue])
                    return;
            }
            AnimatedTile *tileAni = [[AnimatedTile alloc] initWithTile:(int)[[object objectForKey:@"UID"] intValue] andPoint:CGPointMake(tile.point.x, tile.point.y) andFrame:CGRectMake(tile._x, tile._y , TILE_WIDTH, TILE_HEIGHT)];
            [newTiles addObject:tileAni];
            [tileForeGroundContainer.layer addSublayer:tileAni];
            [self destroy:tileAni];
        }
    }

    
    
}

-(void)refreshMap
{
    for (int i = 0; i < [currentTiles count]-1; i++ ) {
    
        [self refreshTile:(Tile *)[currentTiles objectAtIndex:i]];
    }
    
}

- (void)stopMapMovement
{
    _mapIsMoving = FALSE;
}

- (void)startTimer
{
    updatePlayerTimer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(updatePlayerPosition) userInfo:nil repeats:YES];
}

- (void)stopTimer
{
    [updatePlayerTimer invalidate];
    updatePlayerTimer = nil;
}

-(void)dealloc
{
    [self destroy:centerTile];
    [self destroy:currentTiles];
    [self destroy:newTiles];
    [self destroyAndRemove:tileContainer];
    [self destroy:tileXCords];
    [self destroy:tileYCords];
    [self destroy:lowestToHighest];
    [self destroy:updatePlayerTimer];
    [self destroy:destroyArray];
    [self destroy];
    [super dealloc];
}
@end