//
//  NPCDatabase.m
//  LegendOfTheShadowRealm
//
//  Created by Jeremy Fuellert on 2012-11-24.
//
//

#import "NPCDatabase.h"

@implementation NPCDatabase

- (id)init
{
    return [self initWithDatabase:DATABASE_NPC_DATABASE];
}

/*
 * NPC Retrieval Methods
 *
 * These methods are used to retrieve an NSDictionary object(s) with object and key combinations. 
 * These call returns will go into BaseNPC class to be added as properties to that NPC object.
 */

- (NSDictionary *)npcFromRow:(int)rowId
{
    NSMutableDictionary *dictionary = [NSMutableDictionary new];

    NSNumber *uid = [NSNumber numberWithUnsignedLongLong:[self uidFromRowId:rowId]];
    NSNumber *positionX = [NSNumber numberWithInt:[self positionXFromRowId:rowId]];
    NSNumber *positionY = [NSNumber numberWithInt:[self positionYFromRowId:rowId]];
    NSNumber *boundsX = [NSNumber numberWithInt:[self boundsXFromRowId:rowId]];
    NSNumber *boundsY = [NSNumber numberWithInt:[self boundsYFromRowId:rowId]];
    NSNumber *speed = [NSNumber numberWithFloat:[self speedByRowId:rowId]];
    NSNumber *radius = [NSNumber numberWithFloat:[self radiusByRowId:rowId]];
    NSNumber *directionChangeTime = [NSNumber numberWithFloat:[self directionChangeTimeByRowId:rowId]];
    NSArray *quests = [self questsFromRowId:rowId];
    NSString *name = [self nameFromRowId:rowId];
    NSString *map = [self mapFromRowId:rowId];
    NSString *zone = [self zoneFromRowId:rowId];
    
    [dictionary setObject:uid forKey:@"uid"];
    [dictionary setObject:positionX forKey:@"positionX"];
    [dictionary setObject:positionY forKey:@"positionY"];
    [dictionary setObject:boundsX forKey:@"boundsX"];
    [dictionary setObject:boundsY forKey:@"boundsY"];
    [dictionary setObject:speed forKey:@"speed"];
    [dictionary setObject:radius forKey:@"radius"];
    [dictionary setObject:directionChangeTime forKey:@"directionChangeTime"];
    if(quests && quests.count > 0)[dictionary setObject:quests forKey:@"quests"];
    if(name && name.length > 0)[dictionary setObject:name forKey:@"name"];
    [dictionary setObject:map forKey:@"map"];
    [dictionary setObject:zone forKey:@"zone"];
    
    NSDictionary *npcObject = [[NSDictionary alloc] initWithDictionary:dictionary];
    
    [self destroy:dictionary];
    
    return [npcObject autorelease];
}

- (NSDictionary *)npcFromUid:(unsigned long long)luid
{
    NSMutableDictionary *dictionary = [NSMutableDictionary new];
    
    NSNumber *uid = [NSNumber numberWithUnsignedLongLong:luid];
    NSNumber *positionX = [NSNumber numberWithInt:[self positionXFromUid:luid]];
    NSNumber *positionY = [NSNumber numberWithInt:[self positionYFromUid:luid]];
    NSNumber *boundsX = [NSNumber numberWithInt:[self boundsXFromUid:luid]];
    NSNumber *boundsY = [NSNumber numberWithInt:[self boundsYFromUid:luid]];
    NSNumber *speed = [NSNumber numberWithFloat:[self speedFromUid:luid]];
    NSNumber *radius = [NSNumber numberWithFloat:[self speedFromUid:luid]];
    NSNumber *directionChangeTime = [NSNumber numberWithFloat:[self directionChangeTimeByUid:luid]];
    NSArray *quests = [self questsFromUid:luid];
    NSString *name = [self nameFromUid:luid];
    NSString *map = [self mapFromUid:luid];
    NSString *zone = [self zoneFromUid:luid];
    
    [dictionary setObject:uid forKey:@"uid"];
    [dictionary setObject:positionX forKey:@"positionX"];
    [dictionary setObject:positionY forKey:@"positionY"];
    [dictionary setObject:boundsX forKey:@"boundsX"];
    [dictionary setObject:boundsY forKey:@"boundsY"];
    [dictionary setObject:speed forKey:@"speed"];
    [dictionary setObject:radius forKey:@"radius"];
    [dictionary setObject:directionChangeTime forKey:@"directionChangeTime"];
    [dictionary setObject:quests forKey:@"quests"];
    [dictionary setObject:name forKey:@"name"];
    [dictionary setObject:map forKey:@"map"];
    [dictionary setObject:zone forKey:@"zone"];
    
    NSDictionary *npcObject = [[NSDictionary alloc] initWithDictionary:dictionary];
    
    [self destroy:dictionary];
    
    return [npcObject autorelease];
}

