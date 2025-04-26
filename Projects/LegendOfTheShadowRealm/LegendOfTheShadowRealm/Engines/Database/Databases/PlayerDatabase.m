//
//  PlayerDatabase.m
//  LegendOfTheShadowRealm
//
//  Created by Jeremy Fuellert on 2012-11-24.
//
//

#import "DefaultPlayer.h"
#import "PlayerDatabase.h"

@implementation PlayerDatabase

static int currentPlayerRow;

- (id)init
{
    return [self initWithDatabase:DATABASE_PLAYER_DATABASE];
}

/*
 * Player row id by index
 */
- (int)playerRowIdByIndex:(int)index
{
    //Return Value
    int rowId = 0;
    int currentIndex = 0;
    
    NSString *query = @"SELECT rowid FROM Player";
    sqlite3_stmt *statement;
    sqlite3 *database;
    
    if(sqlite3_open([self.path UTF8String], &database) == SQLITE_OK)
    {
        if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, nil) == SQLITE_OK)
        {
            while(sqlite3_step(statement) == SQLITE_ROW)
            {
                currentIndex ++;
                
                if(currentIndex == index)
                {
                    rowId = (int)sqlite3_column_int(statement, 0);
                }
            }
            
            sqlite3_finalize(statement);
        } else {
            [DatabaseBase failedToRunQuery:[query UTF8String]];
        }
        sqlite3_close(database);
    } else {
        [DatabaseBase failedToOpen];
    }
    return rowId;
}

/*
 * Retrieve basic player information based on the player's index in the database, not current row id
 */
- (NSDictionary *)basicPlayerInformationByIndex:(int)playerDatabaseIndex
{
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    
    int savedCurrentRowId = currentRowId;
    
    currentRowId = [self playerRowIdByIndex:playerDatabaseIndex];
    
    NSString *_name = [self name];
    NSString *_currentMap = [self currentMap];
    NSNumber *_level = [NSNumber numberWithInt:[self level]];
    NSNumber *_rowId = [NSNumber numberWithInt:currentRowId];
    
    if(_name)[dictionary setObject:_name forKey:@"name"];
    [dictionary setObject:_currentMap forKey:@"currentMap"];
    [dictionary setObject:_level forKey:@"level"];
    [dictionary setObject:_rowId forKey:@"rowId"];
    
    //Reset current row id
    currentRowId = savedCurrentRowId;
    
    return dictionary;
}

/*
 * Retrieve number of players in database
 */
- (int)numberOfPlayers
{
    //Return Value
    int numPlayers = 0;
    
    NSString *query = @"SELECT rowid FROM Player";
    sqlite3_stmt *statement;
    sqlite3 *database;
    
    if(sqlite3_open([self.path UTF8String], &database) == SQLITE_OK)
    {
        if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, nil) == SQLITE_OK)
        {
            while(sqlite3_step(statement) == SQLITE_ROW)
            {
                numPlayers ++;
            }
            
            sqlite3_finalize(statement);
        } else {
            [DatabaseBase failedToRunQuery:[query UTF8String]];
        }
        sqlite3_close(database);
    } else {
        [DatabaseBase failedToOpen];
    }
    return numPlayers;
}

/*
 * Create and Delete player
 */
- (void)createNewPlayer
{
    NSString *query = [DefaultPlayer createDefaultPlayerQuery];
    sqlite3_stmt *statement;
    sqlite3 *database;
    
    if(sqlite3_open([self.path UTF8String], &database) == SQLITE_OK)
    {
        if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, nil) == SQLITE_OK)
        {
            if(sqlite3_step(statement) != SQLITE_DONE)
            {
                [DatabaseBase failedToRunQuery:[query UTF8String]];
            }
            
            //Make the current player equal the newly created row id
            currentPlayerRow = [self playerRowIdByIndex:[self numberOfPlayers]];
            
            sqlite3_finalize(statement);
        } else {
            [DatabaseBase failedToRunQuery:[query UTF8String]];
        }
        sqlite3_close(database);
    } else {
        [DatabaseBase failedToOpen];
    }
}

