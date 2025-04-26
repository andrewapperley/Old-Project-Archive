//
//  ItemDatabase.m
//  LegendOfTheShadowRealm
//
//  Created by Jeremy Fuellert on 2013-01-12.
//
//

#import "Constants.h"
#import "ItemDatabase.h"

@implementation ItemDatabase

- (id)init
{
    return [self initWithDatabase:DATABASE_ITEM_DATABASE];
}

/*
 * Item Retrieval Methods
 *
 * These methods are used to retrieve an NSDictionary object(s) with object and key combinations.
 * These call returns will go into various classes to be added as properties to that object.
 */

- (NSDictionary *)itemByUid:(unsigned long long)uid
{
    NSMutableDictionary *dictionary = [NSMutableDictionary new];
    
    NSString *name = [self nameByUid:uid];
    NSNumber *type = [NSNumber numberWithInt:[self typeByUid:uid]];
    NSNumber *_uid = [NSNumber numberWithUnsignedLongLong:uid];
    NSNumber *minDamage = [NSNumber numberWithFloat:[self minDamageByUid:uid]];
    NSNumber *maxDamage = [NSNumber numberWithFloat:[self maxDamageByUid:uid]];
    NSNumber *strength = [NSNumber numberWithFloat:[self strengthByUid:uid]];
    NSNumber *speed = [NSNumber numberWithFloat:[self speedByUid:uid]];
    NSNumber *dexterity = [NSNumber numberWithFloat:[self dexterityByUid:uid]];
    NSNumber *range = [NSNumber numberWithFloat:[self rangeByUid:uid]];
    NSNumber *armor = [NSNumber numberWithFloat:[self armorByUid:uid]];
    NSString *description = [self descriptionByUid:uid];
    
    [dictionary setObject:name forKey:@"name"];
    [dictionary setObject:type forKey:@"type"];
    [dictionary setObject:_uid forKey:@"uid"];
    [dictionary setObject:minDamage forKey:@"minDamage"];
    [dictionary setObject:maxDamage forKey:@"maxDamage"];
    [dictionary setObject:strength forKey:@"strength"];
    [dictionary setObject:speed forKey:@"speed"];
    [dictionary setObject:dexterity forKey:@"dexterity"];
    [dictionary setObject:range forKey:@"range"];
    [dictionary setObject:armor forKey:@"armor"];
    if(description && description.length > 0)[dictionary setObject:description forKey:@"description"];

    return [dictionary autorelease];
}

- (NSMutableArray *)itemsByUidArray:(NSArray *)luidArray
{
    NSMutableArray *itemObjectArray = [NSMutableArray new];
    NSArray *uidArray = [luidArray retain];
    
    for(int i = 0; i < uidArray.count; i++)
    {
        unsigned long long uid = (unsigned long long)[uidArray objectAtIndex:i];
        NSDictionary *itemObject = [[self itemByUid:uid] retain];
        [itemObjectArray addObject:itemObject];
        [self destroy:itemObject];
    }
        
    [self destroy:uidArray];
    
    return [itemObjectArray autorelease];
}

- (NSMutableArray *)itemsByZone:(uint)zone
{
    NSMutableArray *itemObjectArray = [NSMutableArray new];
    NSArray *itemUidList = [[self uidsByZone:zone] retain];
    
    for(int i = 0; i < itemUidList.count; i++)
    {
        unsigned long long uid = [(NSNumber *)[itemUidList objectAtIndex:i] unsignedLongLongValue];
        NSDictionary *itemObject = [[self itemByUid:uid] retain];
        [itemObjectArray addObject:itemObject];
        [self destroy:itemObject];
    }
    
    [self destroy:itemUidList];
    
    return [itemObjectArray autorelease];
}

/*
 * Type
 */
- (int)typeByUid:(unsigned long long)uid
{
    //Return value
    int _type = 0;
    
    //Query
    NSString *query = [NSString stringWithFormat:@"SELECT type FROM Items WHERE uid = %lld", uid];
    sqlite3_stmt *statement;
    sqlite3 *database;
    
    if(sqlite3_open([self.path UTF8String], &database) == SQLITE_OK)
    {
        if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if(sqlite3_step(statement) == SQLITE_ROW)
            {
                _type = (int)sqlite3_column_int(statement, 0);
            }
            sqlite3_finalize(statement);
        } else {
            [DatabaseBase failedToRunQuery:[query UTF8String]];
        }
        sqlite3_close(database);
    } else {
        [DatabaseBase failedToOpen];
    }
    return _type;
}

/*
 * Name
 */
