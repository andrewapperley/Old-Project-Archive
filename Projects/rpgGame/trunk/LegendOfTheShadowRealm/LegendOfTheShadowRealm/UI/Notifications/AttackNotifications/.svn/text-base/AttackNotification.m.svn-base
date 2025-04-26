//
//  AttackNotification.m
//  LegendOfTheShadowRealm
//
//  Created by Jeremy Fuellert on 2013-01-03.
//
//

#import "AttackNotification.h"
#import "BaseLabel.h"

#define HEAL_COLOR [UIColor greenColor]
#define DAMAGE_TAKEN_COLOR [UIColor redColor]
#define DAMAGE_DEALT_COLOR [UIColor whiteColor]
#define MISS_COLOR [UIColor yellowColor]

@implementation AttackNotification

- (id)initWithFrame:(CGRect)frame andText:(NSString *)ltext andType:(int)type
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self.clipsToBounds = NO;
        self.frame = frame;
        self._y -= 15;
        text = [ltext retain];
        [self createTextField:type];
        [self animateTextIn];
    }
    return self;
}

- (void)createTextField:(int)type
{
    BaseLabel *label = [[BaseLabel alloc]initWithFrame:self.frame];
    label._width = self.frame.size.width * 2;
    label._x = - self.frame.size.width / 2;
    label.clipsToBounds = NO;
    label.font = [UIFont fontWithName:FONT_DEFAULT size:14];
    label.textAlignment = UITextAlignmentCenter;
    
    switch (type)
    {
        case Heal:
            label.textColor = HEAL_COLOR;
            label.text = [NSString stringWithFormat:@"+%@", text];
            break;
        case DamageTaken:
            label.textColor = DAMAGE_TAKEN_COLOR;
            label.text = [NSString stringWithFormat:@"-%@", text];
            break;
        case DamageDealt:
            label.textColor = DAMAGE_DEALT_COLOR;
            label.text = text;
            break;
        case Miss:
            label.font = [UIFont fontWithName:FONT_DEFAULT size:5];
            label.textColor = MISS_COLOR;
            label.text = text;
        default:
            break;
    }
    
    [self addSubview:label];
	[self destroy:label];
}

- (void)animateTextIn
{
    [UIView animateWithDuration:0.5f animations:^{
        self.alpha = 0.0f;
        self._y -= 20;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)dealloc
{
    [self destroy:text];
    [super dealloc];
}

@end
