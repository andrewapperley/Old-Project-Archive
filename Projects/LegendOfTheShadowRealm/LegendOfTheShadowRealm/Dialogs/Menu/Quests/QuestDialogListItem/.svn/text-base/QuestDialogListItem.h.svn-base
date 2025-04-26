//
//  QuestDialogListItem.h
//  LegendOfTheShadowRealm
//
//  Created by Jeremy Fuellert on 2013-03-10.
//
//

#import "BaseButton.h"

@class BaseButton;
@class BaseLabel;

@interface QuestDialogListItem : BaseButton
{
    @private
    BaseLabel *label;
    BaseView *strikeThrough;
}

@property (nonatomic, assign) BOOL isComplete;
@property (nonatomic, assign) BOOL isSelected;
@property (nonatomic, readonly) unsigned long long questId;

- (id)initWithFrame:(CGRect)frame andQuestUid:(unsigned long long)uid anIsComplete:(BOOL)lisComplete;

@end
