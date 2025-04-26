//
//  SkillsDialog.m
//  LegendOfTheShadowRealm
//
//  Created by Andrew Apperley on 2013-03-16.
//
//
#import "BaseButton.h"
#import "Database.h"
#import "SkillsDialog.h"
#import "ScrollSelectionList.h"
#import <QuartzCore/QuartzCore.h>
@implementation SkillsDialog

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

-(void)initUI
{
    [self getData];
    [self createBackground];
    [self createScrollLists];
    [self createDescriptionArea];
    [super initUI];
}

-(void)getData
{
    activeState = TRUE;
    playerSkills = [NSMutableArray new];
    aSkills = [[NSArray alloc] initWithArray:[skillDatabase listAllActiveSkills]];
    pSkills = [[NSArray alloc] initWithArray:[skillDatabase listAllPassiveSkills]];
}


-(void)createBackground
{
    self.dialogStage = [[BaseView alloc] initWithFrame:CGRectMake(0, 0, [UIImage imageNamed:ASSET_VISUAL_SKILLS_BACKGROUND].size.width, [UIImage imageNamed:ASSET_VISUAL_SKILLS_BACKGROUND].size.height)];
    self.dialogStage.layer.contents = (id)[UIImage imageNamed:ASSET_VISUAL_SKILLS_BACKGROUND].CGImage;
    
    [self addSubview:self.dialogStage];
}

-(void)createScrollLists
{
    [self refreshData];
    NSMutableArray *slotData = [NSMutableArray new];
    NSMutableArray *skillItems = [NSMutableArray new];
    
    for (NSDictionary *skill in playerSkills) {
        BaseButton *slotButton = [[BaseButton alloc] initWithImageBackground:[UIImage imageNamed:ASSET_VISUAL_SKILLS_CIRCLE] andPoint:CGPointMake(0, 0) withDelay:TRUE];
        [slotData addObject:slotButton];
        [slotButton destroy];
    }
    for (NSDictionary *skill in activeState ? aSkills : pSkills) {
        BaseButton *skillButton = [[BaseButton alloc] initWithImageBackground:[UIImage imageNamed:ASSET_VISUAL_SKILLS_CIRCLE] andPoint:CGPointMake(0, 0) withDelay:TRUE];
        [skillItems addObject:skillButton];
        [skillButton destroy];
    }
    
    
    slotsList = [[ScrollSelectionList alloc] initWithFrame:CGRectMake(0, 187.5 + (( 50 - [[slotData lastObject] _height])/2), slotData.count * ([[slotData lastObject] _width] + 10), [[slotData lastObject] _height]) andScrollDirection:HORIZONTAL andListItems:slotData andItemSpacing:10];
    slotsList._x = (self.dialogStage._width - slotsList._width) / 2;
    
    skillsList = [[ScrollSelectionList alloc] initWithFrame:CGRectMake(0, slotsList._height + slotsList._y + 10 + (( 50 - [[skillItems lastObject] _height])/2) ,  skillItems.count * ([[skillItems lastObject] _width] + 10), [[slotData lastObject] _height]) andScrollDirection:HORIZONTAL andListItems:skillItems andItemSpacing:5];
    skillsList._x = (self.dialogStage._width - skillsList._width) / 2;
    
    [self destroy:slotData];
    [self destroy:skillItems];
    
    [self.dialogStage addSubview:slotsList];
    [self.dialogStage addSubview:skillsList];
}

-(void)refreshData
{
    NSArray *skillNames = activeState ? [playerDatabase activeSkills] : [playerDatabase passiveSkills];
    
    for (NSString *skill in skillNames) {
        [playerSkills addObject:[skillDatabase skillByName:skill]];
    }
}


-(void)createDescriptionArea
{
    
}

-(void)switchSkillSet:(int)skill
{
    
}

-(void)dealloc
{
    [self destroy:aSkills];
    [self destroy:pSkills];
    [self destroy:playerSkills];
    
    [slotsList destroyAndRemove];
    [skillsList destroyAndRemove];
    
    [super dealloc];
}
@end