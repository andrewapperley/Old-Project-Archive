//
//  SkillDatabase.m
//  LegendOfTheShadowRealm
//
//  Created by Jeremy Fuellert on 2012-12-29.
//
//

#import "SkillDatabase.h"

@implementation SkillDatabase

- (id)init
{
    return [self initWithDatabase:DATABASE_SKILL_DATABASE];
}

/*
 * List All Active Skills
 */
- (NSArray *)listAllActiveSkills
{
    NSMutableArray *skillNames = [NSMutableArray new];
    
    //Query
    const char *query = "SELECT name FROM Skills WHERE activeSkill = 1";
    sqlite3_stmt *statement;
    sqlite3 *database;
    
    if(sqlite3_open([self.path UTF8String], &database) == SQLITE_OK)
    {
        if(sqlite3_prepare_v2(database, query, -1, &statement, NULL) == SQLITE_OK)
        {
            if(sqlite3_step(statement) == SQLITE_ROW)
            {
                NSString *skillName = ((const char *)sqlite3_column_text(statement, 0)) ? [NSString stringWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] : nil;
                [skillNames addObject:skillName];
            }
            sqlite3_finalize(statement);
        } else {
            [DatabaseBase failedToRunQuery:query];
        }
        sqlite3_close(database);
    } else {
        [DatabaseBase failedToOpen];
    }
    
    NSArray *skills = [[NSArray alloc] initWithArray:[self skillsByNames:skillNames]];
    [self destroy:skillNames];
    
    return [skills autorelease];
}

/*
 * List All Passive Skills
 */
- (NSArray *)listAllPassiveSkills
{
    NSMutableArray *skillNames = [NSMutableArray new];
    
    //Query
    const char *query = "SELECT name FROM Skills WHERE activeSkill = 0";
    sqlite3_stmt *statement;
    sqlite3 *database;
    
    if(sqlite3_open([self.path UTF8String], &database) == SQLITE_OK)
    {
        if(sqlite3_prepare_v2(database, query, -1, &statement, NULL) == SQLITE_OK)
        {
            if(sqlite3_step(statement) == SQLITE_ROW)
            {
                NSString *skillName = ((const char *)sqlite3_column_text(statement, 0)) ? [NSString stringWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] : nil;
                [skillNames addObject:skillName];
            }
            sqlite3_finalize(statement);
        } else {
            [DatabaseBase failedToRunQuery:query];
        }
        sqlite3_close(database);
    } else {
        [DatabaseBase failedToOpen];
    }
    
    NSArray *skills = [[NSArray alloc] initWithArray:[self skillsByNames:skillNames]];
    [self destroy:skillNames];

    return [skills autorelease];
}

/*
 * Skill By Name
 */
