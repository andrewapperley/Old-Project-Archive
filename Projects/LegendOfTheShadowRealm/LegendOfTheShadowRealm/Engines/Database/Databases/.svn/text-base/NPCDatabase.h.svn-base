//
//  NPCDatabase.h
//  LegendOfTheShadowRealm
//
//  Created by Jeremy Fuellert on 2012-11-24.
//
//

#import "DatabaseBase.h"

@interface NPCDatabase : DatabaseBase

//Retrieval Methods
- (NSDictionary *)npcFromRow:(int)rowId;
- (NSDictionary *)npcFromUid:(unsigned long long)luid;
- (NSArray *)npcsFromZone:(NSString *)zone;

//Uid
- (unsigned long long)uidFromRowId:(int)rowId;
- (NSMutableArray *)uidsFromZone:(NSString *)zone;

//PositionX
- (int)positionXFromRowId:(int)rowId;
- (int)positionXFromUid:(unsigned long long)uid;
- (void)setPositionX:(int)positionX atUid:(unsigned long long)uid;

//PositionY
- (int)positionYFromRowId:(int)rowId;
- (int)positionYFromUid:(unsigned long long)uid;
- (void)setPositionY:(int)positionY atUid:(unsigned long long)uid;

//BoundsX
- (int)boundsXFromRowId:(int)rowId;
- (int)boundsXFromUid:(unsigned long long)uid;
- (void)setBoundsX:(int)boundsX atUid:(unsigned long long)uid;

//BoundsY
- (int)boundsYFromRowId:(int)rowId;
- (int)boundsYFromUid:(unsigned long long)uid;
- (void)setBoundsY:(int)boundsY atUid:(unsigned long long)uid;

//Speed
- (float)speedByRowId:(int)rowId;
- (float)speedFromUid:(unsigned long long)uid;
- (void)setSpeed:(float)speed atUid:(unsigned long long)uid;

//Radius
- (float)radiusByRowId:(int)rowId;
- (float)radiusFromUid:(unsigned long long)uid;
- (void)setRadius:(float)radius atUid:(unsigned long long)uid;

//Direction Change Time
- (float)directionChangeTimeByRowId:(int)rowId;
- (float)directionChangeTimeByUid:(unsigned long long)uid;
- (void)setDirectionChangeTime:(float)time atUid:(unsigned long long)uid;

//Quests
- (NSArray *)questsFromRowId:(int)rowId;
- (NSArray *)questsFromUid:(unsigned long long)uid;
- (void)setQuests:(NSArray *)quests atUid:(unsigned long long)uid;

//Name
- (NSString *)nameFromRowId:(int)rowId;
- (NSString *)nameFromUid:(unsigned long long)uid;

//Map
- (NSString *)mapFromRowId:(int)rowId;
- (NSString *)mapFromUid:(unsigned long long)uid;
- (void)setMap:(NSString *)map atUid:(unsigned long long)uid;

//Zone
- (NSString *)zoneFromRowId:(int)rowId;
- (NSString *)zoneFromUid:(unsigned long long)uid;
- (void)setZone:(NSString *)zone atUid:(unsigned long long)uid;

@end
