//
//  EnemyDatabase.h
//  LegendOfTheShadowRealm
//
//  Created by Jeremy Fuellert on 2012-11-24.
//
//

#import "DatabaseBase.h"

@interface EnemyDatabase : DatabaseBase

//Retrieval Methods
- (NSDictionary *)enemyFromRow:(int)rowId;
- (NSDictionary *)enemyFromUid:(unsigned long long)luid;
- (NSArray *)enemiesFromZone:(NSString *)zone;

//Uid
- (unsigned long long)uidFromRowId:(int)rowId;
- (NSMutableArray *)uidsFromZone:(NSString *)zone;

//BoundsX
- (int)boundsXFromRowId:(int)rowId;
- (int)boundsXFromUid:(unsigned long long)uid;

//BoundsY
- (int)boundsYFromRowId:(int)rowId;
- (int)boundsYFromUid:(unsigned long long)uid;

//Direction Change Time
- (float)directionChangeTimeByRowId:(int)rowId;
- (float)directionChangeTimeByUid:(unsigned long long)uid;

//Run Speed
- (float)runSpeedByRowId:(int)rowId;
- (float)runSpeedFromUid:(unsigned long long)uid;

//Health
- (float)healthByRowId:(int)rowId;
- (float)healthFromUid:(unsigned long long)uid;

//Experience
- (float)experienceByRowId:(int)rowId;
- (float)experienceFromUid:(unsigned long long)uid;

//Strength
- (float)strengthByRowId:(int)rowId;
- (float)strengthFromUid:(unsigned long long)uid;

//Dexterity
- (float)dexterityByRowId:(int)rowId;
- (float)dexterityFromUid:(unsigned long long)uid;

//Stamina
- (float)staminaByRowId:(int)rowId;
- (float)staminaFromUid:(unsigned long long)uid;

//Speed
- (float)speedByRowId:(int)rowId;
- (float)speedFromUid:(unsigned long long)uid;

//Range
- (float)rangeByRowId:(int)rowId;
- (float)rangeFromUid:(unsigned long long)uid;

//Arnor
- (float)armorByRowId:(int)rowId;
- (float)armorFromUid:(unsigned long long)uid;

//Radius
- (float)radiusByRowId:(int)rowId;
- (float)radiusFromUid:(unsigned long long)uid;

//Skills
- (NSArray *)activeSkillsByRowId:(int)rowId;
- (NSArray *)activeSkillsFromUid:(unsigned long long)uid;

//Zone
- (NSString *)zoneFromRowId:(int)rowId;
- (NSString *)zoneFromUid:(unsigned long long)uid;

//Min Weapon Damage
- (float)minWeaponDamageByRowId:(int)rowId;
- (float)minWeaponDamageFromUid:(unsigned long long)uid;

//Max Weapon Damage
- (float)maxWeaponDamageByRowId:(int)rowId;
- (float)maxWeaponDamageFromUid:(unsigned long long)uid;

//Weapon Strength
- (float)weaponStrengthByRowId:(int)rowId;
- (float)weaponStrengthFromUid:(unsigned long long)uid;

@end
