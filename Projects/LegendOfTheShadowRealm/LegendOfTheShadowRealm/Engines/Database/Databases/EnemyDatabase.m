//
//  EnemyDatabase.m
//  LegendOfTheShadowRealm
//
//  Created by Jeremy Fuellert on 2012-11-24.
//
//

#import "EnemyDatabase.h"

@implementation EnemyDatabase

- (id)init
{
    return [self initWithDatabase:DATABASE_ENEMY_DATABASE];
}

/*
 * Enemy Retrieval Methods
 *
 * These methods are used to retrieve an NSDictionary object(s) with object and key combinations.
 * These call returns will go into EnemyBase class to be added as properties to that Enemy object.
 */

- (NSDictionary *)enemyFromRow:(int)rowId
{
    NSMutableDictionary *dictionary = [NSMutableDictionary new];
    
    NSNumber *uid = [NSNumber numberWithUnsignedLongLong:[self uidFromRowId:rowId]];
    NSNumber *boundsX = [NSNumber numberWithInt:[self boundsXFromRowId:rowId]];
    NSNumber *boundsY = [NSNumber numberWithInt:[self boundsYFromRowId:rowId]];
    NSNumber *directionChangeTime = [NSNumber numberWithFloat:[self directionChangeTimeByRowId:rowId]];
    NSNumber *runSpeed = [NSNumber numberWithFloat:[self runSpeedByRowId:rowId]];
    NSNumber *health = [NSNumber numberWithFloat:[self healthByRowId:rowId]];
    NSNumber *experience = [NSNumber numberWithFloat:[self experienceByRowId:rowId]];
    NSNumber *strength = [NSNumber numberWithFloat:[self strengthByRowId:rowId]];
    NSNumber *dexterity = [NSNumber numberWithFloat:[self dexterityByRowId:rowId]];
    NSNumber *stamina = [NSNumber numberWithFloat:[self staminaByRowId:rowId]];
    NSNumber *speed = [NSNumber numberWithFloat:[self speedByRowId:rowId]];
    NSNumber *range = [NSNumber numberWithFloat:[self radiusByRowId:rowId]];
    NSNumber *armor = [NSNumber numberWithFloat:[self armorByRowId:rowId]];
    NSNumber *radius = [NSNumber numberWithFloat:[self radiusByRowId:rowId]];
    NSArray *activeSkills = [self activeSkillsByRowId:rowId];
    NSString *map = @"";
    NSString *zone = [self zoneFromRowId:rowId];
    NSNumber *minWeaponDamage = [NSNumber numberWithFloat:[self minWeaponDamageByRowId:rowId]];
    NSNumber *maxWeaponDamage = [NSNumber numberWithFloat:[self maxWeaponDamageByRowId:rowId]];
    NSNumber *weaponStrength = [NSNumber numberWithFloat:[self weaponStrengthByRowId:rowId]];
    
    [dictionary setObject:uid forKey:@"uid"];
    [dictionary setObject:boundsX forKey:@"boundsX"];
    [dictionary setObject:boundsY forKey:@"boundsY"];
    [dictionary setObject:directionChangeTime forKey:@"directionChangeTime"];
    [dictionary setObject:runSpeed forKey:@"runSpeed"];
    [dictionary setObject:health forKey:@"health"];
    [dictionary setObject:experience forKey:@"experience"];
    [dictionary setObject:strength forKey:@"strength"];
    [dictionary setObject:dexterity forKey:@"dexterity"];
    [dictionary setObject:stamina forKey:@"stamina"];
    [dictionary setObject:speed forKey:@"speed"];
    [dictionary setObject:range forKey:@"range"];
    [dictionary setObject:armor forKey:@"armor"];
    [dictionary setObject:radius forKey:@"radius"];
    [dictionary setObject:activeSkills forKey:@"activeSkills"];
    [dictionary setObject:map forKey:@"map"];
    [dictionary setObject:zone forKey:@"zone"];
    [dictionary setObject:minWeaponDamage forKey:@"minWeaponDamage"];
    [dictionary setObject:maxWeaponDamage forKey:@"maxWeaponDamage"];
    [dictionary setObject:weaponStrength forKey:@"weaponStrength"];
    
    NSDictionary *enemyObject = [[NSDictionary alloc] initWithDictionary:dictionary];
    
    [self destroy:dictionary];
    
    return [enemyObject autorelease];
}

