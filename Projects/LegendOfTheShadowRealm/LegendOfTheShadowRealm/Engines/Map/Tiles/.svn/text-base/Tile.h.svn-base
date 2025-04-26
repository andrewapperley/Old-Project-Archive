//
//  Tile.h
//  LegendOfTheShadowRealm
//
//  Created by Andrew Apperley on 2012-11-18.
//
//

#import "BaseLayer.h"
#import <QuartzCore/QuartzCore.h>
#define IMAGE_CACHE_LIMIT 200

enum TileType
{
    Walkable,
    ExitHouse,
    EnterHouse,
    Flamable,
    Water,
    Blocked
};

@interface Tile : BaseLayer
@property (nonatomic, readwrite) CGPoint point;

@property (nonatomic, readwrite) int zoneName;
@property (nonatomic, readonly) BOOL enterHouse;
@property (nonatomic, readonly) BOOL flameable;
@property (nonatomic, readonly) BOOL walkable;
@property (nonatomic, readonly) BOOL exitHouse;
@property (nonatomic, readonly) BOOL water;
@property (nonatomic, readonly) BOOL blocked;
@property (nonatomic, readwrite) BOOL fore;
@property (nonatomic, assign) int imageId;
@property (nonatomic, retain) NSString *tileHash;
- (Tile*) initWithTile:(NSDictionary *)ltileObject andPoint:(CGPoint)lpoint andFrame:(CGRect)lframe;

- (void)refreshImage:(int)imageId;
- (void)refreshInteraction:(int)interaction;
- (void)refreshZone:(int)zone;
- (void)refreshHash:(NSString *)hash;
@end
