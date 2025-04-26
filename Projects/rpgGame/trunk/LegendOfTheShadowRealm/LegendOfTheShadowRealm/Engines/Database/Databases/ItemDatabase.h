//
//  ItemDatabase.h
//  LegendOfTheShadowRealm
//
//  Created by Jeremy Fuellert on 2013-01-12.
//
//

#import "DatabaseBase.h"

enum ItemType
{
    //Misc
    Misc            = 0,
    
    //Armors
    Helmet          = 1,
    Shoulder        = 2,
    Chest           = 3,
    Hands           = 4,
    Belt            = 5,
    Legs            = 6,
    Feet            = 7,
    Ring            = 8,
    
    //Weapons
    None            = 20,
    Dagger          = 21,
    Axe             = 22,
    Bow             = 23,
    Sword           = 24,
    Throwing        = 25,
    WristBlades     = 26,
    Darts           = 27
};

@interface ItemDatabase : DatabaseBase

//Item Retrieval
- (NSDictionary *)itemByUid:(unsigned long long)uid;
- (NSMutableArray *)itemsByUidArray:(NSArray *)litemNameArray;
- (NSMutableArray *)itemsByZone:(uint)zone;

//Type
- (int)typeByUid:(unsigned long long)uid;

//UID
- (NSString *)nameByUid:(unsigned long long)uid;

//Min Damage
- (float)minDamageByUid:(unsigned long long)uid;

//Max Damage
- (float)maxDamageByUid:(unsigned long long)uid;

//Strength
- (float)strengthByUid:(unsigned long long)uid;

//Stamina
- (float)staminaByUid:(unsigned long long)uid;

//Speed
- (float)speedByUid:(unsigned long long)uid;

//Dexterity
- (float)dexterityByUid:(unsigned long long)uid;

//Range
- (float)rangeByUid:(unsigned long long)uid;

//Armor
- (float)armorByUid:(unsigned long long)uid;

//Description
- (NSString *)descriptionByUid:(unsigned long long)uid;

//Zone
- (uint)zoneByUid:(unsigned long long)uid;

//Uids
- (NSMutableArray *)uidsByZone:(uint)zone;

@end
