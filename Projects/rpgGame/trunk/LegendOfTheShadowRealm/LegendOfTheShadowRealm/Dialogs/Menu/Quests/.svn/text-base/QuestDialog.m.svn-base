//
//  QuestDialog.m
//  LegendOfTheShadowRealm
//
//  Created by Jeremy Fuellert on 2013-03-10.
//
//

#import "BaseLabel.h"
#import "BaseScrollView.h"
#import "Database.h"
#import <QuartzCore/QuartzCore.h>
#import "QuestDialog.h"
#import "QuestDialogInfoItem.h"
#import "QuestDialogListItem.h"
#import "ScrollSelectionList.h"
#import "UIConstants.h"

#define LIST_WIDTH 200

@implementation QuestDialog

static unsigned long long currentQuestId = 0ll;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self createBackground];
        [self createQuestList];
        [self createQuestInfo];
    }
    return self;
}

/*
 * Background
 */
- (void)createBackground
{
    self.backgroundColor = RGB(38.0, 38.0, 38.0);
    self.layer.cornerRadius = 5.0;
}

/*
 * Quest list
 */
- (void)createQuestList
{
    //Title
    BaseLabel *label = [BaseLabel new];
    label._height = 25;
    label._width = LIST_WIDTH;
    label.font = [UIFont fontWithName:FONT_DEFAULT size:16];
    label.textColor = [UIColor whiteColor];
    label.text = @"Quests";
    label.textAlignment = UITextAlignmentCenter;

    
    //List Items    
    NSArray *completedQuests = playerDatabase.completedQuests;
    NSArray *activeQuests = playerDatabase.activeQuests;
    NSMutableArray *listItems = [[NSMutableArray alloc] initWithCapacity:completedQuests.count + activeQuests.count];
    
    float listItemHeight = 25.0f;
    
    for(uint i = 0; i < completedQuests.count; i++)
    {
        QuestDialogListItem *listItem = [[QuestDialogListItem alloc] initWithFrame:CGRectMake(0, 0, self._width, listItemHeight) andQuestUid:[(NSString *)[completedQuests objectAtIndex:i] longLongValue] anIsComplete:TRUE];
        [listItem addTarget:self action:@selector(onQuestSelected:) forControlEvents:UIControlEventTouchUpInside];
        [listItems addObject:listItem];
        [self destroy:listItem];
    }
    
    for(uint i = 0; i < activeQuests.count; i++)
    {
        QuestDialogListItem *listItem = [[QuestDialogListItem alloc] initWithFrame:CGRectMake(0, 0, self._width, listItemHeight) andQuestUid:[(NSString *)[activeQuests objectAtIndex:i] longLongValue] anIsComplete:FALSE];
        [listItem addTarget:self action:@selector(onQuestSelected:) forControlEvents:UIControlEventTouchUpInside];
        [listItems addObject:listItem];
        [self destroy:listItem];
    }
    
    scrollList = [[ScrollSelectionList alloc] initWithFrame:CGRectMake(0, label._y + label._height, LIST_WIDTH, 500) andScrollDirection:VERTICAL andListItems:listItems andItemSpacing:1];
        
    [self addSubview:label];
    [self addSubview:scrollList];
    
    [self destroy:label];
    [self destroy:listItems];
}

/*
 * Quest Info
 */
- (void)createQuestInfo
{
    float verticalPadding = 10;
    questInfoItem = [[QuestDialogInfoItem alloc] initWithFrame:CGRectMake(LIST_WIDTH, verticalPadding, self._width - LIST_WIDTH, self._height - (verticalPadding * 2))];
    [self addSubview:questInfoItem];
}

/*
 * Actions
 */
- (void)onQuestSelected:(id)sender
{
    QuestDialogListItem *item = [sender retain];
    
    if(item.questId != currentQuestId)
    {
        currentQuestId = item.questId;
        [questInfoItem setQuestUid:currentQuestId];
    }
    
    [self destroy:item];
}

- (void)dealloc
{
    [self destroy:scrollList];
    [super dealloc];
}

@end
