//
//  MainGUI.h
//  LegendOfTheShadowRealm
//
//  Created by Andrew Apperley on 2012-11-17.
//
//

#import "BaseView.h"

@class CirclePad;
@class InteractionButton;
@class ItemNotification;
@class ResourceBar;
@class ZoneNotification;
@class DayNightTransition;
@class NPCDialogView;

@interface MainGUI : BaseView
{    
    CirclePad *circlePad;
    InteractionButton *actionButton;
    ResourceBar *healthBar;
    NPCDialogView *dialogView;
    
    //Notifications
    ZoneNotification *zoneNotification;
    ItemNotification *itemNotification;
}

@property(nonatomic,retain)DayNightTransition *dayNight;

- (void)showZoneNotification:(NSString *)zone;

@end
