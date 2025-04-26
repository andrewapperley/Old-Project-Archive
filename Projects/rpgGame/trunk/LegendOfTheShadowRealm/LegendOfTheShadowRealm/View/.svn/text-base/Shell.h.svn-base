//
//  Shell.h
//  LegendOfTheShadowRealm
//
//  Created by Andrew Apperley on 2012-11-17.
//
//

#import "BaseView.h"
#import "Constants.h"
#import <AVFoundation/AVFoundation.h>

enum Shell_Layer
{
    Layer_Interaction,
    Layer_ForeGround,
    Layer_GuiLayer,
    Layer_SplashScreenLayer
};

@class BattleSystem;
@class Database;
@class MainGUI;
@class MapLayer;
@class MapLoader;
@class Quest;
@class SplashScreen;
@class BaseDialogHandler;
@class MainMenuView;

@interface Shell : BaseView <AVAudioPlayerDelegate>
{
    BOOL loading;
    SplashScreen *splashScreen;
    MapLoader *map;
    MainMenuView *mainMenu;
    @private
    AVAudioPlayer *bgMusic;
    
    Database *database;
    int currentSongIndex;
}

@property (nonatomic, retain) MainGUI *mainGui;
@property (nonatomic, retain) NSDictionary *worldMap;
@property (nonatomic, assign) int worldTileWidth;
@property (nonatomic, assign) int worldTileHeight;
@property (nonatomic, retain) BattleSystem *battleSystem;
@property (nonatomic, retain) NSArray *currentPlaylist;
@property (nonatomic, retain) Quest *quest;
@property (nonatomic, retain) BaseDialogHandler *viewHandler;
+ (Shell *)shell;

- (void)startUpSequence;
- (void)playBGMusic;
- (void)stopBGMusic;
- (void)loadMap:(NSString *)mapFile;
- (void)loadNewMap:(NSString *)mapFile;
- (void)showSplashScreen:(NSString *)splashScreenString;
- (void)hideSplashScreen;
- (void)startNew:(NSString *)newName;
- (void)continueGame;
/*
 * Dialogs
 */
- (void)openInventoryDiaog;
- (void)openSkillsDialog;
- (void)openSettingDialog;
- (void)openQuestDialog;

@end