- (NSDictionary *)skillByName:(NSString *)skill
{
    NSMutableDictionary *dictionary = [NSMutableDictionary new];
    
    NSNumber *multiplier = [NSNumber numberWithFloat:[self multiplierBySkill:skill]];
    NSNumber *emitterWidth = [NSNumber numberWithFloat:[self emitterWidthBySkill:skill]];
    NSNumber *emtterHeight = [NSNumber numberWithFloat:[self emitterHeightBySkill:skill]];
    NSNumber *birthRate = [NSNumber numberWithFloat:[self birthRateBySkill:skill]];
    NSNumber *velocity = [NSNumber numberWithFloat:[self velocityBySkill:skill]];
    NSNumber *velocityRange = [NSNumber numberWithFloat:[self velocityRangeBySkill:skill]];
    NSString *particleImage = [self particleImageBySkill:skill];
    NSNumber *particleRed = [NSNumber numberWithFloat:[self particleRedBySkill:skill]];
    NSNumber *particleBlue = [NSNumber numberWithFloat:[self particleBlueBySkill:skill]];
    NSNumber *particleGreen = [NSNumber numberWithFloat:[self particleGreenBySkill:skill]];
    NSString *emitterShape = [self emitterShapeBySkill:skill];
    NSString *emitterMode = [self emitterModeBySkill:skill];
    NSNumber *activeSkill = [NSNumber numberWithBool:[self activeSkillBySkill:skill]];
    NSString *toolTip = [self toolTipBySkill:skill];
    NSString *description = [self descriptionBySkill:skill];
    NSString *formula = [self formulaBySkill:skill];
    NSNumber *spin = [NSNumber numberWithFloat:[self spinBySkill:skill]];
    NSNumber *procChance = [NSNumber numberWithFloat:[self procChanceBySkill:skill]];
    NSNumber *lifetime = [NSNumber numberWithFloat:[self lifetimeBySkill:skill]];
    
    [dictionary setObject:multiplier forKey:@"multiplier"];
    [dictionary setObject:emitterWidth forKey:@"emitterWidth"];
    [dictionary setObject:emtterHeight forKey:@"emtterHeight"];
    [dictionary setObject:birthRate forKey:@"birthRate"];
    [dictionary setObject:velocity forKey:@"velocity"];
    [dictionary setObject:velocityRange forKey:@"velocityRange"];
    [dictionary setObject:particleImage forKey:@"particleImage"];
    [dictionary setObject:particleRed forKey:@"particleRed"];
    [dictionary setObject:particleBlue forKey:@"particleBlue"];
    [dictionary setObject:particleGreen forKey:@"particleGreen"];
    [dictionary setObject:spin forKey:@"spin"];
    [dictionary setObject:emitterShape forKey:@"emitterShape"];
    [dictionary setObject:emitterMode forKey:@"emitterMode"];
    [dictionary setObject:activeSkill forKey:@"activeSkill"];
    [dictionary setObject:toolTip forKey:@"toolTip"];
    [dictionary setObject:description forKey:@"description"];
    [dictionary setObject:formula forKey:@"formula"];
    [dictionary setObject:procChance forKey:@"procChance"];
    [dictionary setObject:lifetime forKey:@"lifetime"];
    
    return [dictionary autorelease];
}

/*
 * Skills By Name
 */
- (NSArray *)skillsByNames:(NSArray *)skills
{
    NSArray *skillNames = [skills retain];
    NSMutableArray *skillObjects = [NSMutableArray new];
    
    for(int i = 0; i < [skillNames count]; i++)
    {
        NSDictionary *skill = [[self skillByName:(NSString *)[skillNames objectAtIndex:i]] retain];
        [skillObjects addObject:skill];
        [self destroy:skill];
    }
    
    NSArray *returnSkills = [[NSArray alloc] initWithArray:skillObjects];
    
    [self destroy:skillNames];
    [self destroy:skillObjects];
    
    return [returnSkills autorelease];
}

/*
 * Multiplier
 */
- (float)multiplierBySkill:(NSString *)skill
{
    //Return value
    float _multiplier = 0.0f;
    
    //Query
    NSString *query = [NSString stringWithFormat:@"SELECT multiplier FROM Skills WHERE name = \'%@\'", skill];
    sqlite3_stmt *statement;
    sqlite3 *database;
    
    if(sqlite3_open([self.path UTF8String], &database) == SQLITE_OK)
    {
        if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if(sqlite3_step(statement) == SQLITE_ROW)
            {
                _multiplier = (float)sqlite3_column_double(statement, 0);
            }
            sqlite3_finalize(statement);
        } else {
            [DatabaseBase failedToRunQuery:[query UTF8String]];
        }
        sqlite3_close(database);
    } else {
        [DatabaseBase failedToOpen];
    }
    return _multiplier;
}

/*
 * Emitter Width
 */