- (NSString *)nameByUid:(unsigned long long)uid
{
    //Return value
    NSString *_name = @"";
    
    //Query
    NSString *query = [NSString stringWithFormat:@"SELECT name FROM Items WHERE uid = %lld", uid];
    sqlite3_stmt *statement;
    sqlite3 *database;
    
    if(sqlite3_open([self.path UTF8String], &database) == SQLITE_OK)
    {
        if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if(sqlite3_step(statement) == SQLITE_ROW)
            {
                _name = ((const char *)sqlite3_column_text(statement, 0)) ? [NSString stringWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] : nil;
            }
            sqlite3_finalize(statement);
        } else {
            [DatabaseBase failedToRunQuery:[query UTF8String]];
        }
        sqlite3_close(database);
    } else {
        [DatabaseBase failedToOpen];
    }
    return _name;
}

/*
 * Min Damage
 */
- (float)minDamageByUid:(unsigned long long)uid
{
    //Return value
    float _minDamage = 0.0f;
    
    //Query
    NSString *query = [NSString stringWithFormat:@"SELECT minDamage FROM Items WHERE uid = %lld", uid];
    sqlite3_stmt *statement;
    sqlite3 *database;
    
    if(sqlite3_open([self.path UTF8String], &database) == SQLITE_OK)
    {
        if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if(sqlite3_step(statement) == SQLITE_ROW)
            {
                _minDamage = (float)sqlite3_column_double(statement, 0);
            }
            sqlite3_finalize(statement);
        } else {
            [DatabaseBase failedToRunQuery:[query UTF8String]];
        }
        sqlite3_close(database);
    } else {
        [DatabaseBase failedToOpen];
    }
    return _minDamage;
}

/*
 * Max Damage
 */
- (float)maxDamageByUid:(unsigned long long)uid
{
    //Return value
    float _maxDamage = 0.0f;
    
    //Query
    NSString *query = [NSString stringWithFormat:@"SELECT maxDamage FROM Items WHERE uid = %lld", uid];
    sqlite3_stmt *statement;
    sqlite3 *database;
    
    if(sqlite3_open([self.path UTF8String], &database) == SQLITE_OK)
    {
        if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if(sqlite3_step(statement) == SQLITE_ROW)
            {
                _maxDamage = (float)sqlite3_column_double(statement, 0);
            }
            sqlite3_finalize(statement);
        } else {
            [DatabaseBase failedToRunQuery:[query UTF8String]];
        }
        sqlite3_close(database);
    } else {
        [DatabaseBase failedToOpen];
    }
    return _maxDamage;
}

/*
 * Strength
 */
- (float)strengthByUid:(unsigned long long)uid
{
    //Return value
    float _strength = 0.0f;
    
    //Query
    NSString *query = [NSString stringWithFormat:@"SELECT strength FROM Items WHERE uid = %lld", uid];
    sqlite3_stmt *statement;
    sqlite3 *database;
    
    if(sqlite3_open([self.path UTF8String], &database) == SQLITE_OK)
    {
        if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if(sqlite3_step(statement) == SQLITE_ROW)
            {
                _strength = (float)sqlite3_column_double(statement, 0);
            }
            sqlite3_finalize(statement);
        } else {
            [DatabaseBase failedToRunQuery:[query UTF8String]];
        }
        sqlite3_close(database);
    } else {
        [DatabaseBase failedToOpen];
    }
    return _strength;
}

/*
 * Stamina
 */
- (float)staminaByUid:(unsigned long long)uid
{
    //Return value
    float _stamina = 0.0f;
    
    //Query
    NSString *query = [NSString stringWithFormat:@"SELECT stamina FROM Items WHERE uid = %lld", uid];
    sqlite3_stmt *statement;
    sqlite3 *database;
    
    if(sqlite3_open([self.path UTF8String], &database) == SQLITE_OK)
    {
        if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if(sqlite3_step(statement) == SQLITE_ROW)
            {
                _stamina = (float)sqlite3_column_double(statement, 0);
            }
            sqlite3_finalize(statement);
        } else {
            [DatabaseBase failedToRunQuery:[query UTF8String]];
        }
        sqlite3_close(database);
    } else {
        [DatabaseBase failedToOpen];
    }
    return _stamina;
}

/*
 * Speed
 */
- (float)speedByUid:(unsigned long long)uid
{
    //Return value
    float _speed = 0.0f;
    
    //Query
    NSString *query = [NSString stringWithFormat:@"SELECT speed FROM Items WHERE uid = %lld", uid];
    sqlite3_stmt *statement;
    sqlite3 *database;
    
    if(sqlite3_open([self.path UTF8String], &database) == SQLITE_OK)
    {
        if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if(sqlite3_step(statement) == SQLITE_ROW)
            {
                _speed = (float)sqlite3_column_double(statement, 0);
            }
            sqlite3_finalize(statement);
        } else {
            [DatabaseBase failedToRunQuery:[query UTF8String]];
        }
        sqlite3_close(database);
    } else {
        [DatabaseBase failedToOpen];
    }
    return _speed;
}

/*
 * Dexterity
 */
