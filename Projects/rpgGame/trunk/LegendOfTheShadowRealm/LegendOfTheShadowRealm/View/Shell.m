//
//  Shell.m
//  LegendOfTheShadowRealm
//
//  Created by Andrew Apperley on 2012-11-17.
//
//

#import "BaseDialogHandler.h"
#import "BattleSystem.h"
#import "Database.h"
#import "DayNightTransition.h"
#import "MainGUI.h"
#import "MapLayer.h"
#import "MapLoader.h"
#import "MainMenuView.h"
#import "Quest.h"
#import "QuestDialog.h"
#import "Shell.h"
#import "SplashScreen.h"

@implementation Shell
@synthesize mainGui;
@synthesize battleSystem;
@synthesize currentPlaylist;
@synthesize worldMap;
@synthesize worldTileHeight;
@synthesize worldTileWidth;
@synthesize quest;
@synthesize viewHandler = _viewHandler;
static Shell *_shell;
+ (Shell *)shell
{
    return _shell;
}

- (id)init
{
    self = [super init];
    if(self)
    {
        self._width = SCREEN_WIDTH;
        self._height = SCREEN_HEIGHT;
        self.clipsToBounds = YES;
        _shell = self;
        currentSongIndex = 1;
    }
    return self;
}

- (void)startUpSequence
{
    [self connectToDataBase];
    
    [playerDatabase setCurrentRowId:1];
    
    mainMenu = [[MainMenuView alloc] initWithFrame:self.frame];
    [self insertSubview:mainMenu atIndex:Layer_SplashScreenLayer];
    
    _viewHandler = [[BaseDialogHandler alloc] initWithFrame:self.frame andDialogSet:nil];
    
    [self insertSubview:_viewHandler atIndex:10000];
}

-(void)startNew:(NSString *)newName
{
    [self destroyAndRemove:mainMenu];
    [self showSplashScreen:ASSET_VISUAL_SPLASH_SCREEN_MAIN];
    [self createListeners];
    
    [playerDatabase createNewPlayer];
    [playerDatabase setName:newName];
    
    [self createMainGUI];
    [self createQuests];
    [self loadMap:[playerDatabase currentMap]];
    [self onLoadComplete];
    
//    //TEMP
//    [self openQuestDialog];
}

-(void)continueGame
{
    [self destroyAndRemove:mainMenu];
    [self showSplashScreen:ASSET_VISUAL_SPLASH_SCREEN_MAIN];
    [self createListeners];
    [self createMainGUI];
    [self createQuests];
    [self loadMap:[playerDatabase currentMap]];
    [self onLoadComplete];

}

//grabs current playlist for that map file and then plays from the beginning
- (void)initMusicLoop:(NSString *)playListName
{
    if(currentPlaylist)[self destroy:currentPlaylist];
    
    currentPlaylist = [[NSArray alloc] initWithArray:[mapDatabase playlistForMap:playListName]];
    [bgMusic setDelegate:self];
    if([currentPlaylist count] > 0) [self playBGMusic];
}

- (void)playBGMusic
{
    if(currentSongIndex > [currentPlaylist count]) currentSongIndex = 1;
    
    NSString *songPath = [[[NSBundle mainBundle] pathForResource:[currentPlaylist objectAtIndex:(currentSongIndex - 1)] ofType:@"mp3"] retain];
    NSData *songFile = [NSData dataWithContentsOfFile:songPath];
    
    if(!bgMusic) {
        bgMusic = [[AVAudioPlayer alloc] initWithData:songFile error:nil];
    } else {
        [self destroy:bgMusic];
        bgMusic = [[AVAudioPlayer alloc] initWithData:songFile error:nil];
    }
    
    [bgMusic play];
    
    currentSongIndex++;
    [self destroy:songPath];
}

- (void) audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    [self playBGMusic];
}

- (void) audioPlayerEndInterruption:(AVAudioPlayer *)player withOptions:(NSUInteger)flags
{
    //TODO fade in music
    [bgMusic play];
}
- (void)stopBGMusic
{
    //TODO fade out music
    [bgMusic stop];
}

/*
 * Splash screen
 */
- (void)showSplashScreen:(NSString *)splashScreenString
{
    splashScreen = [[SplashScreen alloc]initWithFrame:self.frame andImage:splashScreenString];
    [self insertSubview:splashScreen atIndex:Layer_SplashScreenLayer];
}

- (void)hideSplashScreen
{
    [splashScreen removeFromSuperview];
    [splashScreen release];
    splashScreen = nil;
    
}