- (float)emitterWidthBySkill:(NSString *)skill
{
    //Return value
    float _emitterWidth = 0.0f;
    
    //Query
    NSString *query = [NSString stringWithFormat:@"SELECT emitterWidth FROM Skills WHERE name = \'%@\'", skill];
    sqlite3_stmt *statement;
    sqlite3 *database;
    
    if(sqlite3_open([self.path UTF8String], &database) == SQLITE_OK)
    {
        if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if(sqlite3_step(statement) == SQLITE_ROW)
            {
                _emitterWidth = (float)sqlite3_column_double(statement, 0);
            }
            sqlite3_finalize(statement);
        } else {
            [DatabaseBase failedToRunQuery:[query UTF8String]];
        }
        sqlite3_close(database);
    } else {
        [DatabaseBase failedToOpen];
    }
    return _emitterWidth;
}

/*
 * Emitter Height
 */
- (float)emitterHeightBySkill:(NSString *)skill
{
    //Return value
    float _emitterHeight = 0.0f;
    
    //Query
    NSString *query = [NSString stringWithFormat:@"SELECT emitterHeight FROM Skills WHERE name = \'%@\'", skill];
    sqlite3_stmt *statement;
    sqlite3 *database;
    
    if(sqlite3_open([self.path UTF8String], &database) == SQLITE_OK)
    {
        if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if(sqlite3_step(statement) == SQLITE_ROW)
            {
                _emitterHeight = (float)sqlite3_column_double(statement, 0);
            }
            sqlite3_finalize(statement);
        } else {
            [DatabaseBase failedToRunQuery:[query UTF8String]];
        }
        sqlite3_close(database);
    } else {
        [DatabaseBase failedToOpen];
    }
    return _emitterHeight;
}

/*
 * Birth Rate
 */
- (float)birthRateBySkill:(NSString *)skill
{
    //Return value
    float _birthRate = 0.0f;
    
    //Query
    NSString *query = [NSString stringWithFormat:@"SELECT birthRate FROM Skills WHERE name = \'%@\'", skill];
    sqlite3_stmt *statement;
    sqlite3 *database;
    
    if(sqlite3_open([self.path UTF8String], &database) == SQLITE_OK)
    {
        if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if(sqlite3_step(statement) == SQLITE_ROW)
            {
                _birthRate = (float)sqlite3_column_double(statement, 0);
            }
            sqlite3_finalize(statement);
        } else {
            [DatabaseBase failedToRunQuery:[query UTF8String]];
        }
        sqlite3_close(database);
    } else {
        [DatabaseBase failedToOpen];
    }
    return _birthRate;
}

/*
 * Velocity
 */
- (float)velocityBySkill:(NSString *)skill
{
    //Return value
    float _velocity = 0.0f;
    
    //Query
    NSString *query = [NSString stringWithFormat:@"SELECT velocity FROM Skills WHERE name = \'%@\'", skill];
    sqlite3_stmt *statement;
    sqlite3 *database;
    
    if(sqlite3_open([self.path UTF8String], &database) == SQLITE_OK)
    {
        if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if(sqlite3_step(statement) == SQLITE_ROW)
            {
                _velocity = (float)sqlite3_column_double(statement, 0);
            }
            sqlite3_finalize(statement);
        } else {
            [DatabaseBase failedToRunQuery:[query UTF8String]];
        }
        sqlite3_close(database);
    } else {
        [DatabaseBase failedToOpen];
    }
    return _velocity;
}

/*
 * Velocity Range
 */
- (float)velocityRangeBySkill:(NSString *)skill
{
    //Return value
    float _velocityRange = 0.0f;
    
    //Query
    NSString *query = [NSString stringWithFormat:@"SELECT velocityRange FROM Skills WHERE name = \'%@\'", skill];
    sqlite3_stmt *statement;
    sqlite3 *database;
    
    if(sqlite3_open([self.path UTF8String], &database) == SQLITE_OK)
    {
        if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if(sqlite3_step(statement) == SQLITE_ROW)
            {
                _velocityRange = (float)sqlite3_column_double(statement, 0);
            }
            sqlite3_finalize(statement);
        } else {
            [DatabaseBase failedToRunQuery:[query UTF8String]];
        }
        sqlite3_close(database);
    } else {
        [DatabaseBase failedToOpen];
    }
    return _velocityRange;
}

