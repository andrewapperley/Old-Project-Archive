//
//  MapDatabase.m
//  LegendOfTheShadowRealm
//
//  Created by Jeremy Fuellert on 2012-11-24.
//
//

#import "MapDatabase.h"

@implementation MapDatabase

- (id)init
{
    return [self initWithDatabase:DATABASE_MAP_DATABASE];
}

/*
 * Zone
 */
- (NSString *)zoneFromRowId:(int)rowId
{
    //Return value
    NSString *_zone = nil;
    
    //Query
    NSString *query = [NSString stringWithFormat:@"SELECT zone FROM Map WHERE rowId = %d", rowId];
    sqlite3_stmt *statement;
    sqlite3 *database;
    
    if(sqlite3_open([self.path UTF8String], &database) == SQLITE_OK)
    {
        if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if(sqlite3_step(statement))
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

- (NSString *)zoneFromMap:(NSString *)map
{
    //Return value
    NSString *_zone = [NSString new];
    
    //Query
    NSString *query = [NSString stringWithFormat:@"SELECT zone FROM Map WHERE map = \'%@\'", map];
    sqlite3_stmt *statement;
    sqlite3 *database;
    
    if(sqlite3_open([self.path UTF8String], &database) == SQLITE_OK)
    {
        if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if(sqlite3_step(statement))
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
    return [_zone autorelease];
}

/*
 * Map
 */
- (NSString *)mapFromRowId:(int)rowId
{
    //Return value
    NSString *_map = nil;
    
    //Query
    NSString *query = [NSString stringWithFormat:@"SELECT map FROM Map WHERE rowId = %d", rowId];
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

- (NSString *)mapFromZone:(NSString *)zone
{
    //Return value
    NSString *_map = nil;
    
    //Query
    NSString *query = [NSString stringWithFormat:@"SELECT map FROM Map WHERE zone = \'%@\'", zone];
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
 * Enemy to Player Level Difference
 */
- (float)levelDifferenceFromRowId:(int)rowId
{
    //Return value
    float _levelDiff = 0.0f;
    
    //Query
    NSString *query = [NSString stringWithFormat:@"SELECT levelDiff FROM Map WHERE rowId = %d", rowId];
    sqlite3_stmt *statement;
    sqlite3 *database;
    
    if(sqlite3_open([self.path UTF8String], &database) == SQLITE_OK)
    {
        if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if(sqlite3_step(statement) == SQLITE_ROW)
            {
                _levelDiff = (float)sqlite3_column_double(statement, 0);
            }
            sqlite3_finalize(statement);
        } else {
            [DatabaseBase failedToRunQuery:[query UTF8String]];
        }
        sqlite3_close(database);
    } else {
        [DatabaseBase failedToOpen];
    }
    return _levelDiff;
}

- (float)levelDifferenceFromZone:(NSString *)zone
{
    //Return value
    float _levelDiff = 0.0f;
    
    //Query
    NSString *query = [NSString stringWithFormat:@"SELECT levelDiff FROM Map WHERE zone = \'%@\'", zone];
    sqlite3_stmt *statement;
    sqlite3 *database;
    
    if(sqlite3_open([self.path UTF8String], &database) == SQLITE_OK)
    {
        if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if(sqlite3_step(statement) == SQLITE_ROW)
            {
                _levelDiff = (float)sqlite3_column_double(statement, 0);
            }
            sqlite3_finalize(statement);
        } else {
            [DatabaseBase failedToRunQuery:[query UTF8String]];
        }
        sqlite3_close(database);
    } else {
        [DatabaseBase failedToOpen];
    }
    return _levelDiff;
}

/*
 * Enemies Allowed Per Screen
 */
- (int)enemiesAllowedPerScreenFromRowId:(int)rowId
{
    //Return value
    int _enemies = 0;
    
    //Query
    NSString *query = [NSString stringWithFormat:@"SELECT enemiesPerScreen FROM Map WHERE rowId = %d", rowId];
    sqlite3_stmt *statement;
    sqlite3 *database;
    
    if(sqlite3_open([self.path UTF8String], &database) == SQLITE_OK)
    {
        if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if(sqlite3_step(statement) == SQLITE_ROW)
            {
                _enemies = (int)sqlite3_column_int(statement, 0);
            }
            sqlite3_finalize(statement);
        } else {
            [DatabaseBase failedToRunQuery:[query UTF8String]];
        }
        sqlite3_close(database);
    } else {
        [DatabaseBase failedToOpen];
    }
    return _enemies;
}

- (int)enemiesAllowedPerScreenFromZone:(NSString *)zone
{
    //Return value
    int _enemies = 0;
    
    //Query
    NSString *query = [NSString stringWithFormat:@"SELECT enemiesPerScreen FROM Map WHERE zone = \'%@\'", zone];
    sqlite3_stmt *statement;
    sqlite3 *database;
    
    if(sqlite3_open([self.path UTF8String], &database) == SQLITE_OK)
    {
        if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if(sqlite3_step(statement) == SQLITE_ROW)
            {
                _enemies = (int)sqlite3_column_int(statement, 0);
            }
            sqlite3_finalize(statement);
        } else {
            [DatabaseBase failedToRunQuery:[query UTF8String]];
        }
        sqlite3_close(database);
    } else {
        [DatabaseBase failedToOpen];
    }
    return _enemies;
}

/*
 * Required To Unlock
 */
- (void)setRequirementsToUnlock:(NSArray *)locks forZone:(NSString *)zone
{
    NSString *locksString = [[locks valueForKey:@"description"] componentsJoinedByString:@","];
    
    //Query
    NSString *query = [NSString stringWithFormat:@"UPDATE Map SET required = ? WHERE zone = \'%@\'", zone];
    sqlite3_stmt *statement;
    sqlite3 *database;
    
    if(sqlite3_open([self.path UTF8String], &database) == SQLITE_OK)
    {
        if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, nil) == SQLITE_OK)
        {
            sqlite3_bind_text(statement, 1, [locksString UTF8String], -1, SQLITE_TRANSIENT);
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

- (NSArray *)requiredToUnlockFromRowId:(int)rowId
{
    //Return value
    NSArray *_unlockRequirements;
    NSString *stringToSeperate = nil;
    
    //Query
    NSString *query = [NSString stringWithFormat:@"SELECT required FROM Map WHERE rowId = %d", rowId];
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
        _unlockRequirements = nil;
    else
        _unlockRequirements = [[NSArray alloc] initWithArray:[stringToSeperate componentsSeparatedByString:@","]];
    
    return [_unlockRequirements autorelease];
}

- (NSArray *)requiredToUnlockFromZone:(NSString *)zone
{
    //Return value
    NSArray *_unlockRequirements;
    NSString *stringToSeperate = nil;
    
    //Query
    NSString *query = [NSString stringWithFormat:@"SELECT required FROM Map WHERE zone = \'%@\'", zone];
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
        _unlockRequirements = nil;
    else
        _unlockRequirements = [[NSArray alloc] initWithArray:[stringToSeperate componentsSeparatedByString:@","]];
    
    return [_unlockRequirements autorelease];
}

//Playlist
- (NSArray *)playlistForMap:(NSString *)mapName
{
    //Return value
    NSArray *_playlist;
    NSString *stringToSeperate = nil;
    
    //Query
    NSString *query = [NSString stringWithFormat:@"SELECT playlist FROM Map WHERE map = \'%@\'", mapName];
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
        _playlist = nil;
    else
        _playlist = [[NSArray alloc] initWithArray:[stringToSeperate componentsSeparatedByString:@","]];
    
    return [_playlist autorelease];
}

@end