- (NSDictionary *)enemyFromUid:(unsigned long long)luid
{
    NSMutableDictionary *dictionary = [NSMutableDictionary new];
    
    NSNumber *uid = [NSNumber numberWithUnsignedLongLong:luid];
    NSNumber *boundsX = [NSNumber numberWithInt:[self boundsXFromUid:luid]];
    NSNumber *boundsY = [NSNumber numberWithInt:[self boundsYFromUid:luid]];
    NSNumber *directionChangeTime = [NSNumber numberWithFloat:[self directionChangeTimeByUid:luid]];
    NSNumber *runSpeed = [NSNumber numberWithFloat:[self runSpeedFromUid:luid]];
    NSNumber *health = [NSNumber numberWithFloat:[self healthFromUid:luid]];
    NSNumber *experience = [NSNumber numberWithFloat:[self experienceFromUid:luid]];
    NSNumber *strength = [NSNumber numberWithFloat:[self strengthFromUid:luid]];
    NSNumber *dexterity = [NSNumber numberWithFloat:[self dexterityFromUid:luid]];
    NSNumber *stamina = [NSNumber numberWithFloat:[self staminaFromUid:luid]];
    NSNumber *speed = [NSNumber numberWithFloat:[self speedFromUid:luid]];
    NSNumber *range = [NSNumber numberWithFloat:[self radiusFromUid:luid]];
    NSNumber *armor = [NSNumber numberWithFloat:[self armorFromUid:luid]];
    NSNumber *radius = [NSNumber numberWithFloat:[self rangeFromUid:luid]];
    NSArray *activeSkills = [self activeSkillsFromUid:luid];
    NSString *map = @"";
    NSString *zone = [self zoneFromUid:luid];
    NSNumber *minWeaponDamage = [NSNumber numberWithFloat:[self minWeaponDamageFromUid:luid]];
    NSNumber *maxWeaponDamage = [NSNumber numberWithFloat:[self maxWeaponDamageFromUid:luid]];
    NSNumber *weaponStrength = [NSNumber numberWithFloat:[self weaponStrengthFromUid:luid]];
    
    [dictionary setObject:uid forKey:@"uid"];
    [dictionary setObject:boundsX forKey:@"boundsX"];
    [dictionary setObject:boundsY forKey:@"boundsY"];
    [dictionary setObject:directionChangeTime forKey:@"directionChangeTime"];
    [dictionary setObject:runSpeed forKey:@"runSpeed"];
    [dictionary setObject:health forKey:@"health"];
    [dictionary setObject:experience forKey:@"experience"];
    [dictionary setObject:strength forKey:@"strength"];
    [dictionary setObject:dexterity forKey:@"dexterity"];
    [dictionary setObject:stamina forKey:@"stamina"];
    [dictionary setObject:speed forKey:@"speed"];
    [dictionary setObject:range forKey:@"range"];
    [dictionary setObject:armor forKey:@"armor"];
    [dictionary setObject:radius forKey:@"radius"];
    [dictionary setObject:activeSkills forKey:@"activeSkills"];
    [dictionary setObject:map forKey:@"map"];
    [dictionary setObject:zone forKey:@"zone"];
    [dictionary setObject:minWeaponDamage forKey:@"minWeaponDamage"];
    [dictionary setObject:maxWeaponDamage forKey:@"maxWeaponDamage"];
    [dictionary setObject:weaponStrength forKey:@"weaponStrength"];
    
    NSDictionary *enemyObject = [[NSDictionary alloc] initWithDictionary:dictionary];
    
    [self destroy:dictionary];
    
    return [enemyObject autorelease];
}

