//
//  EventConstants.h
//  LegendOfTheShadowRealm
//
//  Created by Andrew Apperley on 2012-11-30.
//
//

@interface EventConstants

/*
 * All event constants should be created here. We have to add a prefix of 'EVENT' to each event constant to 
 * determine that it is only used for holding an EventCenter key. We'd also have to make sure to never duplicate a 
 * contant value so we should camel-case each constant key with it's written constant. We should try to keep to a 
 * consistant naming convention such as:
 *
 * EVENT_(class)_(interaction)_(interaction outcome) @"(class)(interaction)(interaction outcome)"
 *
 */


/*
 * Buttons
 */
#define EVENT_BUTTON_CLICKED                        @"eventButtonClicked"
/*
 * Shell
 */
#define EVENT_SHELL_LOAD_COMPLETE                   @"shellLoadComplete"
#define EVENT_SLASHSCREEN_UP                        @"splashScreenUp"

/*
 * Circle Pad
 */
#define EVENT_CIRCLEPAD_MOVE_START                  @"circlePadMoveStart"
#define EVENT_CIRCLEPAD_MOVE_STOP                   @"crclePadMoveStop"

/*
 * Notifications
 */
#define EVENT_NOTIFICATION_ZONE_ENETERED            @"notificationZoneEntered"

/*
 * Animations
 */
#define EVENT_PLAYER_ANIMATION_START                @"playerAnimationStart"
#define EVENT_PLAYER_ANIMATION_STOP                 @"playerAnimationStop"
    
#define EVENT_NPC_ANIMATION_MOVED                   @"npcAnimationMoved"
#define EVENT_ENEMY_ANIMATION_MOVED                 @"enemyAnimationMoved"

#define EVENT_NPC_CREATE                            @"npcCreate"
#define EVENT_ENEMY_CREATE                          @"enemyCreate"

/*
 * Battle System
 */
#define EVENT_BATTLESYSTEM_ZONE_NEW                 @"battleSystemZoneNew"
#define EVENT_BATTLESYSTEM_ENEMY_ATTACK             @"battleSystemEnemyAttack"
#define EVENT_BATTLESYSTEM_ENEMY_KILL               @"battleSystemEnemyKill"
#define EVENT_BATTLESYSTEM_PLAYER_ATTACK            @"battleSystemPlayerAttack"

/*
 * Notifications
 */
//Item / Quest Notifications
#define EVENT_ITEM_NOTIFICATION_OBTAINED            @"itemNotificationObtained"
#define EVENT_ITEM_NOTIFICATION_HIDE                @"itemNotificationHide"
#define EVENT_QUEST_NOTIFICATION_COMPLETE           @"questNotificationComplete"
#define EVENT_QUEST_NOTIFICATION_HIDE               @"questNotificationHide"

//Enemy
#define EVENT_ENEMY_HEALTH_LOSS                     @"enemyHealthLoss"

//Map
#define EVENT_MAP_TILE_BUFFER                       @"mapTileBuffer"
#define EVENT_MAP_TILE_HOUSE_INTERACTION            @"mapTileHouse"
#define EVENT_MAP_TILE_HOUSE_REVERSE_INTERACTION    @"mapTileHouseReverse"
#define EVENT_MAP_LOADED                            @"mapNewLoaded"

/*
 * Player Events
 */
#define EVENT_PLAYER_HEALTH_LOSS                    @"playerHealthLoss"
#define EVENT_PLAYER_HEALTH_GAIN                    @"playerHealthGain"
#define EVENT_PLAYER_REFRESH_SKILLS_ACTIVE          @"playerRefreshSkillsActive"
#define EVENT_PLAYER_REFRESH_PASSIVE_REGEN          @"playerRefreshPassiveRegen"
#define EVENT_NPC_DONE_CONVO                        @"npcEndConvo"
#define EVENT_NPC_START_CONVO                       @"npcStartConvo"
#define EVENT_INTERACT_WITH_NPC                     @"interactWithNPC"

/*
 * Quest Events
 */
#define EVENT_QUESTS_REFRESH                        @"questsRefresh"

#define EVENT_QUEST_LOOT                            @"questLoot"
#define EVENT_QUEST_KILL                            @"questKill"
#define EVENT_QUEST_TALK                            @"questTalk"
#define EVENT_QUEST_DISCOVER                        @"questDiscover"


/*
 * Views
 */
#define EVENT_VIEW_READY                            @"eventIsReady"
#define EVENT_SHOW_OUT                              @"eventShowOut"
#define EVENT_CLOSE_DIALOG                          @"eventCloseDialog"
@end