/*
 * Shell event listeners
 */
- (void)createListeners
{
    [self addListener:EVENT_SHELL_LOAD_COMPLETE andSel:@selector(hideSplashScreen)];
    [self addListener:EVENT_SLASHSCREEN_UP andSel:@selector(finishNewMapLoad:)];
}

- (void)loadMap:(NSString *)mapFile
{
    map = [[MapLoader alloc] init];
    [map loadXMLFile:[[NSBundle mainBundle] pathForResource:mapFile ofType:@"tmx"]];
    
    self.worldMap = [[NSDictionary alloc] initWithDictionary:map.worldMap];
    self.worldTileWidth = map.worldTileWidth;
    self.worldTileHeight = map.worldTileHeight;
   
    
    [playerDatabase setCurrentMap:mapFile];
       
//    [self initMusicLoop:mapFile];
    
    [self createInteractionLayer];
    
    [mainGui.dayNight startDayTimer];

//    [self destroy:map];
    [map release];
    map = nil;
}

-(void)loadNewMap:(NSString *)mapFile
{
    
    if (!loading){
        loading = TRUE;
        self.battleSystem.mapIsMoving = FALSE;
        if(!splashScreen){
            splashScreen = [[SplashScreen alloc]initWithFrame:self.frame andMapFile:(NSString *)mapFile];
            [self insertSubview:splashScreen atIndex:Layer_SplashScreenLayer];
        }
    }
}

-(void)finishNewMapLoad:(NSNotification *)object
{
    
    NSString *mapFile = [[[object object] retain] autorelease];
    
    //If the current map is the world map the use that position
    if([[playerDatabase currentMap] isEqualToString:MAP_ZONE_WORLD])
        battleSystem.mapStartingPostion = CGPointMake([playerDatabase worldPositionX], [playerDatabase worldPositionY]);
    else
        battleSystem.mapStartingPostion = CGPointMake([playerDatabase dungeonPositionX], [playerDatabase dungeonPositionY]);
    
    
    [mainGui.dayNight stopDayTimer];
    map = [[MapLoader alloc] init];
    [map loadXMLFile:[[NSBundle mainBundle] pathForResource:mapFile ofType:@"tmx"]];
    
    
//    [self destroy:worldMap];
    [self.worldMap release];
    self.worldMap = nil;
    self.worldTileWidth = nil;
    self.worldTileHeight = nil;
    
    self.worldMap = [[NSDictionary alloc] initWithDictionary:map.worldMap];
    self.worldTileWidth = map.worldTileWidth;
    self.worldTileHeight = map.worldTileHeight;
    
    [playerDatabase setCurrentMap:mapFile];
    
    [self initMusicLoop:mapFile];
    [mainGui.dayNight startDayTimer];
    [battleSystem refreshMap];
    [map release];
    map = nil;
    
    [self sendEventOnce:EVENT_MAP_LOADED];
    loading = FALSE;
}

- (void)createInteractionLayer
{
    battleSystem = [[BattleSystem alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) andMap:([playerDatabase currentMap])];
    [self insertSubview:battleSystem atIndex:Layer_Interaction];
}

- (void)createMainGUI
{
    mainGui = [[MainGUI alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self insertSubview:mainGui atIndex:Layer_GuiLayer];
}

- (void)createQuests
{
    quest = [Quest new];
}

- (void)onLoadComplete
{
    [self sendEventOnce:EVENT_SHELL_LOAD_COMPLETE];
    //Send center tile zone number to BattleSystem
    [self sendEventOnce:EVENT_BATTLESYSTEM_ZONE_NEW andObject:[NSNumber numberWithInt:self.battleSystem.centerTile.zoneName]];
}

/*
 * Database
 */
- (void)connectToDataBase
{
    database = [Database new];
}

/*
 *
 * End start sequence
 *
 */

/*
 * Dialogs
 */
- (void)openInventoryDiaog
{
    NSLog(@"Open Inventory Dialog");
}

- (void)openSkillsDialog
{
    NSLog(@"Open Skills Dialog");
}

- (void)openSettingDialog
{
    NSLog(@"Open Settings Dialog");
}

- (void)openQuestDialog
{
    [self.viewHandler addView:[QuestDialog class] andDirection:UP];
}

- (void)dealloc
{
    [self destroy:database];
    [self destroy:currentPlaylist];
    [self destroy:worldMap];
    [self destroy:battleSystem];
    [self destroy:mainGui];
    [self destroy:quest];
    [self destroy:_viewHandler];
    [self destroyAndRemove];
    [super dealloc];
}

@end