/*
 * Particle Image
 */
- (NSString *)particleImageBySkill:(NSString *)skill
{
    //Return value
    NSString *_particleImage = nil;
    
    //Query
    NSString *query = [NSString stringWithFormat:@"SELECT particleImage FROM Skills WHERE name = \'%@\'", skill];
    sqlite3_stmt *statement;
    sqlite3 *database;
    
    if(sqlite3_open([self.path UTF8String], &database) == SQLITE_OK)
    {
        if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if(sqlite3_step(statement) == SQLITE_ROW)
            {
                _particleImage = ((const char *)sqlite3_column_text(statement, 0)) ? [NSString stringWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] : nil;
            }
            sqlite3_finalize(statement);
        } else {
            [DatabaseBase failedToRunQuery:[query UTF8String]];
        }
        sqlite3_close(database);
    } else {
        [DatabaseBase failedToOpen];
    }
    return _particleImage;
}

/*
 * Particle Red
 */
- (float)particleRedBySkill:(NSString *)skill
{
    //Return value
    float _particleRed = 0.0f;
    
    //Query
    NSString *query = [NSString stringWithFormat:@"SELECT particleRed FROM Skills WHERE name = \'%@\'", skill];
    sqlite3_stmt *statement;
    sqlite3 *database;
    
    if(sqlite3_open([self.path UTF8String], &database) == SQLITE_OK)
    {
        if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if(sqlite3_step(statement) == SQLITE_ROW)
            {
                _particleRed = (float)sqlite3_column_double(statement, 0);
            }
            sqlite3_finalize(statement);
        } else {
            [DatabaseBase failedToRunQuery:[query UTF8String]];
        }
        sqlite3_close(database);
    } else {
        [DatabaseBase failedToOpen];
    }
    return _particleRed;
}

/*
 * Particle Blue
 */
- (float)particleBlueBySkill:(NSString *)skill
{
    //Return value
    float _particleBlue = 0.0f;
    
    //Query
    NSString *query = [NSString stringWithFormat:@"SELECT particleBlue FROM Skills WHERE name = \'%@\'", skill];
    sqlite3_stmt *statement;
    sqlite3 *database;
    
    if(sqlite3_open([self.path UTF8String], &database) == SQLITE_OK)
    {
        if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if(sqlite3_step(statement) == SQLITE_ROW)
            {
                _particleBlue = (float)sqlite3_column_double(statement, 0);
            }
            sqlite3_finalize(statement);
        } else {
            [DatabaseBase failedToRunQuery:[query UTF8String]];
        }
        sqlite3_close(database);
    } else {
        [DatabaseBase failedToOpen];
    }
    return _particleBlue;
}

/*
 * Particle Green
 */
- (float)particleGreenBySkill:(NSString *)skill
{
    //Return value
    float _particleGreen = 0.0f;
    
    //Query
    NSString *query = [NSString stringWithFormat:@"SELECT particleGreen FROM Skills WHERE name = \'%@\'", skill];
    sqlite3_stmt *statement;
    sqlite3 *database;
    
    if(sqlite3_open([self.path UTF8String], &database) == SQLITE_OK)
    {
        if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if(sqlite3_step(statement) == SQLITE_ROW)
            {
                _particleGreen = (float)sqlite3_column_double(statement, 0);
            }
            sqlite3_finalize(statement);
        } else {
            [DatabaseBase failedToRunQuery:[query UTF8String]];
        }
        sqlite3_close(database);
    } else {
        [DatabaseBase failedToOpen];
    }
    return _particleGreen;
}
/*
 * Particle Spin
 */
