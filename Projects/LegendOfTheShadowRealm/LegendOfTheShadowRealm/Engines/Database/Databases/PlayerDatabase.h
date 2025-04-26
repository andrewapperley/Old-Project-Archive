//
//  PlayerDatabase.h
//  LegendOfTheShadowRealm
//
//  Created by Jeremy Fuellert on 2012-11-24.
//
//

#import "DatabaseBase.h"
#import "Shell.h"

@interface PlayerDatabase : DatabaseBase

@property (nonatomic, assign) int currentRowId;

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSArray *activeSkills;
@property (nonatomic, retain) NSArray *passiveSkills;
@property (nonatomic, retain) NSMutableArray *activeQuests;
@property (nonatomic, retain) NSMutableArray *completedQuests;

@property (nonatomic, assign) int level;
@property (nonatomic, assign) float health;
@property (nonatomic, assign) float health_max;
@property (nonatomic, assign) float experience;
@property (nonatomic, assign) float experience_max;
@property (nonatomic, assign) float strength;
@property (nonatomic, assign) float dexterity;
@property (nonatomic, assign) float stamina;
@property (nonatomic, assign) float speed;
@property (nonatomic, assign) float range;
@property (nonatomic, assign) float armor;
@property (nonatomic, assign) float minWeaponDamage;
@property (nonatomic, assign) float maxWeaponDamage;
@property (nonatomic, assign) float weaponStrength;

@property (nonatomic, assign) int worldPositionX;
@property (nonatomic, assign) int worldPositionY;
@property (nonatomic, assign) int dungeonPositionX;
@property (nonatomic, assign) int dungeonPositionY;
@property (nonatomic, retain) NSString *currentMap;

@property (nonatomic, assign) int weaponType;
@property (nonatomic, retain) NSArray *inventoryItems;
@property (nonatomic, retain) NSArray *equippedItems;

//Player creation and deletion
- (void)createNewPlayer;
- (void)deletePlayer:(int)rowId;

/*
 * Multiple character information
 */
- (int)numberOfPlayers;
- (int)playerRowIdByIndex:(int)index;
- (NSDictionary *)basicPlayerInformationByIndex:(int)playerDatabaseIndex;

@end
