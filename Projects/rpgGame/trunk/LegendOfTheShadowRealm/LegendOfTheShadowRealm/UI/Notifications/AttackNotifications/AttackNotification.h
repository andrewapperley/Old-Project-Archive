//
//  AttackNotification.h
//  LegendOfTheShadowRealm
//
//  Created by Jeremy Fuellert on 2013-01-03.
//
//

#import "BaseView.h"

enum AttackNotificationType {
    Heal,
    DamageTaken,
    DamageDealt,
    Miss
};

@interface AttackNotification : BaseView
{
    @protected
    NSString *text;
}

- (id)initWithFrame:(CGRect)frame andText:(NSString *)text andType:(int)type;

@end
