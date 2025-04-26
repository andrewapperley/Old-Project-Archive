//
//  DefaultPlayer.m
//  LegendOfTheShadowRealm
//
//  Created by Jeremy Fuellert on 2013-03-04.
//
//

#import "DefaultPlayer.h"

//Table name
#define TABLE_NAME  @"Player"

//Default keys
#define DEFAULT_KEYS [NSArray arrayWithObjects:     \
@"name",                                            \
@"health",                                          \
@"health_max",                                      \
@"experience",                                      \
@"experience_max",                                  \
@"strength",                                        \
@"dexterity",                                       \
@"stamina",                                         \
@"speed",                                           \
@"range",                                           \
@"armor",                                           \
@"activeSkills",                                    \
@"passiveSkills",                                   \
@"activeQuests",                                    \
@"completedQuests",                                 \
@"level",                                           \
@"currentMap",                                      \
@"dungeonPositionX",                                \
@"dungeonPositionY",                                \
@"worldPositionX",                                  \
@"worldPositionY",                                  \
@"weaponType",                                      \
@"minWeaponDamage",                                 \
@"maxWeaponDamage",                                 \
@"weaponStrength",                                  \
@"equippedItems",                                   \
@"inventoryItems", nil]

//Default values
#define DEFAULT_VALUES [NSArray arrayWithObjects:   \
@"NULL",                                            \
@"200",                                             \
@"200",                                             \
@"0",                                               \
@"100",                                             \
@"80",                                              \
@"30",                                              \
@"50",                                              \
@"1.2",                                             \
@"1",                                               \
@"200",                                             \
@"NULL",                                            \
@"NULL",                                            \
@"\"147168992,146856993,146856994,146856995\"",     \
@"NULL",                                            \
@"1",                                               \
@"\"testMap\"",                                     \
@"0",                                               \
@"0",                                               \
@"0",                                               \
@"0",                                               \
@"\"none\"",                                        \
@"14",                                              \
@"18",                                              \
@"45",                                              \
@"NULL",                                            \
@"NULL", nil]

@implementation DefaultPlayer

+ (NSString *)createDefaultPlayerQuery
{
    NSMutableString *returnString = [NSMutableString string];
    [returnString appendString:@"INSERT INTO "];
    [returnString appendString:TABLE_NAME];
    
    //Keys
    [returnString appendString:@"("];
    for(uint i = 0; i < [DEFAULT_KEYS count]; i++)
    {
        [returnString appendString:[DEFAULT_KEYS objectAtIndex:i]];
        
        if(i < [DEFAULT_KEYS count] - 1)
            [returnString appendString:@", "];
    }
    [returnString appendString:@") "];
    
    //Values
    [returnString appendString:@"Values("];
    for(uint i = 0; i < [DEFAULT_VALUES count]; i++)
    {
        [returnString appendString:[DEFAULT_VALUES objectAtIndex:i]];
        
        if(i < [DEFAULT_VALUES count] - 1)
            [returnString appendString:@", "];
    }
    [returnString appendString:@") "];
    
    return returnString;
}

@end
