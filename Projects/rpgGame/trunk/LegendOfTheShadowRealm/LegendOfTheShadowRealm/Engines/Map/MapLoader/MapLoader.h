//
//  MapLoader.h
//  LegendOfTheShadowRealm
//
//  Created by Andrew Apperley on 2012-11-24.
//
//

#import "BaseObject.h"

@interface MapLoader : BaseObject<NSXMLParserDelegate>
{
    NSMutableArray *row;
    NSMutableDictionary *tileDict;
    NSString *layerName;
    NSMutableArray *NPCS;
    NSMutableArray *animatedTiles;
    int _count;
    int _row;
}

@property(nonatomic, retain)NSMutableDictionary *worldMap;
@property(nonatomic, readonly)int worldTileWidth;
@property(nonatomic, readonly)int worldTileHeight;

- (void) loadXMLFile:(NSString *)file;
@end
