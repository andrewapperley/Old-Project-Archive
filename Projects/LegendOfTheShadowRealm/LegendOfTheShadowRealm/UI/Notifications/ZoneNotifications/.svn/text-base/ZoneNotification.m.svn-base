//
//  ZoneNotification.m
//  LegendOfTheShadowRealm
//
//  Created by Jeremy Fuellert on 2013-01-08.
//
//

#import "BaseLabel.h"
#import "ZoneNotification.h"

@implementation ZoneNotification

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = NO;
        self.alpha = 0.0f;
        self.userInteractionEnabled = NO;
        [self createTextField];
    }
    return self;
}

- (void)createTextField
{
    label = [[BaseLabel alloc]initWithFrame:self.frame];
    label._width = self.frame.size.width;
    label._height = self.frame.size.height;
    label.font = [UIFont fontWithName:FONT_DEFAULT size:20];
    label.textAlignment = UITextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.shadowColor = [UIColor blackColor];
    label.shadowOffset = CGSizeMake(1.0, 1.0);
    
    [self addSubview:label];
}

- (void)showNotification:(NSString *)message
{
    label.text = message;
    
    [UIView animateWithDuration:1.0f animations:^{
        self.alpha = 1.0f;
    } completion:^(BOOL finished) {
        [self showOutNotification];
    }];
}

- (void)showOutNotification
{
    [UIView animateWithDuration:1.0f delay:2.0f options:UIViewAnimationCurveLinear animations:^{
        self.alpha = 0.0f;
    } completion:^(BOOL finished) {}];
}

- (void)dealloc
{
    [self destroy:label];
    [super dealloc];
}

@end