- (NSArray *)enemiesFromZone:(NSString *)zone
{
    NSMutableArray *enemyList = [NSMutableArray new];
    NSArray *enemyUidList = [[self uidsFromZone:zone] retain];
    
    for(int i = 0; i < enemyUidList.count; i++)
    {
        unsigned long long uid = (unsigned long long)[(NSNumber *)[enemyUidList objectAtIndex:i] unsignedLongLongValue];
        
        NSDictionary *enemyObject = [self enemyFromUid:uid];
        [enemyList addObject:enemyObject];
    }
        
    [self destroy:enemyUidList];
    
    return [enemyList autorelease];
}

/*
 * Uid
 */
- (unsigned long long)uidFromRowId:(int)rowId
{
    //Return value
    unsigned long long _uid = 0;
    
    //Query
    NSString *query = [NSString stringWithFormat:@"SELECT uid FROM Enemy WHERE rowId = %d", rowId];
    sqlite3_stmt *statement;
    sqlite3 *database;
    
    if(sqlite3_open([self.path UTF8String], &database) == SQLITE_OK)
    {
        if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if(sqlite3_step(statement) == SQLITE_ROW)
            {
                _uid = (unsigned long long)sqlite3_column_int(statement, 0);
            }
            sqlite3_finalize(statement);
        } else {
            [DatabaseBase failedToRunQuery:[query UTF8String]];
        }
        sqlite3_close(database);
    } else {
        [DatabaseBase failedToOpen];
    }
    return _uid;
}

- (NSMutableArray *)uidsFromZone:(NSString *)zone
{
    //Return value
    NSMutableArray *uid = [NSMutableArray new];
    
    //Query
    NSString *query = [NSString stringWithFormat:@"SELECT uid FROM Enemy WHERE zone = \'%@\'", zone];
    sqlite3_stmt *statement;
    sqlite3 *database;
    
    if(sqlite3_open([self.path UTF8String], &database) == SQLITE_OK)
    {
        if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            while(sqlite3_step(statement) == SQLITE_ROW)
            {
                long long __uid = (long long)sqlite3_column_int(statement, 0);
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

/*
 * Bounds X
 */
- (int)boundsXFromRowId:(int)rowId
{
    //Return value
    int _boundsX = 0;
    
    //Query
    NSString *query = [NSString stringWithFormat:@"SELECT boundsX FROM Enemy WHERE rowId = %d", rowId];
    sqlite3_stmt *statement;
    sqlite3 *database;
    
    if(sqlite3_open([self.path UTF8String], &database) == SQLITE_OK)
    {
        if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if(sqlite3_step(statement) == SQLITE_ROW)
            {
                _boundsX = (int)sqlite3_column_int(statement, 0);
            }
            sqlite3_finalize(statement);
        } else {
            [DatabaseBase failedToRunQuery:[query UTF8String]];
        }
        sqlite3_close(database);
    } else {
        [DatabaseBase failedToOpen];
    }
    return _boundsX;
}

- (int)boundsXFromUid:(unsigned long long)uid
{
    //Return value
    int _boundsX = 0;
    
    //Query
    NSString *query = [NSString stringWithFormat:@"SELECT boundsX FROM Enemy WHERE uid = %lld", uid];
    sqlite3_stmt *statement;
    sqlite3 *database;
    
    if(sqlite3_open([self.path UTF8String], &database) == SQLITE_OK)
    {
        if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if(sqlite3_step(statement) == SQLITE_ROW)
            {
                _boundsX = (int)sqlite3_column_int(statement, 0);
            }
            sqlite3_finalize(statement);
        } else {
            [DatabaseBase failedToRunQuery:[query UTF8String]];
        }
        sqlite3_close(database);
    } else {
        [DatabaseBase failedToOpen];
    }
    return _boundsX;
}

/*
 * Bounds Y
 */
- (int)boundsYFromRowId:(int)rowId
{
    //Return value
    int _boundsY = 0;
    
    //Query
    NSString *query = [NSString stringWithFormat:@"SELECT boundsY FROM Enemy WHERE rowId = %d", rowId];
    sqlite3_stmt *statement;
    sqlite3 *database;
    
    if(sqlite3_open([self.path UTF8String], &database) == SQLITE_OK)
    {
        if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if(sqlite3_step(statement) == SQLITE_ROW)
            {
                _boundsY = (int)sqlite3_column_int(statement, 0);
            }
            sqlite3_finalize(statement);
        } else {
            [DatabaseBase failedToRunQuery:[query UTF8String]];
        }
        sqlite3_close(database);
    } else {
        [DatabaseBase failedToOpen];
    }
    return _boundsY;
}

