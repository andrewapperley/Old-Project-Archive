//
//  InteractionButton.m
//  LegendOfTheShadowRealm
//
//  Created by Andrew Apperley on 2012-12-28.
//
//

#import "InteractionButton.h"
#import "Database.h"
#import "Shell.h"
#import "InteractionLayer.h"
#import "Player.h"
#import <QuartzCore/QuartzCore.h>

@implementation InteractionButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        self.layer.borderColor = [UIColor whiteColor].CGColor;
        self.layer.borderWidth = 1;
        self.alpha = 0.7f;
        self.backgroundColor = [UIColor blackColor];
        [self initTouchEvents];
    }
    return self;
}

- (void)initTouchEvents
{
    [self addTarget:self action:@selector(onUseActionButton:) forControlEvents:UIControlEventTouchDown];
    
}

- (void)onUseActionButton:(UIEvent *)event
{//will have to get these values from database and what skill is activated
    
    [self sendEvent:EVENT_BATTLESYSTEM_PLAYER_ATTACK];
    [self sendEvent:EVENT_INTERACT_WITH_NPC];
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}

- (void) touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}

@end