- (float)dexterityByUid:(unsigned long long)uid
{
    //Return value
    float _dexterity = 0.0f;
    
    //Query
    NSString *query = [NSString stringWithFormat:@"SELECT dexterity FROM Items WHERE uid = %lld", uid];
    sqlite3_stmt *statement;
    sqlite3 *database;
    
    if(sqlite3_open([self.path UTF8String], &database) == SQLITE_OK)
    {
        if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if(sqlite3_step(statement) == SQLITE_ROW)
            {
                _dexterity = (float)sqlite3_column_double(statement, 0);
            }
            sqlite3_finalize(statement);
        } else {
            [DatabaseBase failedToRunQuery:[query UTF8String]];
        }
        sqlite3_close(database);
    } else {
        [DatabaseBase failedToOpen];
    }
    return _dexterity;
}

/*
 * Range
 */
- (float)rangeByUid:(unsigned long long)uid
{
    //Return value
    float _range = 0.0f;
    
    //Query
    NSString *query = [NSString stringWithFormat:@"SELECT range FROM Items WHERE uid = %lld", uid];
    sqlite3_stmt *statement;
    sqlite3 *database;
    
    if(sqlite3_open([self.path UTF8String], &database) == SQLITE_OK)
    {
        if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if(sqlite3_step(statement) == SQLITE_ROW)
            {
                _range = (float)sqlite3_column_double(statement, 0);
            }
            sqlite3_finalize(statement);
        } else {
            [DatabaseBase failedToRunQuery:[query UTF8String]];
        }
        sqlite3_close(database);
    } else {
        [DatabaseBase failedToOpen];
    }
    return _range;
}

/*
 * Armor
 */
- (float)armorByUid:(unsigned long long)uid
{
    //Return value
    float _armor = 0.0f;
    
    //Query
    NSString *query = [NSString stringWithFormat:@"SELECT armor FROM Items WHERE uid = %lld", uid];
    sqlite3_stmt *statement;
    sqlite3 *database;
    
    if(sqlite3_open([self.path UTF8String], &database) == SQLITE_OK)
    {
        if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if(sqlite3_step(statement) == SQLITE_ROW)
            {
                _armor = (float)sqlite3_column_double(statement, 0);
            }
            sqlite3_finalize(statement);
        } else {
            [DatabaseBase failedToRunQuery:[query UTF8String]];
        }
        sqlite3_close(database);
    } else {
        [DatabaseBase failedToOpen];
    }
    return _armor;
}

/*
 * Description
 */
- (NSString *)descriptionByUid:(unsigned long long)uid
{
    //Return value
    NSString *_description = @"";
    
    //Query
    NSString *query = [NSString stringWithFormat:@"SELECT description FROM Items WHERE uid = %lld", uid];
    sqlite3_stmt *statement;
    sqlite3 *database;
    
    if(sqlite3_open([self.path UTF8String], &database) == SQLITE_OK)
    {
        if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if(sqlite3_step(statement))
            {
                _description = ((const char *)sqlite3_column_text(statement, 0)) ? [NSString stringWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] : nil;
            }
            sqlite3_finalize(statement);
        } else {
            [DatabaseBase failedToRunQuery:[query UTF8String]];
        }
        sqlite3_close(database);
    } else {
        [DatabaseBase failedToOpen];
    }
    return _description;
}

/*
 * Zone
 */
- (uint)zoneByUid:(unsigned long long)uid
{
    //Return value
    uint _zone = 0;
    
    //Query
    NSString *query = [NSString stringWithFormat:@"SELECT zone FROM Items WHERE uid = %lld", uid];
    sqlite3_stmt *statement;
    sqlite3 *database;
    
    if(sqlite3_open([self.path UTF8String], &database) == SQLITE_OK)
    {
        if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if(sqlite3_step(statement) == SQLITE_ROW)
            {
                _zone = (float)sqlite3_column_double(statement, 0);
            }
            sqlite3_finalize(statement);
        } else {
            [DatabaseBase failedToRunQuery:[query UTF8String]];
        }
        sqlite3_close(database);
    } else {
        [DatabaseBase failedToOpen];
    }
    return _zone;
}

/*
 * Uid
 */
- (NSMutableArray *)uidsByZone:(uint)zone
{
    //Return value
    NSMutableArray *uid = [NSMutableArray new];
    
    //Query
    NSString *query = [NSString stringWithFormat:@"SELECT uid FROM Items WHERE zone = %d", zone];
    sqlite3_stmt *statement;
    sqlite3 *database;
    
    if(sqlite3_open([self.path UTF8String], &database) == SQLITE_OK)
    {
        if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            while(sqlite3_step(statement) == SQLITE_ROW)
            {
                unsigned long long __uid = (unsigned long long)sqlite3_column_int(statement, 0);
                [uid addObject:[NSNumber numberWithLongLong:__uid]];
            }
            sqlite3_finalize(statement);
        } else {
            [DatabaseBase failedToRunQuery:[query UTF8String]];
        }
        sqlite3_close(database);
    } else {
        [DatabaseBase failedToOpen];
    }
    return [uid autorelease];
}

@end
