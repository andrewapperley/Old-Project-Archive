//
//  MainMenuView.m
//  LegendOfTheShadowRealm
//
//  Created by Andrew Apperley on 2013-02-28.
//
//

#import "MainMenuView.h"
#import "Constants.h"
#import "BaseImage.h"
#import "BaseButton.h"
#import "BaseVideoPlayer.h"
#import "ParticleSystem.h"
#import "Shell.h"
#import "BaseDialogHandler.h"
#import "ContinuePopUpList.h"
#import "NameNewPlayer.h"
#import "SkillsDialog.h"
@implementation MainMenuView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self._width = SCREEN_WIDTH;
        self._height = SCREEN_HEIGHT;
        
        [self setupUI];
    }
    return self;
}

-(void)setupUI
{
    //create finger catcher
    BaseView *catcher = [[BaseView alloc] initWithFrame:CGRectMake(0, 0, self._width, self._height)];
    catcher.backgroundColor = [UIColor blackColor];
    catcher.alpha = 0.7f;
    catcher.userInteractionEnabled = FALSE;
    //init emitter
    particles = [[ParticleSystem alloc] init];
    
    //create buttons and title
    BaseImage *title = [[BaseImage alloc] initWithOrigin:CGPointMake((self._width - [UIImage imageNamed:@"Main_Title.png"].size.width)/2, 41.5) andImage:[UIImage imageNamed:@"Main_Title.png"]];
    //create menu buttons
    
    UIImage *image = [UIImage imageNamed:@"Start_New_Game.png"];
    
    BaseButton *startNewButton = [[BaseButton alloc] initWithImageBackground:image andPoint:CGPointMake((SCREEN_WIDTH - image.size.width)/2, 191) withDelay:YES];

    [self addListener:EVENT_BUTTON_CLICKED andSel:@selector(onStartNew) andSender:startNewButton];

    
    image = [UIImage imageNamed:@"Continue_Game.png"];
    
    BaseButton *continueNewButton = [[BaseButton alloc] initWithImageBackground:image andPoint:CGPointMake((SCREEN_WIDTH - image.size.width)/2, 215) withDelay:YES];
    
    [self addListener:EVENT_BUTTON_CLICKED andSel:@selector(onContinue) andSender:continueNewButton];
    
    image =  [UIImage imageNamed:@"Settings_Button.png"];
    
    //create settings button
    BaseButton *settingsButton = [[BaseButton alloc] initWithImageBackground:image andPoint:CGPointMake(image.size.width + 8, self._height - image.size.height - 8) withDelay:YES];
    
    [self addListener:EVENT_BUTTON_CLICKED andSel:@selector(onSettings) andSender:settingsButton];
    
    //Add Everything to the stage
    [title.layer addSublayer:particles];
    [self addSubview:catcher];
    [self addSubview:title];
    [self addSubview:startNewButton];
    [self addSubview:continueNewButton];
    [self addSubview:settingsButton];
    

    [self destroy:image];
    [self destroy:title];
    [self destroy:catcher];
    [self destroy:settingsButton];
    [self destroy:startNewButton];
    [self destroy:continueNewButton];
    
//    [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(startParticle) userInfo:nil repeats:NO];
   
    
}

-(void)startParticle
{
    [particles startParticle:[NSDictionary dictionaryWithObjectsAndKeys:
                              [NSValue valueWithCGPoint:CGPointMake(0, 0)],@"emitterSize",
                              [NSNumber numberWithFloat:1.6], @"multiplier",
                              [NSNumber numberWithFloat:10], @"emitterWidth",
                              [NSNumber numberWithFloat:10], @"emitterHeight",
                              [NSNumber numberWithFloat:500], @"birthRate",
                              [NSNumber numberWithFloat:10], @"velocity",
                              [NSNumber numberWithFloat:20], @"velocityRange",
                              [NSNumber numberWithFloat:89], @"particleRed",
                              [NSNumber numberWithFloat:10], @"particleGreen",
                              [NSNumber numberWithFloat:8], @"particleBlue",
                              @"kCAEmitterLayerCuboid", @"emitterShape",
                              @"kCAEmitterLayerOutline", @"emitterMode",
                              [NSNumber numberWithFloat:5], @"spin",
                              [NSNumber numberWithFloat:1000], @"lifetime",
                              @"fire.png", @"particleImage",
                              nil]];

}

-(void)onSettings
{
    [[[Shell shell] viewHandler] addView:[SkillsDialog class] andDirection:UP];

}

-(void)onContinue
{
    [[[Shell shell] viewHandler] addView:[ContinuePopUpList class] andDirection:UP];
}

-(void)onStartNew
{
    [[[Shell shell] viewHandler] addView:[NameNewPlayer class] andDirection:UP];
}

-(void)dealloc
{
    
    [super dealloc];
}
@end
