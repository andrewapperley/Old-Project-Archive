//
//  Tile.m
//  LegendOfTheShadowRealm
//
//  Created by Andrew Apperley on 2012-11-18.
//
//

#import "EventCenter.h"
#import "Constants.h"
#import "Tile.h"
#import "ImageCacheUtil.h"
#import "Shell.h"
#import "MapLayer.h"
@implementation Tile
@synthesize point;

@synthesize enterHouse = _enterHouse;
@synthesize flameable = _flameable;
@synthesize walkable = _walkable;
@synthesize exitHouse = _exitHouse;
@synthesize water = _water;
@synthesize blocked = _blocked;
@synthesize fore;
@synthesize imageId = _imageId;
@synthesize tileHash;

static float scaleX = 1.0;
@synthesize _scaleX;

- (void)set_scaleX:(float)__scaleX
{
    scaleX = __scaleX;
    [self set_width:self._width];
}

- (float)_scaleX
{
    return scaleX;
}

static float scaleY = 1.0;
@synthesize _scaleY;

- (void)set_scaleY:(float)__scaleY
{
    scaleY = __scaleY;
    [self set_height:self._height];
}

- (float)_scaleY
{
    return scaleY;
}



- (Tile*) initWithTile:(NSDictionary *)ltileObject andPoint:(CGPoint)lpoint andFrame:(CGRect)lframe
{
    self = [super init];
    if(self)
    {
        
        //Disables all animations
        NSMutableDictionary *newActions = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                           [NSNull null], @"onOrderIn",
                                           [NSNull null], @"onOrderOut",
                                           [NSNull null], @"sublayers",
                                           [NSNull null], @"contents",
                                           [NSNull null], @"bounds",
                                           [NSNull null], @"frame",
                                           [NSNull null], @"position",
                                           nil];
        self.actions = newActions;
        [newActions release];

        
        self.point = lpoint;
        self.frame = lframe;
        self.opaque = TRUE;
        if([[UIDevice currentDevice].systemVersion floatValue] >= 6.0) {
            self.drawsAsynchronously = TRUE;
        }
//        self.borderColor = [UIColor blackColor].CGColor;
//        self.borderWidth = .5;
        
        
         _zoneName = (int)[[ltileObject objectForKey:@"zone"] intValue];
        
         fore = [[ltileObject objectForKey:@"zindex"] boolValue];
        
         int imageId = (int)[[ltileObject objectForKey:@"imageId"] intValue];
        
         self.tileHash = (NSString *)[ltileObject objectForKey:@"tileHash"];
        
         int type = (int)[[ltileObject objectForKey:@"type"] intValue];
        
//         tileObject = nil;
//         [tileObject release];
//        
//         ltileObject = nil;
//         [ltileObject release];
        
         [self refreshImage:imageId];
         [self refreshInteraction:type];
        
        //add listeners for events
        [self addListener:[NSString stringWithFormat:@"%@_%@_%d",EVENT_MAP_TILE_HOUSE_INTERACTION,self.tileHash,fore] andSel:@selector(fadeTileForHouse)];
        [self addListener:[NSString stringWithFormat:@"%@_%@_%d",EVENT_MAP_TILE_HOUSE_REVERSE_INTERACTION,self.tileHash,fore] andSel:@selector(reverseFadeTileForHouse)];
        
    }
    return self;
}



- (void)refreshImage:(int)imageId
{
    if(_imageId != imageId)
    {
        _imageId = imageId;
//
       self.contents = (UIImage *)[ImageCacheUtil addImage:[NSString stringWithFormat:@"%d",imageId] toSet:[[[Shell shell] battleSystem]tileImages] andCapacity:IMAGE_CACHE_LIMIT].CGImage;
    }
}

- (void)refreshInteraction:(int)interaction
{
    _enterHouse = FALSE;
    _flameable = FALSE;
    _walkable = FALSE;
    _exitHouse = FALSE;
    _water = FALSE;
    _blocked = FALSE;
    
    [self setInteraction:interaction];
}

- (void)setInteraction:(int)interaction
{
    switch (interaction) {
        case Walkable:
            _walkable = TRUE;
            break;
        case ExitHouse:
            _exitHouse = TRUE;
            break;
        case EnterHouse:
            _enterHouse = TRUE;
            break;
        case Flamable:
            _flameable = TRUE;
            break;
        case Water:
            _water = TRUE;
            break;
        case Blocked:
            _blocked = TRUE;
            break;
        default:
            _walkable = TRUE;
            break;
    }
}

- (void) refreshZone:(int)zone
{
    self.zoneName = (int)zone;
}

-(void) refreshHash:(NSString *)hash
{

    self.tileHash = hash;
}

-(void) fadeTileForHouse
{
    [self setHidden:TRUE];
}

-(void) reverseFadeTileForHouse
{
    [self setHidden:FALSE];
}

-(void)dealloc
{

    [self removeAllAnimations];
    [self removeAllEvents];
    [self removeFromSuperlayer];
    [self release];
    [super dealloc];
}



@end