- (NSArray *)npcsFromZone:(NSString *)zone
{
    NSMutableArray *npcList = [NSMutableArray new];
    NSArray *npcUidList = [[self uidsFromZone:zone] retain];
    
    for(int i = 0; i < npcUidList.count; i++)
    {
        unsigned long long uid = (unsigned long long)[(NSNumber *)[npcUidList objectAtIndex:i] unsignedLongLongValue];
        
        NSDictionary *npcObject = [self npcFromUid:uid];
        [npcList addObject:npcObject];
    }
    
    NSArray *returnList = [[NSArray alloc] initWithArray:npcList];
    
    [self destroy:npcList];
    [self destroy:npcUidList];
    
    return [returnList autorelease];
}

/*
 * Uid
 */
- (unsigned long long)uidFromRowId:(int)rowId
{
    //Return value
    unsigned long long _uid = 0;
    
    //Query
    NSString *query = [NSString stringWithFormat:@"SELECT uid FROM NPC WHERE rowId = %d", rowId];
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
    NSString *query = [NSString stringWithFormat:@"SELECT uid FROM NPC WHERE zone = \'%@\'", zone];
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
 * Position X
 */
- (void)setPositionX:(int)positionX atUid:(unsigned long long)uid
{
    //Query
    NSString *query = [NSString stringWithFormat:@"UPDATE NPC SET positionX = ? WHERE uid = %lld", uid];
    sqlite3_stmt *statement;
    sqlite3 *database;
    
    if(sqlite3_open([self.path UTF8String], &database) == SQLITE_OK)
    {
        if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, nil) == SQLITE_OK)
        {
            sqlite3_bind_int(statement, 1, positionX);
            if(sqlite3_step(statement) != SQLITE_DONE)
            {
                [DatabaseBase failedToRunQuery:[query  UTF8String]];
            }
            sqlite3_finalize(statement);
        } else {
            [DatabaseBase failedToRunQuery:[query UTF8String]];
        }
        sqlite3_close(database);
    } else {
        [DatabaseBase failedToOpen];
    }
}

- (int)positionXFromRowId:(int)rowId
{
    //Return value
    int _positionX = 0;
    
    //Query
    NSString *query = [NSString stringWithFormat:@"SELECT positionX FROM NPC WHERE rowId = %d", rowId];
    sqlite3_stmt *statement;
    sqlite3 *database;
    
    if(sqlite3_open([self.path UTF8String], &database) == SQLITE_OK)
    {
        if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if(sqlite3_step(statement) == SQLITE_ROW)
            {
                _positionX = (int)sqlite3_column_int(statement, 0);
            }
            sqlite3_finalize(statement);
        } else {
            [DatabaseBase failedToRunQuery:[query UTF8String]];
        }
        sqlite3_close(database);
    } else {
        [DatabaseBase failedToOpen];
    }
    return _positionX;
}

- (int)positionXFromUid:(unsigned long long)uid
{
    //Return value
    int _positionX = 0;
    
    //Query
    NSString *query = [NSString stringWithFormat:@"SELECT positionX FROM NPC WHERE uid = %lld", uid];
    sqlite3_stmt *statement;
    sqlite3 *database;
    
    if(sqlite3_open([self.path UTF8String], &database) == SQLITE_OK)
    {
        if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if(sqlite3_step(statement) == SQLITE_ROW)
            {
                _positionX = (int)sqlite3_column_int(statement, 0);
            }
            sqlite3_finalize(statement);
        } else {
            [DatabaseBase failedToRunQuery:[query UTF8String]];
        }
        sqlite3_close(database);
    } else {
        [DatabaseBase failedToOpen];
    }
    return _positionX;
}

