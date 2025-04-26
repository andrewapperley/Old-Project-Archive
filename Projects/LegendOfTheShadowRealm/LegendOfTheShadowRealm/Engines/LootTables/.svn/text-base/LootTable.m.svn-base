//
//  LootTable.m
//  LegendOfTheShadowRealm
//
//  Created by Jeremy Fuellert on 2013-01-28.
//
//
//  This class controls any loot that may be given from a specific zone.
//  Any current items the player has are ignored to dismiss duplicates.
//

#import "BattleSystem.h"
#import "Database.h"
#import "LootTable.h"
#import "StringUtil.h"

@implementation LootTable

- (void)loadTableForZone:(uint)lzone
{    
    zone = lzone;    
    [self refresh];   
}

//Remove any items that the player currently has
- (void)refresh
{
    if(lootTableItems)
        [self destroy:lootTableItems];
    
    lootTableItems = [[NSMutableArray alloc] initWithArray:[itemDatabase uidsByZone:zone]];
    
    NSMutableArray *playerItems = [NSMutableArray new];
    [playerItems addObjectsFromArray:[playerDatabase inventoryItems]];
    [playerItems addObjectsFromArray:[playerDatabase equippedItems]];
    
    NSMutableArray *itemsToRemove = [NSMutableArray new];
        
    if(lootTableItems && lootTableItems.count > 0 && playerItems && playerItems.count > 0)
    {
        for(NSString *itemNumber in lootTableItems)
        {
            for(NSString *playerItemNumber in playerItems)
            {                
                playerItemNumber = [StringUtil trimString:playerItemNumber toIndexString:@"="];
                
                if([itemNumber longLongValue] == [playerItemNumber longLongValue])
                {
                    [itemsToRemove addObject:itemNumber];
                }
            }
        }
    }
    
    if(itemsToRemove && itemsToRemove.count > 0)
        [lootTableItems removeObjectsInArray:itemsToRemove];
    
    [self destroy:playerItems];
    [self destroy: itemsToRemove];
}

/*
 * Item Rewarding
 */
- (void)tryForReward
{        
    BOOL canReward = (uint)arc4random_uniform(100) < LOOT_TABLE_DROP_CHANCE;
    
    if(canReward && lootTableItems && lootTableItems.count > 0)
    {        
        NSNumber *reward = [lootTableItems objectAtIndex:arc4random_uniform(lootTableItems.count)];
        
        [self sendEvent:EVENT_ITEM_NOTIFICATION_OBTAINED andObject:reward];
        [self addRewardedItemToPlayerDatabase:[reward stringValue]];
        [lootTableItems removeObject:reward];
    }
}

/*
 * This handles whether or not to automatically equip the new item on the player or to put it in the inventory.
 * Knowing if an item is equipped is determined by searching for equipped items and matching the 'uid's to a slot.
 * If a slot is empty then the item, if it's a matched slot, will be put into place.
 */
- (void)addRewardedItemToPlayerDatabase:(NSString *)item
{
    NSMutableArray *equippedItems = [NSMutableArray arrayWithArray:[playerDatabase equippedItems]];
    BOOL canEquipInEmptySlot = TRUE;
    int itemType = [itemDatabase typeByUid:[item longLongValue]];
    
    if(equippedItems && equippedItems.count > 0)
    {
        for(NSString *equippedItem in equippedItems)
        {
            equippedItem = [StringUtil trimString:equippedItem toIndexString:@"="];
            
            int equippedItemType = [itemDatabase typeByUid:[equippedItem longLongValue]];
            if(itemType == equippedItemType)
            {
                canEquipInEmptySlot = FALSE;
                break;
            }
        }
    }
    
    //Add item level
    int playerLevel = [playerDatabase level];
    NSString *currentZone = [mapDatabase zoneFromRowId:[[[Shell.shell battleSystem] centerTile] zoneName]];
    int zoneDiff = [mapDatabase levelDifferenceFromZone:currentZone];
    int itemLevel = playerLevel + zoneDiff;
    
    //Make object with level to save to database
    NSMutableString *itemString = [NSMutableString stringWithString:item];
    [itemString appendFormat:@"=%d", itemLevel];
    
    //Add to empty equipment slot
    if(canEquipInEmptySlot)
    {
        [equippedItems addObject:itemString];
        [playerDatabase setEquippedItems:equippedItems];
    } else {
        
        //Add to inventory
        NSMutableArray *inventoryItems = [NSMutableArray arrayWithArray:[playerDatabase inventoryItems]];
        [inventoryItems addObject:itemString];
        [playerDatabase setInventoryItems:inventoryItems];
    }

    //Send Quest Event Notification
    [self sendEvent:EVENT_QUEST_LOOT andObject:item];
}

- (void)dealloc
{
    [self destroy:lootTableItems];
    [super dealloc];
}

@end
