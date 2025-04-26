//
//  MapDatabase.h
//  LegendOfTheShadowRealm
//
//  Created by Jeremy Fuellert on 2012-11-24.
//
//

#import "DatabaseBase.h"

@interface MapDatabase : DatabaseBase

//Zone
- (NSString *)zoneFromRowId:(int)rowId;
- (NSString *)zoneFromMap:(NSString *)map;

//Map
- (NSString *)mapFromRowId:(int)rowId;
- (NSString *)mapFromZone:(NSString *)zone;

//Level Difference
- (float)levelDifferenceFromRowId:(int)rowId;
- (float)levelDifferenceFromZone:(NSString *)zone;

//Enemies Per Screen at a Time
- (int)enemiesAllowedPerScreenFromRowId:(int)rowId;
- (int)enemiesAllowedPerScreenFromZone:(NSString *)zone;

//Required to unlock
- (NSArray *)requiredToUnlockFromRowId:(int)rowId;
- (NSArray *)requiredToUnlockFromZone:(NSString *)zone;
- (void)setRequirementsToUnlock:(NSArray *)locks forZone:(NSString *)zone;

//Playlist for Map
- (NSArray *)playlistForMap:(NSString *)mapName;

@end