- (int)boundsYFromUid:(unsigned long long)uid
{
    //Return value
    int _boundsY = 0;
    
    //Query
    NSString *query = [NSString stringWithFormat:@"SELECT boundsY FROM Enemy WHERE uid = %lld", uid];
    sqlite3_stmt *statement;
    sqlite3 *database;
    
    if(sqlite3_open([self.path UTF8String], &database) == SQLITE_OK)
    {
        if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if(sqlite3_step(statement) == SQLITE_ROW)
            {
                _boundsY = (int)sqlite3_column_int(statement, 0);
            }
            sqlite3_finalize(statement);
        } else {
            [DatabaseBase failedToRunQuery:[query UTF8String]];
        }
        sqlite3_close(database);
    } else {
        [DatabaseBase failedToOpen];
    }
    return _boundsY;
}

/*
 * Directional Change Time
 */
- (float)directionChangeTimeByRowId:(int)rowId
{
    //Return value
    float _changeTime = 0.0f;
    
    //Query
    NSString *query = [NSString stringWithFormat:@"SELECT directionChangeTime FROM Enemy WHERE rowId = %d", rowId];
    sqlite3_stmt *statement;
    sqlite3 *database;
    
    if(sqlite3_open([self.path UTF8String], &database) == SQLITE_OK)
    {
        if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if(sqlite3_step(statement) == SQLITE_ROW)
            {
                _changeTime = (float)sqlite3_column_double(statement, 0);
            }
            sqlite3_finalize(statement);
        } else {
            [DatabaseBase failedToRunQuery:[query UTF8String]];
        }
        sqlite3_close(database);
    } else {
        [DatabaseBase failedToOpen];
    }
    return _changeTime;
}

- (float)directionChangeTimeByUid:(unsigned long long)uid
{
    //Return value
    float _changeTime = 0.0f;
    
    //Query
    NSString *query = [NSString stringWithFormat:@"SELECT directionChangeTime FROM Enemy WHERE uid = %lld", uid];
    sqlite3_stmt *statement;
    sqlite3 *database;
    
    if(sqlite3_open([self.path UTF8String], &database) == SQLITE_OK)
    {
        if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if(sqlite3_step(statement) == SQLITE_ROW)
            {
                _changeTime = (float)sqlite3_column_double(statement, 0);
            }
            sqlite3_finalize(statement);
        } else {
            [DatabaseBase failedToRunQuery:[query UTF8String]];
        }
        sqlite3_close(database);
    } else {
        [DatabaseBase failedToOpen];
    }
    return _changeTime;
}

/*
 * Run Speed
 */