/*
 * Position Y
 */
- (void)setPositionY:(int)positionY atUid:(unsigned long long)uid
{
    //Query
    NSString *query = [NSString stringWithFormat:@"UPDATE NPC SET positionY = ? WHERE uid = %lld", uid];
    sqlite3_stmt *statement;
    sqlite3 *database;
    
    if(sqlite3_open([self.path UTF8String], &database) == SQLITE_OK)
    {
        if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, nil) == SQLITE_OK)
        {
            sqlite3_bind_int(statement, 1, positionY);
            if(sqlite3_step(statement) != SQLITE_DONE)
            {
                [DatabaseBase failedToRunQuery:[query  UTF8String]];
            }
            sqlite3_finalize(statement);
        } else {
            [DatabaseBase failedToRunQuery:[query UTF8String]];
        }
        sqlite3_close(database);
    } else {
        [DatabaseBase failedToOpen];
    }
}

- (int)positionYFromRowId:(int)rowId
{
    //Return value
    int _positionY = 0;
    
    //Query
    NSString *query = [NSString stringWithFormat:@"SELECT positionY FROM NPC WHERE rowId = %d", rowId];
    sqlite3_stmt *statement;
    sqlite3 *database;
    
    if(sqlite3_open([self.path UTF8String], &database) == SQLITE_OK)
    {
        if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if(sqlite3_step(statement) == SQLITE_ROW)
            {
                _positionY = (int)sqlite3_column_int(statement, 0);
            }
            sqlite3_finalize(statement);
        } else {
            [DatabaseBase failedToRunQuery:[query UTF8String]];
        }
        sqlite3_close(database);
    } else {
        [DatabaseBase failedToOpen];
    }
    return _positionY;
}

- (int)positionYFromUid:(unsigned long long)uid
{
    //Return value
    int _positionY = 0;
    
    //Query
    NSString *query = [NSString stringWithFormat:@"SELECT positionY FROM NPC WHERE uid = %lld", uid];
    sqlite3_stmt *statement;
    sqlite3 *database;
    
    if(sqlite3_open([self.path UTF8String], &database) == SQLITE_OK)
    {
        if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if(sqlite3_step(statement) == SQLITE_ROW)
            {
                _positionY = (int)sqlite3_column_int(statement, 0);
            }
            sqlite3_finalize(statement);
        } else {
            [DatabaseBase failedToRunQuery:[query UTF8String]];
        }
        sqlite3_close(database);
    } else {
        [DatabaseBase failedToOpen];
    }
    return _positionY;
}

/*
 * Bounds X
 */
- (void)setBoundsX:(int)boundsX atUid:(unsigned long long)uid
{
    //Query
    NSString *query = [NSString stringWithFormat:@"UPDATE NPC SET boundsX = ? WHERE uid = %lld", uid];
    sqlite3_stmt *statement;
    sqlite3 *database;
    
    if(sqlite3_open([self.path UTF8String], &database) == SQLITE_OK)
    {
        if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, nil) == SQLITE_OK)
        {
            sqlite3_bind_int(statement, 1, boundsX);
            if(sqlite3_step(statement) != SQLITE_DONE)
            {
                [DatabaseBase failedToRunQuery:[query  UTF8String]];
            }
            sqlite3_finalize(statement);
        } else {
            [DatabaseBase failedToRunQuery:[query UTF8String]];
        }
        sqlite3_close(database);
    } else {
        [DatabaseBase failedToOpen];
    }
}

