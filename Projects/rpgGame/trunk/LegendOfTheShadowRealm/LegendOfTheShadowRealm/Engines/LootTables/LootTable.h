//
//  LootTable.h
//  LegendOfTheShadowRealm
//
//  Created by Jeremy Fuellert on 2013-01-28.
//
//

#import "BaseObject.h"

@interface LootTable : BaseObject
{
    @private
    NSMutableArray *lootTableItems;
    uint zone;
}

- (void)loadTableForZone:(uint)lzone;
- (void)tryForReward;
- (void)addRewardedItemToPlayerDatabase:(NSString *)item;

//Refresh is used to sync the current loot table with player database items
- (void)refresh;

@end
