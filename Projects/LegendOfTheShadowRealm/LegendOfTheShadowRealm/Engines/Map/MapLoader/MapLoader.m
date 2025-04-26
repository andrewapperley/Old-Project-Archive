//
//  MapLoader.m
//  LegendOfTheShadowRealm
//
//  Created by Andrew Apperley on 2012-11-24.
//
//

#import "MapLoader.h"
#import "Tile.h"
#import "Constants.h"
@implementation MapLoader

@synthesize worldMap, worldTileHeight, worldTileWidth;

-(id)init
{
    self = [super init];
    if(self)
    {
        //Create World Map Array
        worldMap = [NSMutableDictionary new];
        NPCS = [NSMutableArray new];
        animatedTiles = [NSMutableArray new];
        layerName = nil;
    }
    return self;
}

- (void) loadXMLFile:(NSString *)file
{
    
    if([worldMap count] > 0)[worldMap removeAllObjects];
    _count = 0;
    _row = 0;
    
    [[NSURLCache sharedURLCache] setMemoryCapacity:0];
    [[NSURLCache sharedURLCache] setDiskCapacity:0];
    
    NSURL *xmlURL = [NSURL fileURLWithPath:file];
    NSXMLParser *addressParser = [[NSXMLParser alloc] initWithContentsOfURL:xmlURL];
    
    if(addressParser)
    {
        [addressParser setDelegate:self];
        [addressParser setShouldResolveExternalEntities:YES];
        [addressParser parse];
    }
    
    [self destroy:addressParser];
}

// Start of element
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)lattributeDict
{
    NSDictionary *attributeDict = [lattributeDict retain];
    
    //layer properties
    if ( [elementName isEqualToString:@"layer"] ) {
        NSMutableArray *Layer = [[NSMutableArray alloc] init];
        
        [worldMap setObject:Layer forKey:[attributeDict objectForKey:@"name"]];
        
        layerName = [attributeDict objectForKey:@"name"];
        worldTileWidth = [[attributeDict objectForKey:@"width"] intValue];
        worldTileHeight = [[attributeDict objectForKey:@"height"] intValue];
        [self destroy:Layer];
        [self destroy:attributeDict];
        return;
    }
    
    //tile IDs
    if ( [elementName isEqualToString:@"tile"] ) {
        if(_count == 0)
        {
            row = [[NSMutableArray alloc]init];
        }
        
        tileDict = [NSMutableDictionary dictionary];
        [tileDict setObject:[attributeDict objectForKey:@"gid"] forKey:@"gid"];
        
        [row addObject:tileDict];
        
        _count++;
        
        if(_count == worldTileWidth){
        
            [[worldMap objectForKey:layerName] addObject:row];
            
            
            _row++;
            _count = 0;
            if(_row == worldTileHeight)_row = 0;
            [self destroy:row];
        }
        [self destroy:attributeDict];
        return;
    }
    
    //Objects (so far its used for NPC spawn points and animated tiles)
    if( [elementName isEqualToString:@"object"] ) {
        NSMutableDictionary *object = [NSMutableDictionary dictionary];
        [object setObject:[attributeDict objectForKey:@"name"] forKey:@"UID"];
        [object setObject:[attributeDict objectForKey:@"type"] forKey:@"type"];
        [object setObject:[attributeDict objectForKey:@"x"] forKey:@"spawnX"];
        [object setObject:[attributeDict objectForKey:@"y"] forKey:@"spawnY"];
        [object setObject:[attributeDict objectForKey:@"width"] forKey:@"width"];
        [object setObject:[attributeDict objectForKey:@"height"] forKey:@"height"];
        
        if( [[attributeDict objectForKey:@"type"] isEqualToString:@"NPC"] )
            [NPCS addObject:object];
        else if ([[attributeDict objectForKey:@"type"] isEqualToString:@"Animated_Tile"])
            [animatedTiles addObject:object];
    }
    [self destroy:attributeDict];
}

-(void)parserDidEndDocument:(NSXMLParser *)parser
{
    [worldMap setObject:NPCS forKey:@"NPCS"];
    [worldMap setObject:animatedTiles forKey:@"animatedTiles"];
    _count = 0;
    _row = 0;
    layerName = nil;
    tileDict = nil;
}


-(void) dealloc
{
    [self destroy:NPCS];
    [self destroy:animatedTiles];
    [self destroy:worldMap];
    [super dealloc];
}

@end