- (int)boundsXFromRowId:(int)rowId
{
    //Return value
    int _boundsX = 0;
    
    //Query
    NSString *query = [NSString stringWithFormat:@"SELECT boundsX FROM NPC WHERE rowId = %d", rowId];
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
    NSString *query = [NSString stringWithFormat:@"SELECT boundsX FROM NPC WHERE uid = %lld", uid];
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
- (void)setBoundsY:(int)boundsY atUid:(unsigned long long)uid
{
    //Query
    NSString *query = [NSString stringWithFormat:@"UPDATE NPC SET boundsY = ? WHERE uid = %lld", uid];
    sqlite3_stmt *statement;
    sqlite3 *database;
    
    if(sqlite3_open([self.path UTF8String], &database) == SQLITE_OK)
    {
        if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, nil) == SQLITE_OK)
        {
            sqlite3_bind_int(statement, 1, boundsY);
            if(sqlite3_step(statement) != SQLITE_DONE)
            {
                [DatabaseBase failedToRunQuery:[query  UTF8String]];
            }
            sqlite3_finalize(statement);
        } else {
            [DatabaseBase failedToRunQuery:[query UTF8String]];
        }
        sqlite3_close(database);
    } else {
        [DatabaseBase failedToOpen];
    }
}

- (int)boundsYFromRowId:(int)rowId
{
    //Return value
    int _boundsY = 0;
    
    //Query
    NSString *query = [NSString stringWithFormat:@"SELECT boundsY FROM NPC WHERE rowId = %d", rowId];
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
    NSString *query = [NSString stringWithFormat:@"SELECT boundsY FROM NPC WHERE uid = %lld", uid];
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
 * Speed
 */
- (void)setSpeed:(float)speed atUid:(unsigned long long)uid
{
    //Query
    NSString *query = [NSString stringWithFormat:@"UPDATE NPC SET speed = ? WHERE uid = %lld", uid];
    sqlite3_stmt *statement;
    sqlite3 *database;
    
    if(sqlite3_open([self.path UTF8String], &database) == SQLITE_OK)
    {
        if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, nil) == SQLITE_OK)
        {
            sqlite3_bind_double(statement, 1, speed);
            if(sqlite3_step(statement) != SQLITE_DONE)
            {
                [DatabaseBase failedToRunQuery:[query  UTF8String]];
            }
            sqlite3_finalize(statement);
        } else {
            [DatabaseBase failedToRunQuery:[query UTF8String]];
        }
        sqlite3_close(database);
    } else {
        [DatabaseBase failedToOpen];
    }
}

- (float)speedByRowId:(int)rowId
{
    //Return value
    float _speed = 0.0f;
    
    //Query
    NSString *query = [NSString stringWithFormat:@"SELECT speed FROM NPC WHERE rowId = %d", rowId];
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
    NSString *query = [NSString stringWithFormat:@"SELECT speed FROM NPC WHERE uid = %lld", uid];
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
 * Radius
 */
- (void)setRadius:(float)radius atUid:(unsigned long long)uid
{
    //Query
    NSString *query = [NSString stringWithFormat:@"UPDATE NPC SET radius = ? WHERE uid = %lld", uid];
    sqlite3_stmt *statement;
    sqlite3 *database;
    
    if(sqlite3_open([self.path UTF8String], &database) == SQLITE_OK)
    {
        if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, nil) == SQLITE_OK)
        {
            sqlite3_bind_double(statement, 1, radius);
            if(sqlite3_step(statement) != SQLITE_DONE)
            {
                [DatabaseBase failedToRunQuery:[query  UTF8String]];
            }
            sqlite3_finalize(statement);
        } else {
            [DatabaseBase failedToRunQuery:[query UTF8String]];
        }
        sqlite3_close(database);
    } else {
        [DatabaseBase failedToOpen];
    }
}

