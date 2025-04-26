//
//  QuestDialogInfoItem.m
//  LegendOfTheShadowRealm
//
//  Created by Jeremy Fuellert on 2013-03-10.
//
//

#import "BaseImage.h"
#import "BaseLabel.h"
#import "BaseScrollView.h"
#import "Database.h"
#import "NumberUtil.h"
#import "QuestDialogInfoItem.h"

@implementation QuestDialogInfoItem
@synthesize questUid;

static unsigned long long _questUid;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        [self createScrollView];
        [self refreshUI];
    }
    return self;
}

- (void)createScrollView
{
    background = [[BaseScrollView alloc] initWithFrame:CGRectMake(0, 0, self._width, self._height)];
    [background setScrollsToTop:TRUE];
    [background setShowsHorizontalScrollIndicator:FALSE];
    
    [self addSubview:background];
}

/*
 * Quest Name
 */
- (void)setQuestUid:(unsigned long long)lquestUid
{
    _questUid = lquestUid;
    [self refreshUI];
}

- (NSString *)questName
{
    return _questUid;
}

- (void)refreshUI
{
    if(!questUid || !questUid > 0) return;
    
    [background removeAllSubviews];
    
    //Quest name label
    if(!questNameLabel)
    {
        questNameLabel = [BaseLabel new];
        questNameLabel._y = 10;
        questNameLabel.font = [UIFont fontWithName:FONT_DEFAULT size:18];
        questNameLabel.textColor = [UIColor whiteColor];
    }    
    [background addSubview:questNameLabel];

    questNameLabel.text = [questDatabase nameByUid:questUid];
    [questNameLabel sizeToFit];
    
    questNameLabel._x = (self._width - questNameLabel._width) / 2;
    
    //Quest chain label
    if(!questChainLabel)
    {
        questChainLabel = [BaseLabel new];
        questChainLabel._y = questNameLabel._y;
        questChainLabel.font = [UIFont fontWithName:FONT_DEFAULT size:16];
        questChainLabel.textColor = RGB(236, 240, 178);
    }
    
    [background addSubview:questChainLabel];
    
    questChainLabel.text = [questDatabase chainNameByUid:questUid];
    [questChainLabel sizeToFit];
    
    questChainLabel._x = questNameLabel._x + questNameLabel._width + 2;
    
    //Quest item required
    BaseImage *questItemImage = [[self createItem:[questDatabase itemRequiredUidByUid:questUid]] retain];
    questItemImage._y = questNameLabel._y + questNameLabel._height + 10;
    questItemImage._x = (self._width - questItemImage._width) / 2;

    [background addSubview:questItemImage];
    [self destroy:questItemImage];
    
    //Amount
    BaseLabel *itemAmount = [[BaseLabel alloc] initWithFrame:CGRectMake(0, 0, questItemImage._width, 30)];
    itemAmount.font = [UIFont fontWithName:FONT_DEFAULT size:18];
    itemAmount.textAlignment = UITextAlignmentCenter;
    itemAmount._y = questItemImage._height;
    itemAmount.text = [NSString stringWithFormat:@"%d / %d", MIN([questDatabase numberOfItemsByUid:questUid], [questDatabase numberOfItemsRequiredByUid:questUid]), [questDatabase numberOfItemsRequiredByUid:questUid]];
    
    [questItemImage addSubview:itemAmount];
    
    //Quest description label
    questDescriptionLabel = [BaseLabel new];
    questDescriptionLabel._y = itemAmount._y + itemAmount._height + 10;
    questDescriptionLabel.font = [UIFont fontWithName:FONT_DEFAULT size:16];
    questDescriptionLabel.textColor = RGB(236, 240, 178);
    
    [background addSubview:questDescriptionLabel];
    
    [self destroy:itemAmount];
    [self destroy:questItemImage];
    
    //Quest reward(s)
    BaseImage *rewardContainer = [BaseImage new];
    rewardContainer.clipsToBounds = FALSE;
    
    NSArray *rewards = [[questDatabase rewardItemsByUid:questUid] retain];
    for(uint i = 0; i < rewards.count; i++)
    {
        BaseImage *image = [[self createItem:[(NSNumber *)[rewards objectAtIndex:i] unsignedLongLongValue]] retain];
        
        rewardContainer._height = MAX(rewardContainer._height, image._height);
        rewardContainer._width += image._width;
        [rewardContainer addSubview:image];
        
        image._y = (rewardContainer._height - image._height) / 2;
        
        [self destroy:image];
    }
    [self destroy:rewards];
    
    //Exp reward
    BaseImage *expImage = [[BaseImage alloc] initWithOrigin:CGPointMake(rewardContainer._width, 0) andImage:[UIImage imageNamed:ASSET_VISUAL_EXP_ICON_SMALL]];
    expImage.clipsToBounds = FALSE;
    
    rewardContainer._height = MAX(rewardContainer._height, expImage._height);
    rewardContainer._width += expImage._width;
    [rewardContainer addSubview:expImage];
    
    expImage._y = (rewardContainer._height - expImage._height) / 2;
    
    //Amount
    BaseLabel *expAmount = [[BaseLabel alloc] initWithFrame:CGRectMake(0, 0, expImage._width, 30)];
    expAmount.font = [UIFont fontWithName:FONT_DEFAULT size:18];
    expAmount.textAlignment = UITextAlignmentCenter;
    expAmount._y = expImage._height;
    expAmount.text = [NSString stringWithFormat:@"%f", round([questDatabase expGainedByUid:questUid])];
    [expImage addSubview:expAmount];
    
    [self destroy:expImage];
    [self destroy:expAmount];
    
    //Position container
    rewardContainer._x = (self._width - rewardContainer._width) / 2;
    rewardContainer._y = questDescriptionLabel._y + questDescriptionLabel._height + 10;
    
    [background addSubview:rewardContainer];
    [self destroy:rewardContainer];
}

- (BaseImage *)createItem:(unsigned long long)uid
{
    NSString *imageName = nil;
    UIImage *image = nil;
    BOOL imageFound = FALSE;
    
    //Try for npc / enemy image
    if([NumberUtil numberOfDigits:uid] > 4)
    {
        imageName = Enemy_NPC_Image(PREFIX_ENEMY_IMAGE, uid, South, ACTION_IDLE, 0);
        image = [UIImage imageNamed:imageName];
        if(image && image != nil)
        {
            imageFound = TRUE;
        }
    }
    //Try for item image
    else
    {
        int type = [itemDatabase typeByUid:uid];
        imageName = Item_Image(type, uid);
        image = [UIImage imageNamed:imageName];
        if(image && image != nil)
        {
            imageFound = TRUE;
        }
    }
        
    //If not then output an error
    if(!imageFound)
    {
        NSLog(@"WARNING - Image Not Found : %@", imageName);
    }
        
    return [[[BaseImage alloc] initWithOrigin:CGPointZero andImage:image] autorelease];
}

- (void)dealloc
{
    [self destroy:questNameLabel];
    [self destroy:questChainLabel];
    [self destroy:questDescriptionLabel];
    [self destroy:background];
    
    [super dealloc];
}

@end
