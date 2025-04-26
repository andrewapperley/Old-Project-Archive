//
//  QuestDatabase.m
//  LegendOfTheShadowRealm
//
//  Created by Jeremy Fuellert on 2013-02-12.
//
//

#import "Constants.h"
#import "QuestDatabase.h"

@implementation QuestDatabase

- (id)init
{
    return [self initWithDatabase:DATABASE_QUEST_DATABASE];
}

/*
 * Quest Retrieval Methods
 *
 * These methods are used to retrieve an NSDictionary object(s) with object and key combinations.
 * These call returns will go into various classes to be added as properties to that object.
 */

- (NSDictionary *)questByUid:(unsigned long long)uid
{
    NSMutableDictionary *dictionary = [NSMutableDictionary new];
    
    NSString *name = [self nameByUid:uid];
    NSNumber *numItems = [NSNumber numberWithInt:[self numberOfItemsByUid:uid]];
    NSNumber *numItemsRequired = [NSNumber numberWithInt:[self numberOfItemsRequiredByUid:uid]];
    NSNumber *itemUid = [NSNumber numberWithUnsignedLongLong:[self itemRequiredUidByUid:uid]];
    NSNumber *_uid = [NSNumber numberWithUnsignedLongLong:uid];
    NSNumber *exp = [NSNumber numberWithInt:[self expGainedByUid:uid]];
    NSArray *rewards = [self rewardItemsByUid:uid];
    
    [dictionary setObject:numItems forKey:@"numItems"];
    [dictionary setObject:numItemsRequired forKey:@"numItemsRequired"];
    [dictionary setObject:itemUid forKey:@"itemUid"];
    [dictionary setObject:_uid forKey:@"uid"];
    [dictionary setObject:exp forKey:@"exp"];
    if(rewards && rewards.count > 0)[dictionary setObject:rewards forKey:@"rewards"];

    if(name && name.length > 0)[dictionary setObject:name forKey:@"name"];
    
    return [dictionary autorelease];
}

- (NSMutableArray *)questsByUidArray:(NSArray *)luidArray
{
    NSMutableArray *questObjectArray = [NSMutableArray array];
    NSArray *uidArray = [luidArray retain];
    
    for(int i = 0; i < uidArray.count; i++)
    {
        unsigned long long uid = [(NSString *)[uidArray objectAtIndex:i] longLongValue];
        NSDictionary *itemObject = [[self questByUid:uid] retain];
        [questObjectArray addObject:itemObject];
        [self destroy:itemObject];
    }
    
    [self destroy:uidArray];
    
    return questObjectArray;
}

/*
 * Name
 */
- (NSString *)nameByUid:(unsigned long long)uid
{
    //Return value
    NSString *_name = @"";
    
    //Query
    NSString *query = [NSString stringWithFormat:@"SELECT name FROM Quests WHERE uid = %lld", uid];
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
 * Number of Items
 */
- (void)setNumberOfItems:(int)_numberOfItems
{
    //Query
    const char *query = "UPDATE Quests SET numItems = ?";
    sqlite3_stmt *statement;
    sqlite3 *database;
    
    if(sqlite3_open([self.path UTF8String], &database) == SQLITE_OK)
    {
        if(sqlite3_prepare_v2(database, query, -1, &statement, nil) == SQLITE_OK)
        {
            sqlite3_bind_int(statement, 1, _numberOfItems);
            if(sqlite3_step(statement) != SQLITE_DONE)
            {
                [DatabaseBase failedToRunQuery:query];
            }
            sqlite3_finalize(statement);
        } else {
            [DatabaseBase failedToRunQuery:query];
        }
        sqlite3_close(database);
    } else {
        [DatabaseBase failedToOpen];
    }
}

- (int)numberOfItemsByUid:(unsigned long long)uid
{
    //Return value
    int _num = 0;
    
    //Query
    NSString *query = [NSString stringWithFormat:@"SELECT numItems FROM Quests WHERE uid = %lld", uid];
    sqlite3_stmt *statement;
    sqlite3 *database;
    
    if(sqlite3_open([self.path UTF8String], &database) == SQLITE_OK)
    {
        if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if(sqlite3_step(statement) == SQLITE_ROW)
            {
                _num = (int)sqlite3_column_int(statement, 0);
            }
            sqlite3_finalize(statement);
        } else {
            [DatabaseBase failedToRunQuery:[query UTF8String]];
        }
        sqlite3_close(database);
    } else {
        [DatabaseBase failedToOpen];
    }
    return _num;
}

/*
 * Number of Items Required
 */
- (int)numberOfItemsRequiredByUid:(unsigned long long)uid
{
    //Return value
    int _num = 0;
    
    //Query
    NSString *query = [NSString stringWithFormat:@"SELECT numItemsRequired FROM Quests WHERE uid = %lld", uid];
    sqlite3_stmt *statement;
    sqlite3 *database;
    
    if(sqlite3_open([self.path UTF8String], &database) == SQLITE_OK)
    {
        if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if(sqlite3_step(statement) == SQLITE_ROW)
            {
                _num = (int)sqlite3_column_int(statement, 0);
            }
            sqlite3_finalize(statement);
        } else {
            [DatabaseBase failedToRunQuery:[query UTF8String]];
        }
        sqlite3_close(database);
    } else {
        [DatabaseBase failedToOpen];
    }
    return _num;
}

/*
 * Item Required
 */
- (unsigned long long)itemRequiredUidByUid:(unsigned long long)uid
{
    //Return value
    unsigned long long _uid = 0;
    
    //Query
    NSString *query = [NSString stringWithFormat:@"SELECT item FROM Quests WHERE uid = %lld", uid];
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

/*
 * Exp Gained
 */
- (float)expGainedByUid:(unsigned long long)uid
{
    //Return value
    float _exp = 0.0f;
    
    //Query
    NSString *query = [NSString stringWithFormat:@"SELECT exp FROM Quests WHERE uid = %lld", uid];
    sqlite3_stmt *statement;
    sqlite3 *database;
    
    if(sqlite3_open([self.path UTF8String], &database) == SQLITE_OK)
    {
        if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if(sqlite3_step(statement) == SQLITE_ROW)
            {
                _exp = (float)sqlite3_column_double(statement, 0);
            }
            sqlite3_finalize(statement);
        } else {
            [DatabaseBase failedToRunQuery:[query UTF8String]];
        }
        sqlite3_close(database);
    } else {
        [DatabaseBase failedToOpen];
    }
    return _exp;
}

/*
 * Reward Items
 */
- (NSArray *)rewardItemsByUid:(unsigned long long)uid
{
    //Return value
    NSArray *_equippedItems = [NSArray array];
    NSString *stringToSeperate = nil;
    
    //Query
    NSString *query = [NSString stringWithFormat:@"SELECT rewardItems FROM Quests WHERE uid = %lld", uid];
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
        _equippedItems = nil;
    else
        _equippedItems = [stringToSeperate componentsSeparatedByString:@","];
    
    return _equippedItems;
}

/*
 * Chain Name
 */
- (NSString *)chainNameByUid:(unsigned long long)uid
{
    //Return value
    NSString *_name = @"";
    
    //Query
    NSString *query = [NSString stringWithFormat:@"SELECT chainName FROM Quests WHERE uid = %lld", uid];
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

@end