- (float)radiusByRowId:(int)rowId
{
    //Return value
    float _speed = 0.0f;
    
    //Query
    NSString *query = [NSString stringWithFormat:@"SELECT radius FROM NPC WHERE rowId = %d", rowId];
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
    NSString *query = [NSString stringWithFormat:@"SELECT radius FROM NPC WHERE uid = %lld", uid];
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
 * Directional Change Time
 */
- (void)setDirectionChangeTime:(float)time atUid:(unsigned long long)uid
{
    //Query
    NSString *query = [NSString stringWithFormat:@"UPDATE NPC SET directionChangeTime = ? WHERE uid = %lld", uid];
    sqlite3_stmt *statement;
    sqlite3 *database;
    
    if(sqlite3_open([self.path UTF8String], &database) == SQLITE_OK)
    {
        if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, nil) == SQLITE_OK)
        {
            sqlite3_bind_double(statement, 1, time);
            if(sqlite3_step(statement) != SQLITE_DONE)
            {
                [DatabaseBase failedToRunQuery:[query  UTF8String]];
            }
            sqlite3_finalize(statement);
        } else {
            [DatabaseBase failedToRunQuery:[query UTF8String]];
        }
        sqlite3_close(database);
    } else {
        [DatabaseBase failedToOpen];
    }
}

- (float)directionChangeTimeByRowId:(int)rowId
{
    //Return value
    float _changeTime = 0.0f;
    
    //Query
    NSString *query = [NSString stringWithFormat:@"SELECT directionChangeTime FROM NPC WHERE rowId = %d", rowId];
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
    NSString *query = [NSString stringWithFormat:@"SELECT directionChangeTime FROM NPC WHERE uid = %lld", uid];
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
 * Quests
 */
- (void)setQuests:(NSArray *)quests atUid:(unsigned long long)uid
{
    NSString *questsString = [[quests valueForKey:@"description"] componentsJoinedByString:@","];
    
    //Query
    NSString *query = [NSString stringWithFormat:@"UPDATE NPC SET quests = ? WHERE uid = %lld", uid];
    sqlite3_stmt *statement;
    sqlite3 *database;
    
    if(sqlite3_open([self.path UTF8String], &database) == SQLITE_OK)
    {
        if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, nil) == SQLITE_OK)
        {
            sqlite3_bind_text(statement, 1, [questsString UTF8String], -1, SQLITE_TRANSIENT);
            if(sqlite3_step(statement) != SQLITE_DONE)
            {
                [DatabaseBase failedToRunQuery:[query UTF8String]];
            }
            sqlite3_finalize(statement);
        } else {
            [DatabaseBase failedToRunQuery:[query UTF8String]];
        }
        sqlite3_close(database);
    } else {
        [DatabaseBase failedToOpen];
    }
}

