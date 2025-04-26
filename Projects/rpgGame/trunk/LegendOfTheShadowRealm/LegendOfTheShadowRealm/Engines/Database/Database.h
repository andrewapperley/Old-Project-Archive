//
//  Database.h
//  LegendOfTheShadowRealm
//
//  Created by Jeremy Fuellert on 2012-11-24.
//
//

#import "BaseObject.h"
#import "EnemyDatabase.h"
#import "ItemDatabase.h"
#import "MapDatabase.h"
#import "NPCDatabase.h"
#import "PlayerDatabase.h"
#import "QuestDatabase.h"
#import "SkillDatabase.h"

#define enemyDatabase [[Database database] _enemyDatabase]
#define itemDatabase [[Database database] _itemDatabase]
#define mapDatabase [[Database database] _mapDatabase]
#define npcDatabase [[Database database] _npcDatabase]
#define playerDatabase [[Database database] _playerDatabase]
#define questDatabase [[Database database] _questDatabase]
#define skillDatabase [[Database database] _skillDatabase]

@interface Database : BaseObject

@property(nonatomic, retain)EnemyDatabase *_enemyDatabase;
@property(nonatomic, retain)ItemDatabase *_itemDatabase;
@property(nonatomic, retain)MapDatabase *_mapDatabase;
@property(nonatomic, retain)NPCDatabase *_npcDatabase;
@property(nonatomic, retain)PlayerDatabase *_playerDatabase;
@property(nonatomic, retain)QuestDatabase *_questDatabase;
@property(nonatomic, retain)SkillDatabase *_skillDatabase;

+ (Database *)database;

@end