- (float)spinBySkill:(NSString *)skill
{
    //Return value
    float _spin = 0.0f;
    
    //Query
    NSString *query = [NSString stringWithFormat:@"SELECT spin FROM Skills WHERE name = \'%@\'", skill];
    sqlite3_stmt *statement;
    sqlite3 *database;
    
    if(sqlite3_open([self.path UTF8String], &database) == SQLITE_OK)
    {
        if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if(sqlite3_step(statement) == SQLITE_ROW)
            {
                _spin = (float)sqlite3_column_double(statement, 0);
            }
            sqlite3_finalize(statement);
        } else {
            [DatabaseBase failedToRunQuery:[query UTF8String]];
        }
        sqlite3_close(database);
    } else {
        [DatabaseBase failedToOpen];
    }
    return _spin;
}

/*
 * Emitter Shape
 */
- (NSString *)emitterShapeBySkill:(NSString *)skill
{
    //Return value
    NSString *_emitterShape = @"kCAEmitterLayerCuboid";
    
    //Query
    NSString *query = [NSString stringWithFormat:@"SELECT emitterShape FROM Skills WHERE name = \'%@\'", skill];
    sqlite3_stmt *statement;
    sqlite3 *database;
    
    if(sqlite3_open([self.path UTF8String], &database) == SQLITE_OK)
    {
        if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if(sqlite3_step(statement) == SQLITE_ROW)
            {
                _emitterShape = ((const char *)sqlite3_column_text(statement, 0)) ? [NSString stringWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] : nil;
            }
            sqlite3_finalize(statement);
        } else {
            [DatabaseBase failedToRunQuery:[query UTF8String]];
        }
        sqlite3_close(database);
    } else {
        [DatabaseBase failedToOpen];
    }
    return _emitterShape;
}

/*
 * Emitter Mode
 */
- (NSString *)emitterModeBySkill:(NSString *)skill
{
    //Return value
    NSString *_emitterMode = @"kCAEmitterLayerOutline";
    
    //Query
    NSString *query = [NSString stringWithFormat:@"SELECT emitterMode FROM Skills WHERE name = \'%@\'", skill];
    sqlite3_stmt *statement;
    sqlite3 *database;
    
    if(sqlite3_open([self.path UTF8String], &database) == SQLITE_OK)
    {
        if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if(sqlite3_step(statement) == SQLITE_ROW)
            {
                _emitterMode = ((const char *)sqlite3_column_text(statement, 0)) ? [NSString stringWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] : nil;
            }
            sqlite3_finalize(statement);
        } else {
            [DatabaseBase failedToRunQuery:[query UTF8String]];
        }
        sqlite3_close(database);
    } else {
        [DatabaseBase failedToOpen];
    }
    return _emitterMode;
}

/*
 * Active Skill
 */
- (BOOL)activeSkillBySkill:(NSString *)skill
{
    //Return value
    BOOL _activeSkill = FALSE;
    
    //Query
    NSString *query = [NSString stringWithFormat:@"SELECT activeSkill FROM Skills WHERE name = \'%@\'", skill];
    sqlite3_stmt *statement;
    sqlite3 *database;
    
    if(sqlite3_open([self.path UTF8String], &database) == SQLITE_OK)
    {
        if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if(sqlite3_step(statement) == SQLITE_ROW)
            {
                _activeSkill = (int)sqlite3_column_int(statement, 0);
            }
            sqlite3_finalize(statement);
        } else {
            [DatabaseBase failedToRunQuery:[query UTF8String]];
        }
        sqlite3_close(database);
    } else {
        [DatabaseBase failedToOpen];
    }
    return _activeSkill;
}

/*
 * ToolTip
 */