- (NSArray *)questsFromRowId:(int)rowId
{
    //Return value
    NSArray *quests;
    NSString *stringToSeperate = nil;
    
    //Query
    NSString *query = [NSString stringWithFormat:@"SELECT quests FROM NPC WHERE rowId = %d", rowId];
    sqlite3_stmt *statement;
    sqlite3 *database;
    
    if(sqlite3_open([self.path UTF8String], &database) == SQLITE_OK)
    {
        if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            while(sqlite3_step(statement) == SQLITE_ROW)
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
        quests = nil;
    else
        quests = [[[NSArray alloc] initWithArray:[stringToSeperate componentsSeparatedByString:@","]] autorelease];
    
    return quests;
}

- (NSArray *)questsFromUid:(unsigned long long)uid
{
    //Return value
    NSArray *quests;
    NSString *stringToSeperate = nil;
    
    //Query
    NSString *query = [NSString stringWithFormat:@"SELECT quests FROM NPC WHERE uid = %lld", uid];
    sqlite3_stmt *statement;
    sqlite3 *database;
    
    if(sqlite3_open([self.path UTF8String], &database) == SQLITE_OK)
    {
        if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            while(sqlite3_step(statement) == SQLITE_ROW)
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
        quests = nil;
    else
        quests = [[[NSArray alloc] initWithArray:[stringToSeperate componentsSeparatedByString:@","]] autorelease];
    
    return quests;
}


/*
 * Name
 */
- (NSString *)nameFromRowId:(int)rowId
{
    //Return value
    NSString *_name = nil;
    
    //Query
    NSString *query = [NSString stringWithFormat:@"SELECT name FROM NPC WHERE rowId = %d", rowId];
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

- (NSString *)nameFromUid:(unsigned long long)uid
{
    //Return value
    NSString *_name = nil;
    
    //Query
    NSString *query = [NSString stringWithFormat:@"SELECT name FROM NPC WHERE uid = %lld", uid];
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
 * Map
 */
- (void)setMap:(NSString *)map atUid:(unsigned long long)uid
{
    //Query
    NSString *query = [NSString stringWithFormat:@"UPDATE NPC SET currentMap = ? WHERE uid = %lld", uid];
    sqlite3_stmt *statement;
    sqlite3 *database;
    
    if(sqlite3_open([self.path UTF8String], &database) == SQLITE_OK)
    {
        if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, nil) == SQLITE_OK)
        {
            sqlite3_bind_text(statement, 1, [map UTF8String], -1, SQLITE_TRANSIENT);
            if(sqlite3_step(statement) != SQLITE_DONE)
            {
                [DatabaseBase failedToRunQuery:[query UTF8String]];
            }
            sqlite3_finalize(statement);
        } else {
            [DatabaseBase failedToRunQuery:[query UTF8String]];
        }
        sqlite3_close(database);
    } else {
        [DatabaseBase failedToOpen];
    }
}

- (NSString *)mapFromRowId:(int)rowId
{
    //Return value
    NSString *_map = nil;
    
    //Query
    NSString *query = [NSString stringWithFormat:@"SELECT currentMap FROM NPC WHERE rowId = %d", rowId];
    sqlite3_stmt *statement;
    sqlite3 *database;
    
    if(sqlite3_open([self.path UTF8String], &database) == SQLITE_OK)
    {
        if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if(sqlite3_step(statement) == SQLITE_ROW)
            {
                _map = ((const char *)sqlite3_column_text(statement, 0)) ? [NSString stringWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] : nil;
            }
            sqlite3_finalize(statement);
        } else {
            [DatabaseBase failedToRunQuery:[query UTF8String]];
        }
        sqlite3_close(database);
    } else {
        [DatabaseBase failedToOpen];
    }
    return _map;
}

- (NSString *)mapFromUid:(unsigned long long)uid
{
    //Return value
    NSString *_map = nil;
    
    //Query
    NSString *query = [NSString stringWithFormat:@"SELECT currentMap FROM NPC WHERE uid = %lld", uid];
    sqlite3_stmt *statement;
    sqlite3 *database;
    
    if(sqlite3_open([self.path UTF8String], &database) == SQLITE_OK)
    {
        if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if(sqlite3_step(statement) == SQLITE_ROW)
            {
                _map = ((const char *)sqlite3_column_text(statement, 0)) ? [NSString stringWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] : nil;
            }
            sqlite3_finalize(statement);
        } else {
            [DatabaseBase failedToRunQuery:[query UTF8String]];
        }
        sqlite3_close(database);
    } else {
        [DatabaseBase failedToOpen];
    }
    return _map;
}

/*
 * Zone
 */
- (void)setZone:(NSString *)zone atUid:(unsigned long long)uid
{
    //Query
    NSString *query = [NSString stringWithFormat:@"UPDATE NPC SET zone = ? WHERE uid = %lld", uid];
    sqlite3_stmt *statement;
    sqlite3 *database;
    
    if(sqlite3_open([self.path UTF8String], &database) == SQLITE_OK)
    {
        if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, nil) == SQLITE_OK)
        {
            sqlite3_bind_text(statement, 1, [zone UTF8String], -1, SQLITE_TRANSIENT);
            if(sqlite3_step(statement) != SQLITE_DONE)
            {
                [DatabaseBase failedToRunQuery:[query UTF8String]];
            }
            sqlite3_finalize(statement);
        } else {
            [DatabaseBase failedToRunQuery:[query UTF8String]];
        }
        sqlite3_close(database);
    } else {
        [DatabaseBase failedToOpen];
    }
}

- (NSString *)zoneFromRowId:(int)rowId
{
    //Return value
    NSString *_zone = nil;
    
    //Query
    NSString *query = [NSString stringWithFormat:@"SELECT zone FROM NPC WHERE rowId = %d", rowId];
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
    NSString *query = [NSString stringWithFormat:@"SELECT zone FROM NPC WHERE uid = %lld", uid];
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


@end