- (float)runSpeedByRowId:(int)rowId
{
    //Return value
    float _speed = 0.0f;
    
    //Query
    NSString *query = [NSString stringWithFormat:@"SELECT runSpeed FROM Enemy WHERE rowId = %d", rowId];
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

- (float)runSpeedFromUid:(unsigned long long)uid
{
    //Return value
    float _speed = 0.0f;
    
    //Query
    NSString *query = [NSString stringWithFormat:@"SELECT runSpeed FROM Enemy WHERE uid = %lld", uid];
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
 * Health
 */
- (float)healthByRowId:(int)rowId
{
    //Return value
    float _health = 0.0f;
    
    //Query
    NSString *query = [NSString stringWithFormat:@"SELECT health FROM Enemy WHERE rowId = %d", rowId];
    sqlite3_stmt *statement;
    sqlite3 *database;
    
    if(sqlite3_open([self.path UTF8String], &database) == SQLITE_OK)
    {
        if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if(sqlite3_step(statement) == SQLITE_ROW)
            {
                _health = (float)sqlite3_column_double(statement, 0);
            }
            sqlite3_finalize(statement);
        } else {
            [DatabaseBase failedToRunQuery:[query UTF8String]];
        }
        sqlite3_close(database);
    } else {
        [DatabaseBase failedToOpen];
    }
    return _health;
}

- (float)healthFromUid:(unsigned long long)uid
{
    //Return value
    float _health = 0.0f;
    
    //Query
    NSString *query = [NSString stringWithFormat:@"SELECT health FROM Enemy WHERE uid = %lld", uid];
    sqlite3_stmt *statement;
    sqlite3 *database;
    
    if(sqlite3_open([self.path UTF8String], &database) == SQLITE_OK)
    {
        if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if(sqlite3_step(statement) == SQLITE_ROW)
            {
                _health = (float)sqlite3_column_double(statement, 0);
            }
            sqlite3_finalize(statement);
        } else {
            [DatabaseBase failedToRunQuery:[query UTF8String]];
        }
        sqlite3_close(database);
    } else {
        [DatabaseBase failedToOpen];
    }
    return _health;
}

/*
 * Experience
 */
- (float)experienceByRowId:(int)rowId
{
    //Return value
    float _experience = 0.0f;
    
    //Query
    NSString *query = [NSString stringWithFormat:@"SELECT experience FROM Enemy WHERE rowId = %d", rowId];
    sqlite3_stmt *statement;
    sqlite3 *database;
    
    if(sqlite3_open([self.path UTF8String], &database) == SQLITE_OK)
    {
        if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if(sqlite3_step(statement) == SQLITE_ROW)
            {
                _experience = (float)sqlite3_column_double(statement, 0);
            }
            sqlite3_finalize(statement);
        } else {
            [DatabaseBase failedToRunQuery:[query UTF8String]];
        }
        sqlite3_close(database);
    } else {
        [DatabaseBase failedToOpen];
    }
    return _experience;
}

- (float)experienceFromUid:(unsigned long long)uid
{
    //Return value
    float _experience = 0.0f;
    
    //Query
    NSString *query = [NSString stringWithFormat:@"SELECT experience FROM Enemy WHERE uid = %lld", uid];
    sqlite3_stmt *statement;
    sqlite3 *database;
    
    if(sqlite3_open([self.path UTF8String], &database) == SQLITE_OK)
    {
        if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if(sqlite3_step(statement) == SQLITE_ROW)
            {
                _experience = (float)sqlite3_column_double(statement, 0);
            }
            sqlite3_finalize(statement);
        } else {
            [DatabaseBase failedToRunQuery:[query UTF8String]];
        }
        sqlite3_close(database);
    } else {
        [DatabaseBase failedToOpen];
    }
    return _experience;
}

/*
 * Strength
 */
