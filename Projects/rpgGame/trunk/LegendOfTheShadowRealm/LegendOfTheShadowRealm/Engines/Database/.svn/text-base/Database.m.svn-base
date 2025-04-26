//
//  Database.m
//  LegendOfTheShadowRealm
//
//  Created by Jeremy Fuellert on 2012-11-24.
//
//

#import "Database.h"

@implementation Database
@synthesize _enemyDatabase;
@synthesize _itemDatabase;
@synthesize _mapDatabase;
@synthesize _npcDatabase;
@synthesize _playerDatabase;
@synthesize _questDatabase;
@synthesize _skillDatabase;

static Database *_database;
+ (Database *)database
{
    return _database;
}

- (id)init
{
    self = [super init];
    if(self)
    {
        _database = self;
        [self createDatabases];
    }
    return self;
}

- (void)createDatabases
{
    _enemyDatabase = [EnemyDatabase new];
    _itemDatabase = [ItemDatabase new];
    _mapDatabase = [MapDatabase new];
    _npcDatabase = [NPCDatabase new];
    _playerDatabase = [PlayerDatabase new];
    _questDatabase = [QuestDatabase new];
    _skillDatabase = [SkillDatabase new];
}

- (void)dealloc
{
    [self destroy:_enemyDatabase];
    [self destroy:_itemDatabase];
    [self destroy:_npcDatabase];
    [self destroy:_playerDatabase];
    [self destroy:_questDatabase];
    [self destroy:_skillDatabase];
    
    [super dealloc];
}

@end
