//
//  MainGUI.m
//  LegendOfTheShadowRealm
//
//  Created by Andrew Apperley on 2012-11-17.
//
//

#import "BaseImage.h"
#import "CirclePad.h"
#import "Constants.h"
#import "Database.h"
#import "DayNightTransition.h"
#import "MainGUI.h"
#import "InteractionButton.h"
#import "ItemNotification.h"
#import "ResourceBar.h"
#import "ZoneNotification.h"
#import "NPCDialogView.h"

@implementation MainGUI
@synthesize dayNight;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self){
        [self initGUI];
        [self addListener:EVENT_NOTIFICATION_ZONE_ENETERED andSel:@selector(onShowZoneNotification:)];
        [self addListener:EVENT_PLAYER_HEALTH_GAIN andSel:@selector(healthBarNotification:)];
        [self addListener:EVENT_PLAYER_HEALTH_LOSS andSel:@selector(healthBarNotification:)];
    }
    return self;
}

- (void)initGUI
{
    //Circle pad
    circlePad = [[CirclePad alloc] initWithFrame:CGRectMake(15, SCREEN_HEIGHT - 125, 110, 110)];
    
    //Action button
    actionButton = [[InteractionButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 100, SCREEN_HEIGHT - 100 , 50, 50)];
    
    //Zone notification
    zoneNotification = [[ZoneNotification alloc] initWithFrame:CGRectMake(0, 135, self._width, 50)];
    
    //Item notification
    itemNotification = [[ItemNotification alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 4, 0, SCREEN_WIDTH / 2, 60)];
        
    
    //Health bar
    healthBar = [[ResourceBar alloc] initWithFrame:CGRectMake(-20, 5, 150, 50) andMinValue:0.0f andMaxValue:[playerDatabase health_max] andCurrenValue:[playerDatabase health] andBackgroundImage:ASSET_VISUAL_MAIN_GUI_PLAYER_HEALH_BAR_BACKGROUND andFillImage:ASSET_VISUAL_MAIN_GUI_PLAYER_HEALH_BAR_FILL andFrameImage:ASSET_VISUAL_MAIN_GUI_PLAYER_HEALH_BAR_FRAME];
    //fog of war / day time shadow
    
    NSString *shadowImageName;
    //determine which version of the shadow to use
    
    if(SCREEN_WIDTH == RETINA_TALL_SCREEN_WIDTH){
        shadowImageName = BackgroundImageRetinaTall(ASSET_VISUAL_BACKGROUND_SHADOW);
    } else {
        shadowImageName = [ASSET_VISUAL_BACKGROUND_SHADOW autorelease];
    }
    UIImage *shadowImage = [[UIImage imageNamed:shadowImageName] autorelease];
    //
    self.dayNight = [[DayNightTransition alloc] initWithFrame:self.frame andImage:shadowImage];
    
    dialogView = [[NPCDialogView alloc] init];
    
    [self addSubview:self.dayNight];
    [self addSubview:dialogView];
    [self addSubview:actionButton];
    [self addSubview:circlePad];
    [self addSubview:zoneNotification];
    [self addSubview:healthBar];
    [self addSubview:itemNotification];
}

/*
 * Zone notifications
 */
- (void)onShowZoneNotification:(NSNotification *)notification
{
    [self showZoneNotification:(NSString *)[notification object]];
}

- (void)showZoneNotification:(NSString *)zone
{
    [zoneNotification showNotification:zone];
}

/*
 * Health bar
 */
- (void)healthBarNotification:(NSNotification *)notification
{
    healthBar.currentValue = playerDatabase.health;

}

- (void)dealloc
{
    [self destroyAndRemove:dialogView];
    [self destroyAndRemove:self.dayNight];
    [self destroyAndRemove:actionButton];
    [self destroyAndRemove:circlePad];
    [self destroyAndRemove:itemNotification];
    [self destroyAndRemove:zoneNotification];
    [self destroyAndRemove:healthBar];
    
    [super dealloc];
}
@end
