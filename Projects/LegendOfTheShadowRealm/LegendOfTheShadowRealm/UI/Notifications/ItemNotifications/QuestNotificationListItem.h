//
//  QuestNotificationListItem.h
//  LegendOfTheShadowRealm
//
//  Created by Jeremy Fuellert on 2013-02-12.
//
//

#import "BaseView.h"

@class BaseImage;

@interface QuestNotificationListItem : BaseView<UIGestureRecognizerDelegate>
{
    BaseImage *rewardBackground;
    NSArray *rewards;
}

@property (nonatomic, readonly) unsigned long long uid;

- (id)initWithFrame:(CGRect)frame andUid:(unsigned long long)luid;

@end