- (void)deletePlayer:(int)rowId
{
    //Query
    NSString *query = [NSString stringWithFormat:@"DELETE FROM Player WHERE rowid = %d", rowId];
    sqlite3_stmt *statement;
    sqlite3 *database;
    
    if(sqlite3_open([self.path UTF8String], &database) == SQLITE_OK)
    {
        if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, nil) == SQLITE_OK)
        {
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

/*
 * Current Row Id
 */
@synthesize currentRowId;
- (void)setCurrentRowId:(int)_currentRowId
{
    currentPlayerRow = _currentRowId;
}

- (int)currentRowId
{
    return currentPlayerRow;
}

/*
 * Name
 */
@synthesize name;
- (void)setName:(NSString *)_name
{
    //Query
    NSString *query = [NSString stringWithFormat:@"UPDATE Player SET name = ? WHERE rowid = %d", [self currentRowId]];
    sqlite3_stmt *statement;
    sqlite3 *database;
    
    if(sqlite3_open([self.path UTF8String], &database) == SQLITE_OK)
    {
        if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, nil) == SQLITE_OK)
        {
            sqlite3_bind_text(statement, 1, [_name UTF8String], -1, SQLITE_TRANSIENT);
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

- (NSString *)name
{        
    //Return value
    NSString *_name = nil;
    
    //Query
    NSString *query = [NSString stringWithFormat:@"SELECT name FROM Player WHERE rowid = %d", [self currentRowId]];
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
 * Active Skills
 */
@synthesize activeSkills;
- (void)setActiveSkills:(NSArray *)_activeSkills
{
    NSString *activeSkillsString = [[_activeSkills valueForKey:@"description"] componentsJoinedByString:@","];
    
    //Query
    NSString *query = [NSString stringWithFormat:@"UPDATE Player SET activeSkills = ? WHERE rowid = %d", [self currentRowId]];
    sqlite3_stmt *statement;
    sqlite3 *database;
    
    if(sqlite3_open([self.path UTF8String], &database) == SQLITE_OK)
    {
        if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, nil) == SQLITE_OK)
        {
            sqlite3_bind_text(statement, 1, [activeSkillsString UTF8String], -1, SQLITE_TRANSIENT);
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
    
    [self sendEvent:EVENT_PLAYER_REFRESH_SKILLS_ACTIVE];
}

- (NSArray *)activeSkills
{
    //Return value
    NSArray *_activeSkills;
    NSString *stringToSeperate = nil;
    
    //Query
    NSString *query = [NSString stringWithFormat:@"SELECT activeSkills FROM Player WHERE rowid = %d", [self currentRowId]];
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
 * Passive Skills
 */
@synthesize passiveSkills;
- (void)setPassiveSkills:(NSArray *)_passiveSkills
{
    NSString *passiveSkillsString = [[_passiveSkills valueForKey:@"description"] componentsJoinedByString:@","];
    
    //Query
    NSString *query = [NSString stringWithFormat:@"UPDATE Player SET passiveSkills = ? WHERE rowid = %d", [self currentRowId]];
    sqlite3_stmt *statement;
    sqlite3 *database;
    
    if(sqlite3_open([self.path UTF8String], &database) == SQLITE_OK)
    {
        if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, nil) == SQLITE_OK)
        {
            sqlite3_bind_text(statement, 1, [passiveSkillsString UTF8String], -1, SQLITE_TRANSIENT);
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

- (NSArray *)passiveSkills
{
    //Return value
    NSArray *_passiveSkills;
    NSString *stringToSeperate = nil;
    
    //Query
    NSString *query = [NSString stringWithFormat:@"SELECT passiveSkills FROM Player WHERE rowid = %d", [self currentRowId]];
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
        _passiveSkills = nil;
    else
        _passiveSkills = [[NSArray alloc] initWithArray:[stringToSeperate componentsSeparatedByString:@","]];
    
    return [_passiveSkills autorelease];
}

/*
 * Active Quests
 */
@synthesize activeQuests;
- (void)setActiveQuests:(NSMutableArray *)_activeQuests
{
    NSString *activeQuestsString = [[_activeQuests valueForKey:@"description"] componentsJoinedByString:@","];
    
    //Query
    NSString *query = [NSString stringWithFormat:@"UPDATE Player SET activeQuests = ? WHERE rowid = %d", [self currentRowId]];
    sqlite3_stmt *statement;
    sqlite3 *database;
    
    if(sqlite3_open([self.path UTF8String], &database) == SQLITE_OK)
    {
        if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, nil) == SQLITE_OK)
        {
            sqlite3_bind_text(statement, 1, [activeQuestsString UTF8String], -1, SQLITE_TRANSIENT);
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
    
    //Refresh Active Quests
    [self sendEvent:EVENT_QUESTS_REFRESH];
}

- (NSMutableArray *)activeQuests
{
    //Return value
    NSArray *__activeQuests;
    NSMutableArray *_activeQuests = [NSMutableArray new];
    NSString *stringToSeperate = nil;
    
    //Query
    NSString *query = [NSString stringWithFormat:@"SELECT activeQuests FROM Player WHERE rowid = %d", [self currentRowId]];
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
    {
        __activeQuests = nil;
    } else
    {
        __activeQuests = [[[NSArray alloc] initWithArray:[stringToSeperate componentsSeparatedByString:@","]] autorelease];
        
        for(uint i = 0; i < __activeQuests.count; i++)
        {
            [_activeQuests addObject:[NSString stringWithString:[__activeQuests objectAtIndex:i]]];
        }
    }

    return [_activeQuests autorelease];
}

/*
 * Completed Quests
 */
@synthesize completedQuests;
- (void)setCompletedQuests:(NSMutableArray *)_completedQuests
{
    NSString *completeQuestsString = [[_completedQuests valueForKey:@"description"] componentsJoinedByString:@","];
    
    //Query
    NSString *query = [NSString stringWithFormat:@"UPDATE Player SET completedQuests = ? WHERE rowid = %d", [self currentRowId]];
    sqlite3_stmt *statement;
    sqlite3 *database;
    
    if(sqlite3_open([self.path UTF8String], &database) == SQLITE_OK)
    {
        if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, nil) == SQLITE_OK)
        {
            sqlite3_bind_text(statement, 1, [completeQuestsString UTF8String], -1, SQLITE_TRANSIENT);
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

- (NSMutableArray *)completedQuests
{
    //Return value
    NSArray *__completedQuests;
    NSMutableArray *_completedQuests = [NSMutableArray new];
    NSString *stringToSeperate = nil;
    
    //Query
    NSString *query = [NSString stringWithFormat:@"SELECT completedQuests FROM Player WHERE rowid = %d", [self currentRowId]];
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
    {
        __completedQuests = nil;
    } else
    {
        __completedQuests = [[[NSArray alloc] initWithArray:[stringToSeperate componentsSeparatedByString:@","]] autorelease];
        
        for(uint i = 0; i < __completedQuests.count; i++)
        {
            [_completedQuests addObject:[NSString stringWithString:[__completedQuests objectAtIndex:i]]];
        }
    }
    
    return [_completedQuests autorelease];
}

/*
 * Level
 */
@synthesize level;
- (void)setLevel:(int)_level
{
    //Query
    NSString *query = [NSString stringWithFormat:@"UPDATE Player SET level = ? WHERE rowid = %d", [self currentRowId]];
    sqlite3_stmt *statement;
    sqlite3 *database;
    
    if(sqlite3_open([self.path UTF8String], &database) == SQLITE_OK)
    {
        if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, nil) == SQLITE_OK)
        {
            sqlite3_bind_int(statement, 1, _level);
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

- (int)level
{
    //Return value
    int _level = 0;
    
    //Query
    NSString *query = [NSString stringWithFormat:@"SELECT level FROM Player WHERE rowid = %d", [self currentRowId]];
    sqlite3_stmt *statement;
    sqlite3 *database;
    
    if(sqlite3_open([self.path UTF8String], &database) == SQLITE_OK)
    {
        if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if(sqlite3_step(statement) == SQLITE_ROW)
            {
                _level = (int)sqlite3_column_int(statement, 0);
            }
            sqlite3_finalize(statement);
        } else {
            [DatabaseBase failedToRunQuery:[query UTF8String]];
        }
        sqlite3_close(database);
    } else {
        [DatabaseBase failedToOpen];
    }
    return _level;
}

/*
 * Health
 */
@synthesize health;
- (void)setHealth:(float)_health
{    
    //Send Event For Player UI Ticks
    if(_health > [self health])
    {
        _health = MIN(_health, [self health_max]);
        int updatedHealth = (int)_health - [self health];
        
        if(updatedHealth > 0)
            [self sendEvent:EVENT_PLAYER_HEALTH_GAIN andObject:[NSNumber numberWithInt:updatedHealth]];
    }
    else if(_health < [self health])
        [self sendEvent:EVENT_PLAYER_HEALTH_LOSS andObject:[NSNumber numberWithInt:[self health] - (int)_health]];
    
    //Query
    NSString *query = [NSString stringWithFormat:@"UPDATE Player SET health = ? WHERE rowid = %d", [self currentRowId]];
    sqlite3_stmt *statement;
    sqlite3 *database;
        
    if(sqlite3_open([self.path UTF8String], &database) == SQLITE_OK)
    {
        if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, nil) == SQLITE_OK)
        {
            sqlite3_bind_double(statement, 1, _health);
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

- (float)health
{
    //Return value
    float _health = 0.0f;
    
    //Query
    NSString *query = [NSString stringWithFormat:@"SELECT health FROM Player WHERE rowid = %d", [self currentRowId]];
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
 * Max health
 */
@synthesize health_max;
- (void)setHealth_max:(float)_health_max
{
    //Query
    NSString *query = [NSString stringWithFormat:@"UPDATE Player SET health_max = ? WHERE rowid = %d", [self currentRowId]];
    sqlite3_stmt *statement;
    sqlite3 *database;
    
    if(sqlite3_open([self.path UTF8String], &database) == SQLITE_OK)
    {
        if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, nil) == SQLITE_OK)
        {
            sqlite3_bind_double(statement, 1, _health_max);
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
    
    [self sendEvent:EVENT_PLAYER_REFRESH_PASSIVE_REGEN];
}

- (float)health_max
{
    //Return value
    float _health_max = 0.0f;
    
    //Query
    NSString *query = [NSString stringWithFormat:@"SELECT health_max FROM Player WHERE rowid = %d", [self currentRowId]];
    sqlite3_stmt *statement;
    sqlite3 *database;
    
    if(sqlite3_open([self.path UTF8String], &database) == SQLITE_OK)
    {
        if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if(sqlite3_step(statement) == SQLITE_ROW)
            {
                _health_max = (float)sqlite3_column_double(statement, 0);
            }
            sqlite3_finalize(statement);
        } else {
            [DatabaseBase failedToRunQuery:[query UTF8String]];
        }
        sqlite3_close(database);
    } else {
        [DatabaseBase failedToOpen];
    }
    return _health_max;
}

/*
 * Experience
 */
@synthesize experience;
- (void)setExperience:(float)_experience
{
    //Query
    NSString *query = [NSString stringWithFormat:@"UPDATE Player SET experience = ? WHERE rowid = %d", [self currentRowId]];
    sqlite3_stmt *statement;
    sqlite3 *database;
    
    if(sqlite3_open([self.path UTF8String], &database) == SQLITE_OK)
    {
        if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, nil) == SQLITE_OK)
        {
            sqlite3_bind_double(statement, 1, _experience);
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

- (float)experience
{
    //Return value
    float _experience = 0.0f;
    
    //Query
    NSString *query = [NSString stringWithFormat:@"SELECT experience FROM Player WHERE rowid = %d", [self currentRowId]];
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
 * Max experience
 */
@synthesize experience_max;
- (void)setExperience_max:(float)_experience_max
{
    //Query
    NSString *query = [NSString stringWithFormat:@"UPDATE Player SET experience_max = ? WHERE rowid = %d", [self currentRowId]];
    sqlite3_stmt *statement;
    sqlite3 *database;
    
    if(sqlite3_open([self.path UTF8String], &database) == SQLITE_OK)
    {
        if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, nil) == SQLITE_OK)
        {
            sqlite3_bind_double(statement, 1, _experience_max);
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

- (float)experience_max
{
    //Return value
    float _experience_max = 0.0f;
    
    //Query
    NSString *query = [NSString stringWithFormat:@"SELECT experience_max FROM Player WHERE rowid = %d", [self currentRowId]];
    sqlite3_stmt *statement;
    sqlite3 *database;
    
    if(sqlite3_open([self.path UTF8String], &database) == SQLITE_OK)
    {
        if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if(sqlite3_step(statement) == SQLITE_ROW)
            {
                _experience_max = (float)sqlite3_column_double(statement, 0);
            }
            sqlite3_finalize(statement);
        } else {
            [DatabaseBase failedToRunQuery:[query UTF8String]];
        }
        sqlite3_close(database);
    } else {
        [DatabaseBase failedToOpen];
    }
    return _experience_max;
}

/*
 * Max experience
 */
@synthesize strength;
- (void)setStrength:(float)_strength
{
    //Query
    NSString *query = [NSString stringWithFormat:@"UPDATE Player SET strength = ? WHERE rowid = %d", [self currentRowId]];
    sqlite3_stmt *statement;
    sqlite3 *database;
    
    if(sqlite3_open([self.path UTF8String], &database) == SQLITE_OK)
    {
        if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, nil) == SQLITE_OK)
        {
            sqlite3_bind_double(statement, 1, _strength);
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

- (float)strength
{
    //Return value
    float _strength = 0.0f;
    
    //Query
    NSString *query = [NSString stringWithFormat:@"SELECT experience_max FROM Player WHERE rowid = %d", [self currentRowId]];
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
@synthesize dexterity;
- (void)setDexterity:(float)_dexterity
{
    //Query
    NSString *query = [NSString stringWithFormat:@"UPDATE Player SET dexterity = ? WHERE rowid = %d", [self currentRowId]];
    sqlite3_stmt *statement;
    sqlite3 *database;
    
    if(sqlite3_open([self.path UTF8String], &database) == SQLITE_OK)
    {
        if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, nil) == SQLITE_OK)
        {
            sqlite3_bind_double(statement, 1, _dexterity);
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

- (float)dexterity
{
    //Return value
    float _dexterity = 0.0f;
    
    //Query
    NSString *query = [NSString stringWithFormat:@"SELECT dexterity FROM Player WHERE rowid = %d", [self currentRowId]];
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
@synthesize stamina;
- (void)setStamina:(float)_stamina
{
    //Query
    NSString *query = [NSString stringWithFormat:@"UPDATE Player SET stamina = ? WHERE rowid = %d", [self currentRowId]];
    sqlite3_stmt *statement;
    sqlite3 *database;
    
    if(sqlite3_open([self.path UTF8String], &database) == SQLITE_OK)
    {
        if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, nil) == SQLITE_OK)
        {
            sqlite3_bind_double(statement, 1, _stamina);
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

- (float)stamina
{
    //Return value
    float _stamina = 0.0f;
    
    //Query
    NSString *query = [NSString stringWithFormat:@"SELECT stamina FROM Player WHERE rowid = %d", [self currentRowId]];
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
@synthesize speed;
- (void)setSpeed:(float)_speed
{
    //Query
    NSString *query = [NSString stringWithFormat:@"UPDATE Player SET speed = ? WHERE rowid = %d", [self currentRowId]];
    sqlite3_stmt *statement;
    sqlite3 *database;
    
    if(sqlite3_open([self.path UTF8String], &database) == SQLITE_OK)
    {
        if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, nil) == SQLITE_OK)
        {
            sqlite3_bind_double(statement, 1, _speed);
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

- (float)speed
{
    //Return value
    float _speed = 0.0f;
    
    //Query
    NSString *query = [NSString stringWithFormat:@"SELECT speed FROM Player WHERE rowid = %d", [self currentRowId]];
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
@synthesize range;
- (void)setRange:(float)_range
{
    //Query
    NSString *query = [NSString stringWithFormat:@"UPDATE Player SET range = ? WHERE rowid = %d", [self currentRowId]];
    sqlite3_stmt *statement;
    sqlite3 *database;
    
    if(sqlite3_open([self.path UTF8String], &database) == SQLITE_OK)
    {
        if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, nil) == SQLITE_OK)
        {
            sqlite3_bind_double(statement, 1, _range);
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

- (float)range
{
    //Return value
    float _range = 0.0f;
    
    //Query
    NSString *query = [NSString stringWithFormat:@"SELECT range FROM Player WHERE rowid = %d", [self currentRowId]];
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
@synthesize armor;
- (void)setArmor:(float)_armor
{
    //Query
    NSString *query = [NSString stringWithFormat:@"UPDATE Player SET armor = ? WHERE rowid = %d", [self currentRowId]];
    sqlite3_stmt *statement;
    sqlite3 *database;
    
    if(sqlite3_open([self.path UTF8String], &database) == SQLITE_OK)
    {
        if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, nil) == SQLITE_OK)
        {
            sqlite3_bind_double(statement, 1, _armor);
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

- (float)armor
{
    //Return value
    float _armor = 0.0f;
    
    //Query
    NSString *query = [NSString stringWithFormat:@"SELECT armor FROM Player WHERE rowid = %d", [self currentRowId]];
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
 * Min Weapon Damage
 */
@synthesize minWeaponDamage;
- (void)setMinWeaponDamage:(float)_minWeaponDamage
{
    //Query
    NSString *query = [NSString stringWithFormat:@"UPDATE Player SET minWeaponDamage = ? WHERE rowid = %d", [self currentRowId]];
    sqlite3_stmt *statement;
    sqlite3 *database;
    
    if(sqlite3_open([self.path UTF8String], &database) == SQLITE_OK)
    {
        if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, nil) == SQLITE_OK)
        {
            sqlite3_bind_double(statement, 1, _minWeaponDamage);
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

- (float)minWeaponDamage
{
    //Return value
    float _minWeaponDamage = 0.0f;
    
    //Query
    NSString *query = [NSString stringWithFormat:@"SELECT minWeaponDamage FROM Player WHERE rowid = %d", [self currentRowId]];
    sqlite3_stmt *statement;
    sqlite3 *database;
    
    if(sqlite3_open([self.path UTF8String], &database) == SQLITE_OK)
    {
        if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if(sqlite3_step(statement) == SQLITE_ROW)
            {
                _minWeaponDamage = (float)sqlite3_column_double(statement, 0);
            }
            sqlite3_finalize(statement);
        } else {
            [DatabaseBase failedToRunQuery:[query UTF8String]];
        }
        sqlite3_close(database);
    } else {
        [DatabaseBase failedToOpen];
    }
    return _minWeaponDamage;
}

/*
 * Max Weapon Damage
 */
@synthesize maxWeaponDamage;
- (void)setMaxWeaponDamage:(float)_maxWeaponDamage
{
    //Query
    NSString *query = [NSString stringWithFormat:@"UPDATE Player SET maxWeaponDamage = ? WHERE rowid = %d", [self currentRowId]];
    sqlite3_stmt *statement;
    sqlite3 *database;
    
    if(sqlite3_open([self.path UTF8String], &database) == SQLITE_OK)
    {
        if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, nil) == SQLITE_OK)
        {
            sqlite3_bind_double(statement, 1, _maxWeaponDamage);
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

- (float)maxWeaponDamage
{
    //Return value
    float _maxWeaponDamage = 0.0f;
    
    //Query
    NSString *query = [NSString stringWithFormat:@"SELECT maxWeaponDamage FROM Player WHERE rowid = %d", [self currentRowId]];
    sqlite3_stmt *statement;
    sqlite3 *database;
    
    if(sqlite3_open([self.path UTF8String], &database) == SQLITE_OK)
    {
        if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if(sqlite3_step(statement) == SQLITE_ROW)
            {
                _maxWeaponDamage = (float)sqlite3_column_double(statement, 0);
            }
            sqlite3_finalize(statement);
        } else {
            [DatabaseBase failedToRunQuery:[query UTF8String]];
        }
        sqlite3_close(database);
    } else {
        [DatabaseBase failedToOpen];
    }
    return _maxWeaponDamage;
}

/*
 * Weapon Strength
 */
@synthesize weaponStrength;
- (void)setWeaponStrength:(float)_weaponStrength
{
    //Query
    NSString *query = [NSString stringWithFormat:@"UPDATE Player SET weaponStrength = ? WHERE rowid = %d", [self currentRowId]];
    sqlite3_stmt *statement;
    sqlite3 *database;
    
    if(sqlite3_open([self.path UTF8String], &database) == SQLITE_OK)
    {
        if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, nil) == SQLITE_OK)
        {
            sqlite3_bind_double(statement, 1, _weaponStrength);
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

- (float)weaponStrength
{
    //Return value
    float _weaponStrength = 0.0f;
    
    //Query
    NSString *query = [NSString stringWithFormat:@"SELECT weaponStrength FROM Player WHERE rowid = %d", [self currentRowId]];
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

/*
 * World position X
 */
@synthesize worldPositionX;
- (void)setWorldPositionX:(int)_worldPositionX
{
    //Query
    NSString *query = [NSString stringWithFormat:@"UPDATE Player SET worldPositionX = ? WHERE rowid = %d", [self currentRowId]];
    sqlite3_stmt *statement;
    sqlite3 *database;
    
    if(sqlite3_open([self.path UTF8String], &database) == SQLITE_OK)
    {
        if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, nil) == SQLITE_OK)
        {
            sqlite3_bind_int(statement, 1, _worldPositionX);
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

- (int)worldPositionX
{
    //Return value
    int __worldPositionX = 0;
    
    //Query
    NSString *query = [NSString stringWithFormat:@"SELECT worldPositionX FROM Player WHERE rowid = %d", [self currentRowId]];
    sqlite3_stmt *statement;
    sqlite3 *database;
    
    if(sqlite3_open([self.path UTF8String], &database) == SQLITE_OK)
    {
        if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if(sqlite3_step(statement) == SQLITE_ROW)
            {
                __worldPositionX = (int)sqlite3_column_int(statement, 0);
            }
            sqlite3_finalize(statement);
        } else {
            [DatabaseBase failedToRunQuery:[query UTF8String]];
        }
        sqlite3_close(database);
    } else {
        [DatabaseBase failedToOpen];
    }
    return __worldPositionX;
}

/*
 * World position Y
 */
@synthesize worldPositionY;
- (void)setWorldPositionY:(int)_worldPositionY
{
    //Query
    NSString *query = [NSString stringWithFormat:@"UPDATE Player SET worldPositionY = ? WHERE rowid = %d", [self currentRowId]];
    sqlite3_stmt *statement;
    sqlite3 *database;
    
    if(sqlite3_open([self.path UTF8String], &database) == SQLITE_OK)
    {
        if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, nil) == SQLITE_OK)
        {
            sqlite3_bind_int(statement, 1, _worldPositionY);
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

- (int)worldPositionY
{
    //Return value
    int __worldPositionY = 0;
    
    //Query
    NSString *query = [NSString stringWithFormat:@"SELECT worldPositionY FROM Player WHERE rowid = %d", [self currentRowId]];
    sqlite3_stmt *statement;
    sqlite3 *database;
    
    if(sqlite3_open([self.path UTF8String], &database) == SQLITE_OK)
    {
        if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if(sqlite3_step(statement) == SQLITE_ROW)
            {
                __worldPositionY = (int)sqlite3_column_int(statement, 0);
            }
            sqlite3_finalize(statement);
        } else {
            [DatabaseBase failedToRunQuery:[query UTF8String]];
        }
        sqlite3_close(database);
    } else {
        [DatabaseBase failedToOpen];
    }
    return __worldPositionY;
}

/*
 * Dungeon position X
 */
@synthesize dungeonPositionX;
- (void)setDungeonPositionX:(int)_dungeonPositionX
{
    //Query
    NSString *query = [NSString stringWithFormat:@"UPDATE Player SET dungeonPositionX = ? WHERE rowid = %d", [self currentRowId]];
    sqlite3_stmt *statement;
    sqlite3 *database;
    
    if(sqlite3_open([self.path UTF8String], &database) == SQLITE_OK)
    {
        if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, nil) == SQLITE_OK)
        {
            sqlite3_bind_int(statement, 1, _dungeonPositionX);
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

- (int)dungeonPositionX
{
    //Return value
    int __dungeonPositionX = 0;
    
    //Query
    NSString *query = [NSString stringWithFormat:@"SELECT dungeonPositionX FROM Player WHERE rowid = %d", [self currentRowId]];
    sqlite3_stmt *statement;
    sqlite3 *database;
    
    if(sqlite3_open([self.path UTF8String], &database) == SQLITE_OK)
    {
        if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if(sqlite3_step(statement) == SQLITE_ROW)
            {
                __dungeonPositionX = (int)sqlite3_column_int(statement, 0);
            }
            sqlite3_finalize(statement);
        } else {
            [DatabaseBase failedToRunQuery:[query UTF8String]];
        }
        sqlite3_close(database);
    } else {
        [DatabaseBase failedToOpen];
    }
    return __dungeonPositionX;
}

/*
 * Dungeon position Y
 */
@synthesize dungeonPositionY;
- (void)setDungeonPositionY:(int)_dungeonPositionY
{
    //Query
    NSString *query = [NSString stringWithFormat:@"UPDATE Player SET dungeonPositionY = ? WHERE rowid = %d", [self currentRowId]];
    sqlite3_stmt *statement;
    sqlite3 *database;
    
    if(sqlite3_open([self.path UTF8String], &database) == SQLITE_OK)
    {
        if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, nil) == SQLITE_OK)
        {
            sqlite3_bind_int(statement, 1, _dungeonPositionY);
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

- (int)dungeonPositionY
{
    //Return value
    int __dungeonPositionY = 0;
    
    //Query
    NSString *query = [NSString stringWithFormat:@"SELECT dungeonPositionY FROM Player WHERE rowid = %d", [self currentRowId]];
    sqlite3_stmt *statement;
    sqlite3 *database;
    
    if(sqlite3_open([self.path UTF8String], &database) == SQLITE_OK)
    {
        if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if(sqlite3_step(statement) == SQLITE_ROW)
            {
                __dungeonPositionY = (int)sqlite3_column_int(statement, 0);
            }
            sqlite3_finalize(statement);
        } else {
            [DatabaseBase failedToRunQuery:[query UTF8String]];
        }
        sqlite3_close(database);
    } else {
        [DatabaseBase failedToOpen];
    }
    return __dungeonPositionY;
}

/*
 * Current map
 */
@synthesize currentMap;
- (void)setCurrentMap:(NSString *)_currentMap
{
    //Query
    NSString *query = [NSString stringWithFormat:@"UPDATE Player SET currentMap = ? WHERE rowid = %d", [self currentRowId]];
    sqlite3_stmt *statement;
    sqlite3 *database;
    
    if(sqlite3_open([self.path UTF8String], &database) == SQLITE_OK)
    {
        if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, nil) == SQLITE_OK)
        {
            sqlite3_bind_text(statement, 1, [_currentMap UTF8String], -1, SQLITE_TRANSIENT);
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

- (NSString *)currentMap
{
    //Return value
    NSString *_currentMap = nil;
    
    //Query
    NSString *query = [NSString stringWithFormat:@"SELECT currentMap FROM Player WHERE rowid = %d", [self currentRowId]];
    sqlite3_stmt *statement;
    sqlite3 *database;
    
    if(sqlite3_open([self.path UTF8String], &database) == SQLITE_OK)
    {
        if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if(sqlite3_step(statement) == SQLITE_ROW)
            {
                _currentMap = ((const char *)sqlite3_column_text(statement, 0)) ? [NSString stringWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] : nil;
            }
            sqlite3_finalize(statement);
        } else {
            [DatabaseBase failedToRunQuery:[query UTF8String]];
        }
        sqlite3_close(database);
    } else {
        [DatabaseBase failedToOpen];
    }
    return _currentMap;
}

/*
 * Weapon Type
 */
@synthesize weaponType;
- (void)setWeaponType:(int)_weaponType
{
    //Query
    NSString *query = [NSString stringWithFormat:@"UPDATE Player SET weaponType = ? WHERE rowid = %d", [self currentRowId]];
    sqlite3_stmt *statement;
    sqlite3 *database;
    
    if(sqlite3_open([self.path UTF8String], &database) == SQLITE_OK)
    {
        if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, nil) == SQLITE_OK)
        {
            sqlite3_bind_int(statement, 1, _weaponType);
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

- (int)weaponType
{
    //Return value
    int _weaponType = 20;
    
    //Query
    NSString *query = [NSString stringWithFormat:@"SELECT weaponType FROM Player WHERE rowid = %d", [self currentRowId]];
    sqlite3_stmt *statement;
    sqlite3 *database;
    
    if(sqlite3_open([self.path UTF8String], &database) == SQLITE_OK)
    {
        if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if(sqlite3_step(statement) == SQLITE_ROW)
            {
                _weaponType = (int)sqlite3_column_int(statement, 0);
            }
            sqlite3_finalize(statement);
        } else {
            [DatabaseBase failedToRunQuery:[query UTF8String]];
        }
        sqlite3_close(database);
    } else {
        [DatabaseBase failedToOpen];
    }
    return _weaponType;
}

/*
 * Inventory Items
 */
@synthesize inventoryItems;
- (void)setInventoryItems:(NSArray *)_inventoryItems
{
    NSString *inventoryItemsString = [[_inventoryItems valueForKey:@"description"] componentsJoinedByString:@","];
    
    //Query
    NSString *query = [NSString stringWithFormat:@"UPDATE Player SET inventoryItems = ? WHERE rowid = %d", [self currentRowId]];
    sqlite3_stmt *statement;
    sqlite3 *database;
    
    if(sqlite3_open([self.path UTF8String], &database) == SQLITE_OK)
    {
        if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, nil) == SQLITE_OK)
        {
            sqlite3_bind_text(statement, 1, [inventoryItemsString UTF8String], -1, SQLITE_TRANSIENT);
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

- (NSArray *)inventoryItems
{
    //Return value
    NSArray *_inventoryItems = [NSArray array];
    NSString *stringToSeperate = nil;
    
    //Query
    NSString *query = [NSString stringWithFormat:@"SELECT inventoryItems FROM Player WHERE rowid = %d", [self currentRowId]];
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
        _inventoryItems = nil;
    else
        _inventoryItems = [stringToSeperate componentsSeparatedByString:@","];
    
    return _inventoryItems;
}

/*
 * Equipped Items
 */
@synthesize equippedItems;
- (void)setEquippedItems:(NSArray *)_equippedItems
{
    NSString *inventoryItemsString = [[_equippedItems valueForKey:@"description"] componentsJoinedByString:@","];
    
    //Query
    NSString *query = [NSString stringWithFormat:@"UPDATE Player SET equippedItems = ? WHERE rowid = %d", [self currentRowId]];
    sqlite3_stmt *statement;
    sqlite3 *database;
    
    if(sqlite3_open([self.path UTF8String], &database) == SQLITE_OK)
    {
        if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, nil) == SQLITE_OK)
        {
            sqlite3_bind_text(statement, 1, [inventoryItemsString UTF8String], -1, SQLITE_TRANSIENT);
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

- (NSArray *)equippedItems
{
    //Return value
    NSArray *_equippedItems = [NSArray array];
    NSString *stringToSeperate = nil;
    
    //Query
    NSString *query = [NSString stringWithFormat:@"SELECT equippedItems FROM Player WHERE rowid = %d", [self currentRowId]];
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

@end
