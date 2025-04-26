//
//  Quest.m
//  LegendOfTheShadowRealm
//
//  Created by Jeremy Fuellert on 2013-02-12.
//
//

#import "BattleSystem.h"
#import "LootTable.h"
#import "Database.h"
#import "Quest.h"

@implementation Quest

- (id)init
{
    self = [super init];
    if(self)
    {
        //Refresh Event
        [self addListener:EVENT_QUESTS_REFRESH andSel:@selector(refresh)];
        
        //Quest Events
        [self addListener:EVENT_QUEST_DISCOVER andSel:@selector(questEvent:)];
        [self addListener:EVENT_QUEST_KILL andSel:@selector(questEvent:)];
        [self addListener:EVENT_QUEST_LOOT andSel:@selector(questEvent:)];
        [self addListener:EVENT_QUEST_TALK andSel:@selector(questEvent:)];
        
        [self refresh];
    }
    return self;
}

/*
 * Refresh
 */
- (void)refresh
{
    if(quests)
        [self destroy:quests];
    
    quests = [[NSMutableArray alloc] initWithArray:[playerDatabase activeQuests]];
}

/*
 * Quest Event Base Retrieval
 */
- (void)questEvent:(NSNotification *)event
{
    unsigned long long uid = [(NSString *)[event object] longLongValue];
    
    BOOL questCompleted = FALSE;
    
    NSMutableArray *completedQuests = [[NSMutableArray alloc] initWithArray:[playerDatabase completedQuests]];
    
    if(quests && quests.count > 0)
    {        
        for(NSString *lquest in quests)
        {
            NSDictionary *quest = [[questDatabase questByUid:[lquest longLongValue]] retain];
            
            if(uid == [(NSNumber *)[quest objectForKey:@"itemUid"] unsignedLongLongValue])
            {                
                //If there is a match to a current quest then increment it
                int currentItems = [[(NSNumber *)quest valueForKey:@"numItems"] intValue];
                int maxItems = [[(NSNumber *)quest valueForKey:@"numItemsRequired"] intValue];
                
                currentItems++;
                
                [questDatabase setNumberOfItems:MIN(currentItems, maxItems)];
                
                //If the quest is complete then send an event to MainGUI and update player quests
                if(currentItems >= maxItems)
                {
                    questCompleted = TRUE;
                    
                    NSNumber *completedQuest = (NSNumber *)[quest objectForKey:@"uid"];
                        
                    [completedQuests addObject:(NSString *)[completedQuest stringValue]];
                    
                    //Add reward object to player database if found
                    if([quest objectForKey:@"rewards"] && ![[quest objectForKey:@"rewards"] isEqual:[NSNull null]])
                    {
                        NSArray *rewards = [(NSArray *)[quest objectForKey:@"rewards"] retain];
                        if(rewards && rewards.count > 0)
                        {
                            for(NSString *reward in rewards)
                            {
                                [[[Shell.shell battleSystem] lootTable] addRewardedItemToPlayerDatabase:reward];
                            }
                        }
                        
                        [self destroy:rewards];
                    }
                    
                    //Transer completed quest from active to completed player quests
                    [playerDatabase setCompletedQuests:completedQuests];
                                        
                    //Dispatch quest completion event
                    [self sendEvent:EVENT_QUEST_NOTIFICATION_COMPLETE andObject:completedQuest];
                }
            }
            
            [self destroy:quest];
        }
    }
    
    if(completedQuests && completedQuests.count > 0)
        [quests removeObjectsInArray:completedQuests];
        
    if(questCompleted)
        [playerDatabase setActiveQuests:quests];
    
    [self destroy:completedQuests];
}

- (void)dealloc
{
    [self destroy:quests];
    [super dealloc];
}

@end