- (NSString *)toolTipBySkill:(NSString *)skill
{
    //Return value
    NSString *_toolTip = nil;
    
    //Query
    NSString *query = [NSString stringWithFormat:@"SELECT toolTip FROM Skills WHERE name = \'%@\'", skill];
    sqlite3_stmt *statement;
    sqlite3 *database;
    
    if(sqlite3_open([self.path UTF8String], &database) == SQLITE_OK)
    {
        if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if(sqlite3_step(statement) == SQLITE_ROW)
            {
                _toolTip = ((const char *)sqlite3_column_text(statement, 0)) ? [NSString stringWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] : @"";
            }
            sqlite3_finalize(statement);
        } else {
            [DatabaseBase failedToRunQuery:[query UTF8String]];
        }
        sqlite3_close(database);
    } else {
        [DatabaseBase failedToOpen];
    }
    return _toolTip;
}

/*
 * Description
 */
- (NSString *)descriptionBySkill:(NSString *)skill
{
    //Return value
    NSString *_description = nil;
    
    //Query
    NSString *query = [NSString stringWithFormat:@"SELECT description FROM Skills WHERE name = \'%@\'", skill];
    sqlite3_stmt *statement;
    sqlite3 *database;
    
    if(sqlite3_open([self.path UTF8String], &database) == SQLITE_OK)
    {
        if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if(sqlite3_step(statement) == SQLITE_ROW)
            {
                _description = ((const char *)sqlite3_column_text(statement, 0)) ? [NSString stringWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] : @"";
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
 * Formula
 */
- (NSString *)formulaBySkill:(NSString *)skill
{
    //Return value
    NSString *_formula = nil;
    
    //Query
    NSString *query = [NSString stringWithFormat:@"SELECT formula FROM Skills WHERE name = \'%@\'", skill];
    sqlite3_stmt *statement;
    sqlite3 *database;
    
    if(sqlite3_open([self.path UTF8String], &database) == SQLITE_OK)
    {
        if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if(sqlite3_step(statement) == SQLITE_ROW)
            {
                _formula = ((const char *)sqlite3_column_text(statement, 0)) ? [NSString stringWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] : @"";
            }
            sqlite3_finalize(statement);
        } else {
            [DatabaseBase failedToRunQuery:[query UTF8String]];
        }
        sqlite3_close(database);
    } else {
        [DatabaseBase failedToOpen];
    }
    return _formula;
}

/*
 * Proc Chance
 */
- (float)procChanceBySkill:(NSString *)skill
{
    //Return value
    float _chance = 0.0f;
    
    //Query
    NSString *query = [NSString stringWithFormat:@"SELECT procChance FROM Skills WHERE name = \'%@\'", skill];
    sqlite3_stmt *statement;
    sqlite3 *database;
    
    if(sqlite3_open([self.path UTF8String], &database) == SQLITE_OK)
    {
        if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if(sqlite3_step(statement) == SQLITE_ROW)
            {
                _chance = (float)sqlite3_column_double(statement, 0);
            }
            sqlite3_finalize(statement);
        } else {
            [DatabaseBase failedToRunQuery:[query UTF8String]];
        }
        sqlite3_close(database);
    } else {
        [DatabaseBase failedToOpen];
    }
    return _chance;
}

/*
 * Lifetime
 */
- (float)lifetimeBySkill:(NSString *)skill
{
    //Return value
    float _lifetime = 0.0f;
    
    //Query
    NSString *query = [NSString stringWithFormat:@"SELECT lifetime FROM Skills WHERE name = \'%@\'", skill];
    sqlite3_stmt *statement;
    sqlite3 *database;
    
    if(sqlite3_open([self.path UTF8String], &database) == SQLITE_OK)
    {
        if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if(sqlite3_step(statement) == SQLITE_ROW)
            {
                _lifetime = (float)sqlite3_column_double(statement, 0);
            }
            sqlite3_finalize(statement);
        } else {
            [DatabaseBase failedToRunQuery:[query UTF8String]];
        }
        sqlite3_close(database);
    } else {
        [DatabaseBase failedToOpen];
    }
    return _lifetime;
}

@end
