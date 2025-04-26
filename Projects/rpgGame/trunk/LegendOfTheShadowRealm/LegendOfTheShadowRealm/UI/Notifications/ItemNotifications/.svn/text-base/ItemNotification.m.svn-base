//
//  ItemNotification.m
//  LegendOfTheShadowRealm
//
//  Created by Jeremy Fuellert on 2013-01-08.
//
//

#import "ItemNotification.h"
#import "ItemNotificationListItem.h"
#import "QuestNotificationListItem.h"
#import "SelectorQueue.h"

@implementation ItemNotification

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        queue = [[SelectorQueue alloc] initWithDelegate:self];
        
        //Item Notifications
        [self addListener:EVENT_ITEM_NOTIFICATION_OBTAINED andSel:@selector(onItemObtained:)];
        [self addListener:EVENT_ITEM_NOTIFICATION_HIDE andSel:@selector(onShowOutItemObtained:)];
        
        //Quest Notifications
        [self addListener:EVENT_QUEST_NOTIFICATION_COMPLETE andSel:@selector(onQuestComplete:)];
        [self addListener:EVENT_QUEST_NOTIFICATION_HIDE andSel:@selector(onShowOutItemObtained:)];

    }
    return self;
}

- (void)onItemObtained:(NSNotification *)item
{
    unsigned long long uid = [(NSNumber *)[item object] unsignedLongLongValue];
    [self addItemToList:uid andType:ItemNotificationType];
}

- (void)onQuestComplete:(NSNotification *)lquest
{
    unsigned long long uid = [(NSNumber *)[lquest object] unsignedLongLongValue];
    [self addItemToList:uid andType:QuestNotificationType];
}

/*
 * UI Handling
 */
- (void)addItemToList:(unsigned long long)uid andType:(int)type
{
    BaseView *item = nil;
    
    CGRect frame = CGRectMake(0, 0, self._width, 60);
    
    switch (type) {
        case ItemNotificationType:
            item = [[ItemNotificationListItem alloc] initWithFrame:frame andUid:uid];
            break;
        case QuestNotificationType:
            item = [[QuestNotificationListItem alloc] initWithFrame:frame andUid:uid];
            break;
    }
    
    item.alpha = 0.0f;
    item._y = - item._height;
    [self addSubview:item];
    
    [queue addSelectorToQueue:@selector(showNextItem:) andArg:item];
    [self destroy:item];
    
    if(!queueIsRunning)
    {
        [queue runQueue];
    }
}

- (void)showNextItem:(BaseView *)litem
{
    queueIsRunning = TRUE;
    isHiding = FALSE;
    
    BaseView *item = [litem retain];
    
    //Show in
    [UIView animateWithDuration:0.75f animations:^{
        item.alpha = 1.0f;
        item._y = - 1;
    }completion:^(BOOL finished) {
        [self performSelector:@selector(showOutItem:) withObject:item afterDelay:5.0f];
    }];
    [self destroy:item];
}

- (void)onShowOutItemObtained:(NSNotification *)notification
{
    [self showOutItem:(BaseView *)notification.object];
}

- (void)showOutItem:(BaseView *)litem
{    
    if(!isHiding)
    {
        isHiding = TRUE;
        
        BaseView *item = [litem retain];
        
        [UIView animateWithDuration:0.75f animations:^{
            item.alpha = 0.0f;
            item._y = - item._height;
        } completion:^(BOOL finished) {
            [self destroyAndRemove:item];
            queueIsRunning = FALSE;
            
            [queue runQueue];
        }];
    }
}

- (void)dealloc
{
    [self destroy:queue];
    [super dealloc];
}

@end
