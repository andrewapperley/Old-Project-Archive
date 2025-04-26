//
//  Constants.h
//  LegendOfTheShadowRealm
//
//  Created by Jeremy Fuellert on 2012-11-29.
//
//

//General Timings
#define GENERAL_TIMING_0_1 0.1f 

//Screen size
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.height
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.width

//Screen Sizes
#define RETINA_TALL_SCREEN_WIDTH 568


/*
 * Tile Data
 */

//Tile size
#define TILE_WIDTH  48
#define TILE_HEIGHT TILE_WIDTH

//Tile buffer (number of tiles in buffer)
#define TILE_SCREEN_BUFFER 4

//Tiles per screen
#define TILE_SCREEN_HEIGHT ceilf(SCREEN_HEIGHT / TILE_HEIGHT)
#define TILE_SCREEN_WIDTH ceilf(SCREEN_WIDTH / TILE_WIDTH)
#define TILE_SCREEN_AMOUNT ceilf((TILE_SCREEN_HEIGHT + TILE_SCREEN_BUFFER) * (TILE_SCREEN_WIDTH + TILE_SCREEN_BUFFER))

//Tile Map Saving
#define CENTER_TILE_OFFSET_X 11
#define CENTER_TILE_OFFSET_Y 7
//Movement
#define MAX_VELOCITY        2
#define VELOCITY_DIVISION   40

/*
 * Maps
 */
#define MAP_ZONE_WORLD @"testMap"
#define MAP_ZONE_DUNGEON_ONE @"testMap2"

/*
 * Directions
 */
#define DIRECTION_COUNT 8

enum Direction
{
    NorthWest = 1,
    North = 2,
    NorthEast = 3,
    West = 4,
    Idle = 5,
    East = 6,
    SouthWest = 7,
    South = 8,
    SouthEast = 9
};

/*
 * Layers
 */
#define GROUND      @"Ground"
#define COLLISION   @"Collision"
#define FOREGROUND  @"ForeGround"
#define OBJECTS     @"Objects"
#define NPC         @"NPCS"
#define ANIMATED    @"animatedTiles"
#define HASH        @"Hashes"
#define ZONE        @"Zone"

/*
 * Image Object Strings
 */
#define Enemy_NPC_Image($prefix, $id, $direction, $action, $state) \
    [NSString stringWithFormat:@"%@_%lld_%d_%@_%d", $prefix, $id, $direction, $action, $state]

#define Player_Image($prefix, $id, $weapon, $direction, $action, $state) \
    [NSString stringWithFormat:@"%@_%lld_%@_%d_%@_%d", $prefix, $id, $weapon, $direction, $action, $state]

#define Item_Image($itemType, $id) \
    [NSString stringWithFormat:@"%d_%lld", $itemType, $id]

#define BackgroundImageRetinaTall($name) \
    [NSString stringWithFormat:@"%@-568h.png",$name]

//Image Prefixes
#define PREFIX_PLAYER_IMAGE         @"PlayerImage"
#define PREFIX_NPC_IMAGE            @"NPCImage"
#define PREFIX_ENEMY_IMAGE          @"EnemyImage"

//Object Buffer
#define BUFFER 4

//States
#define ACTION_WALKING              @"Walking"
#define ACTION_RUNNING              @"Running"
#define ACTION_IDLE                 @"Idle"
#define ACTION_ATTACK               @"Attacking"

//Sprite animation duration
#define SPRITE_ANIMATION_WALK_DURATION      0.1f
#define SPRITE_ANIMATION_RUN_DURATION       0.05f

/*
 * Battle System
 */
#define BATTLE_SYSTEM_SPEED_SCALE           0.2f
#define BATTLE_SYSTEM_BASE_MISS_CHANCE      5.0f
#define BATTLE_SYSTEM_GEAR_SCALE            3.5f
#define BATTLE_SYSTEM_PLAYER_ARMOR_SCALE    2.0f
#define BATTLE_SYSTEM_STRENGTH_SCALE        1.5f
#define BATTLE_SYSTEM_MONSTER_ARMOR_SCALE   4.0f

#define BATTLE_SYSTEM_SPAWN_PERCENT     10
#define BATTLE_SYSTEM_SPAWN_INCREMENT   15

//Player position
#define PLAYER_POINT CGPointMake(floor((TILE_SCREEN_WIDTH * TILE_WIDTH) - TILE_WIDTH) / 2, floor((TILE_SCREEN_HEIGHT * TILE_HEIGHT) - TILE_HEIGHT) / 2)

//Player passive health base regeneration
#define PLAYER_PASSIVE_HEALTH_REGENERATION  0.05f

/*
 * Interaction
 */
#define INTERACTION_NPC_COMMUNICATE_RADIUS      3       //Radius in tiles

/*
 * Skills
 */
#define SKILLS_ACTIVE_MAX_SLOTS     3
#define SKILLS_ACTIVE_MAX_SKILLS    22
#define SKILLS_PASSIVE_MAX_SLOTS    5
#define SKILLS_PASSIVE_MAX_SKILLS   22

/*
 * Loot Table
 */
#define LOOT_TABLE_DROP_CHANCE 15.0f

/*
 * Dialog Handling
 */
enum dialog_direction {
    UP = 0,
    RIGHT = 1,
    DOWN = 2,
    LEFT = 3
    };







