//
//  QuestDatabase.h
//  LegendOfTheShadowRealm
//
//  Created by Jeremy Fuellert on 2013-02-12.
//
//

#import "DatabaseBase.h"

@interface QuestDatabase : DatabaseBase

//Quest Retrieval
- (NSDictionary *)questByUid:(unsigned long long)uid;
- (NSMutableArray *)questsByUidArray:(NSArray *)luidArray;

//Name
- (NSString *)nameByUid:(unsigned long long)uid;

//Number of Items
- (void)setNumberOfItems:(int)_numberOfItems;
- (int)numberOfItemsByUid:(unsigned long long)uid;

//Number of Items Required
- (int)numberOfItemsRequiredByUid:(unsigned long long)uid;

//Items
- (unsigned long long)itemRequiredUidByUid:(unsigned long long)uid;

//Exp Gained
- (float)expGainedByUid:(unsigned long long)uid;

//Reward Items
- (NSArray *)rewardItemsByUid:(unsigned long long)uid;

//Chain name
- (NSString *)chainNameByUid:(unsigned long long)uid;

@end
