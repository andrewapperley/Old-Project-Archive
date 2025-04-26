//
//  MapLayer.h
//  LegendOfTheShadowRealm
//
//  Created by Andrew Apperley on 2012-11-18.
//
//

#import "BaseView.h"
#import "Player.h"
#import "Tile.h"
#import "Shell.h"

@class Tile;

@interface MapLayer : BaseView
{
    
    BOOL _running;
    int refreshCount;
    int moveMapCount;
    
    int moveX;
    int moveY;
    
    BaseView *tileContainer;
    BaseView *tileForeGroundContainer;
    
    NSMutableArray *currentTiles;
    NSMutableArray *destroyArray;
    NSMutableArray *newTiles;

    
    NSMutableArray *tileXCords;
    NSMutableArray *tileYCords;
    NSSortDescriptor *lowestToHighest;

    NSTimer *updatePlayerTimer;
    
}

@property (nonatomic, retain)NSMutableSet *tileImages;
@property (nonatomic, readwrite)BOOL mapIsMoving;
@property (nonatomic, retain)Tile *centerTile;
@property (nonatomic, assign)CGPoint mapStartingPostion;
- (void)createLootTable;
- (void)refreshMap;
- (void)generateInitialMap;
- (void)updatePlayerPosition;
- (void)refreshTile:(Tile *)tile;
- (void)moveMapWithPoint:(CGPoint)point;
- (void)startTimer;
- (void)stopTimer;
@end