- (float)strengthByRowId:(int)rowId
{
    //Return value
    float _strength = 0.0f;
    
    //Query
    NSString *query = [NSString stringWithFormat:@"SELECT strength FROM Enemy WHERE rowId = %d", rowId];
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

- (float)strengthFromUid:(unsigned long long)uid
{
    //Return value
    float _strength = 0.0f;
    
    //Query
    NSString *query = [NSString stringWithFormat:@"SELECT strength FROM Enemy WHERE uid = %lld", uid];
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
 * Dexterity
 */
- (float)dexterityByRowId:(int)rowId
{
    //Return value
    float _dexterity = 0.0f;
    
    //Query
    NSString *query = [NSString stringWithFormat:@"SELECT dexterity FROM Enemy WHERE rowId = %d", rowId];
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

- (float)dexterityFromUid:(unsigned long long)uid
{
    //Return value
    float _dexterity = 0.0f;
    
    //Query
    NSString *query = [NSString stringWithFormat:@"SELECT dexterity FROM Enemy WHERE uid = %lld", uid];
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
 * Stamina
 */
- (float)staminaByRowId:(int)rowId
{
    //Return value
    float _stamina = 0.0f;
    
    //Query
    NSString *query = [NSString stringWithFormat:@"SELECT stamina FROM Enemy WHERE rowId = %d", rowId];
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

- (float)staminaFromUid:(unsigned long long)uid
{
    //Return value
    float _stamina = 0.0f;
    
    //Query
    NSString *query = [NSString stringWithFormat:@"SELECT stamina FROM Enemy WHERE uid = %lld", uid];
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
- (float)speedByRowId:(int)rowId
{
    //Return value
    float _speed = 0.0f;
    
    //Query
    NSString *query = [NSString stringWithFormat:@"SELECT speed FROM Enemy WHERE rowId = %d", rowId];
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

- (float)speedFromUid:(unsigned long long)uid
{
    //Return value
    float _speed = 0.0f;
    
    //Query
    NSString *query = [NSString stringWithFormat:@"SELECT speed FROM Enemy WHERE uid = %lld", uid];
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
 * Range
 */
- (float)rangeByRowId:(int)rowId
{
    //Return value
    float _range = 0.0f;
    
    //Query
    NSString *query = [NSString stringWithFormat:@"SELECT range FROM Enemy WHERE rowId = %d", rowId];
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

- (float)rangeFromUid:(unsigned long long)uid
{
    //Return value
    float _range = 0.0f;
    
    //Query
    NSString *query = [NSString stringWithFormat:@"SELECT range FROM Enemy WHERE uid = %lld", uid];
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
- (float)armorByRowId:(int)rowId
{
    //Return value
    float _armor = 0.0f;
    
    //Query
    NSString *query = [NSString stringWithFormat:@"SELECT armor FROM Enemy WHERE rowId = %d", rowId];
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

- (float)armorFromUid:(unsigned long long)uid
{
    //Return value
    float _armor = 0.0f;
    
    //Query
    NSString *query = [NSString stringWithFormat:@"SELECT armor FROM Enemy WHERE uid = %lld", uid];
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
 * Radius
 */
- (float)radiusByRowId:(int)rowId
{
    //Return value
    float _speed = 0.0f;
    
    //Query
    NSString *query = [NSString stringWithFormat:@"SELECT radius FROM Enemy WHERE rowId = %d", rowId];
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

- (float)radiusFromUid:(unsigned long long)uid
{
    //Return value
    float _radius = 0.0f;
    
    //Query
    NSString *query = [NSString stringWithFormat:@"SELECT radius FROM Enemy WHERE uid = %lld", uid];
    sqlite3_stmt *statement;
    sqlite3 *database;
    
    if(sqlite3_open([self.path UTF8String], &database) == SQLITE_OK)
    {
        if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if(sqlite3_step(statement) == SQLITE_ROW)
            {
                _radius = (float)sqlite3_column_double(statement, 0);
            }
            sqlite3_finalize(statement);
        } else {
            [DatabaseBase failedToRunQuery:[query UTF8String]];
        }
        sqlite3_close(database);
    } else {
        [DatabaseBase failedToOpen];
    }
    return _radius;
}

/*
 * Active Skills
 */
- (NSArray *)activeSkillsByRowId:(int)rowId
{
    //Return value
    NSArray *_activeSkills;
    NSString *stringToSeperate = nil;
    
    //Query
    NSString *query = [NSString stringWithFormat:@"SELECT activeSkills FROM Enemy WHERE rowId = %d", rowId];
    sqlite3_stmt *statement;
    sqlite3 *database;
    
    if(sqlite3_open([self.path UTF8String], &database) == SQLITE_OK)
    {
        if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if(sqlite3_step(statement) == SQLITE_ROW)
            {
                stringToSeperate = ((const char *)sqlite3_column_text(statement, 0)) ? [NSString stringWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] : nil;
            }
            sqlite3_finalize(statement);
        } else {
            [DatabaseBase failedToRunQuery:[query UTF8String]];
        }
        sqlite3_close(database);
    } else {
        [DatabaseBase failedToOpen];
    }
    
    if(!stringToSeperate)
        _activeSkills = nil;
    else
        _activeSkills = [[NSArray alloc] initWithArray:[stringToSeperate componentsSeparatedByString:@","]];
    
    return [_activeSkills autorelease];
}

- (NSArray *)activeSkillsFromUid:(unsigned long long)uid
{
    //Return value
    NSArray *_activeSkills;
    NSString *stringToSeperate = nil;
    
    //Query
    NSString *query = [NSString stringWithFormat:@"SELECT activeSkills FROM Enemy WHERE uid = %lld", uid];
    sqlite3_stmt *statement;
    sqlite3 *database;
    
    if(sqlite3_open([self.path UTF8String], &database) == SQLITE_OK)
    {
        if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if(sqlite3_step(statement) == SQLITE_ROW)
            {
                stringToSeperate = ((const char *)sqlite3_column_text(statement, 0)) ? [NSString stringWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] : nil;
            }
            sqlite3_finalize(statement);
        } else {
            [DatabaseBase failedToRunQuery:[query UTF8String]];
        }
        sqlite3_close(database);
    } else {
        [DatabaseBase failedToOpen];
    }
    
    if(!stringToSeperate)
        _activeSkills = nil;
    else
        _activeSkills = [[NSArray alloc] initWithArray:[stringToSeperate componentsSeparatedByString:@","]];
    
    return [_activeSkills autorelease];
}

/*
 * Zone
 */
- (NSString *)zoneFromRowId:(int)rowId
{
    //Return value
    NSString *_zone = nil;
    
    //Query
    NSString *query = [NSString stringWithFormat:@"SELECT zone FROM Enemy WHERE rowId = %d", rowId];
    sqlite3_stmt *statement;
    sqlite3 *database;
    
    if(sqlite3_open([self.path UTF8String], &database) == SQLITE_OK)
    {
        if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if(sqlite3_step(statement) == SQLITE_ROW)
            {
                _zone = ((const char *)sqlite3_column_text(statement, 0)) ? [NSString stringWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] : nil;
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

- (NSString *)zoneFromUid:(unsigned long long)uid
{
    //Return value
    NSString *_zone = nil;
    
    //Query
    NSString *query = [NSString stringWithFormat:@"SELECT zone FROM Enemy WHERE uid = %lld", uid];
    sqlite3_stmt *statement;
    sqlite3 *database;
    
    if(sqlite3_open([self.path UTF8String], &database) == SQLITE_OK)
    {
        if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if(sqlite3_step(statement) == SQLITE_ROW)
            {
                _zone = ((const char *)sqlite3_column_text(statement, 0)) ? [NSString stringWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] : nil;
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
 * Min Weapon Damage
 */
- (float)minWeaponDamageByRowId:(int)rowId
{
    //Return value
    float _damage = 0.0f;
    
    //Query
    NSString *query = [NSString stringWithFormat:@"SELECT minWeaponDamage FROM Enemy WHERE rowId = %d", rowId];
    sqlite3_stmt *statement;
    sqlite3 *database;
    
    if(sqlite3_open([self.path UTF8String], &database) == SQLITE_OK)
    {
        if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if(sqlite3_step(statement) == SQLITE_ROW)
            {
                _damage = (float)sqlite3_column_double(statement, 0);
            }
            sqlite3_finalize(statement);
        } else {
            [DatabaseBase failedToRunQuery:[query UTF8String]];
        }
        sqlite3_close(database);
    } else {
        [DatabaseBase failedToOpen];
    }
    return _damage;
}

- (float)minWeaponDamageFromUid:(unsigned long long)uid
{
    //Return value
    float _damage = 0.0f;
    
    //Query
    NSString *query = [NSString stringWithFormat:@"SELECT minWeaponDamage FROM Enemy WHERE uid = %lld", uid];
    sqlite3_stmt *statement;
    sqlite3 *database;
    
    if(sqlite3_open([self.path UTF8String], &database) == SQLITE_OK)
    {
        if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if(sqlite3_step(statement) == SQLITE_ROW)
            {
                _damage = (float)sqlite3_column_double(statement, 0);
            }
            sqlite3_finalize(statement);
        } else {
            [DatabaseBase failedToRunQuery:[query UTF8String]];
        }
        sqlite3_close(database);
    } else {
        [DatabaseBase failedToOpen];
    }
    return _damage;
}

/*
 * Max Weapon Damage
 */
- (float)maxWeaponDamageByRowId:(int)rowId
{
    //Return value
    float _damage = 0.0f;
    
    //Query
    NSString *query = [NSString stringWithFormat:@"SELECT maxWeaponDamage FROM Enemy WHERE rowId = %d", rowId];
    sqlite3_stmt *statement;
    sqlite3 *database;
    
    if(sqlite3_open([self.path UTF8String], &database) == SQLITE_OK)
    {
        if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if(sqlite3_step(statement) == SQLITE_ROW)
            {
                _damage = (float)sqlite3_column_double(statement, 0);
            }
            sqlite3_finalize(statement);
        } else {
            [DatabaseBase failedToRunQuery:[query UTF8String]];
        }
        sqlite3_close(database);
    } else {
        [DatabaseBase failedToOpen];
    }
    return _damage;
}

- (float)maxWeaponDamageFromUid:(unsigned long long)uid
{
    //Return value
    float _damage = 0.0f;
    
    //Query
    NSString *query = [NSString stringWithFormat:@"SELECT maxWeaponDamage FROM Enemy WHERE uid = %lld", uid];
    sqlite3_stmt *statement;
    sqlite3 *database;
    
    if(sqlite3_open([self.path UTF8String], &database) == SQLITE_OK)
    {
        if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if(sqlite3_step(statement) == SQLITE_ROW)
            {
                _damage = (float)sqlite3_column_double(statement, 0);
            }
            sqlite3_finalize(statement);
        } else {
            [DatabaseBase failedToRunQuery:[query UTF8String]];
        }
        sqlite3_close(database);
    } else {
        [DatabaseBase failedToOpen];
    }
    return _damage;
}

/*
 * Weapon Strength
 */
- (float)weaponStrengthByRowId:(int)rowId
{
    //Return value
    float _weaponStrength = 0.0f;
    
    //Query
    NSString *query = [NSString stringWithFormat:@"SELECT weaponStrength FROM Enemy WHERE rowId = %d", rowId];
    sqlite3_stmt *statement;
    sqlite3 *database;
    
    if(sqlite3_open([self.path UTF8String], &database) == SQLITE_OK)
    {
        if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if(sqlite3_step(statement) == SQLITE_ROW)
            {
                _weaponStrength = (float)sqlite3_column_double(statement, 0);
            }
            sqlite3_finalize(statement);
        } else {
            [DatabaseBase failedToRunQuery:[query UTF8String]];
        }
        sqlite3_close(database);
    } else {
        [DatabaseBase failedToOpen];
    }
    return _weaponStrength;
}

- (float)weaponStrengthFromUid:(unsigned long long)uid
{
    //Return value
    float _weaponStrength = 0.0f;
    
    //Query
    NSString *query = [NSString stringWithFormat:@"SELECT weaponStrength FROM Enemy WHERE uid = %lld", uid];
    sqlite3_stmt *statement;
    sqlite3 *database;
    
    if(sqlite3_open([self.path UTF8String], &database) == SQLITE_OK)
    {
        if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if(sqlite3_step(statement) == SQLITE_ROW)
            {
                _weaponStrength = (float)sqlite3_column_double(statement, 0);
            }
            sqlite3_finalize(statement);
        } else {
            [DatabaseBase failedToRunQuery:[query UTF8String]];
        }
        sqlite3_close(database);
    } else {
        [DatabaseBase failedToOpen];
    }
    return _weaponStrength;
}

@end
