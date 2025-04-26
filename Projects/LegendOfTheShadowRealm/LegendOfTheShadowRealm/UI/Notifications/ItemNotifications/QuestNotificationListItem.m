//
//  QuestNotificationListItem.m
//  LegendOfTheShadowRealm
//
//  Created by Jeremy Fuellert on 2013-02-12.
//
//

#import "QuestNotificationListItem.h"
#import "BaseImage.h"
#import "BaseLabel.h"
#import "Database.h"

#define ITEM_FONT_SIZE  10
#define ITEM_IMAGE_SIZE CGSizeMake(24, 24)

@implementation QuestNotificationListItem
@synthesize uid = _uid;

- (id)initWithFrame:(CGRect)frame andUid:(unsigned long long)luid
{    
    self = [super initWithFrame:frame];
    if (self)
    {
        self._height += 15;
        self.clipsToBounds = FALSE;
        _uid = luid;
        
        [self retrieveItemData];
    }
    return self;
}

- (void)retrieveItemData
{
    [self initInteraction];
    [self initBackground];
    [self initRewardBackground];
    
    NSDictionary *quest = [[questDatabase questByUid:_uid] retain];
    
    //Set quest name
    [self initQuestName:(NSString *)[quest objectForKey:@"name"]];
    
    //Set exp
    [self initExpAmount:[(NSNumber *)[quest objectForKey:@"exp"] intValue]];

    //Set rewards
    rewards = [[NSArray alloc] initWithArray:[quest objectForKey:@"rewards"]];

    //Get rewards
    float positionX = ITEM_IMAGE_SIZE.width + 40;
        
    if(rewards && rewards.count > 0)
    {
        for(int i = 0; i < [rewards count]; i++)
        {
            [self initItem:(NSDictionary *)[itemDatabase itemByUid:(NSString *)[[rewards objectAtIndex:i] longLongValue]] andXPosition:positionX];
            
            positionX += ITEM_IMAGE_SIZE.width + 40;
        }
    }
    
    rewardBackground._width = positionX - 40;
    
    [self positionRewards];
        
    [self destroy:quest];
}

- (void)initRewardBackground
{
    rewardBackground = [BaseImage new];
    rewardBackground._height = ITEM_IMAGE_SIZE.height + 50;
    [self addSubview:rewardBackground];
}

-(void)initQuestName:(NSString *)name
{
    //Suffix text
    BaseLabel *prefix = [[BaseLabel alloc] initWithFrame:CGRectMake(0, 5, 0, 15)];
    prefix.font = [UIFont fontWithName:FONT_DEFAULT size:12];
    prefix.textColor = [UIColor yellowColor];
    prefix.text = @"Quest Complete : ";
    [prefix sizeToFit];
    
    //Quest name
    BaseLabel *questName = [[BaseLabel alloc] initWithFrame:CGRectMake(0, 5, 0, 15)];
    questName.font = [UIFont fontWithName:FONT_DEFAULT size:12];
    questName.textColor = [UIColor whiteColor];
    questName.text = name;
    [questName sizeToFit];
    
    //Position
    prefix._x = (self._width - prefix._width) / 2;
    prefix._x -= questName._width / 2;
    
    questName._x = prefix._x + prefix._width;
    
    [self addSubview:questName];
    [self addSubview:prefix];
    
    [self destroy:questName];
    [self destroy:prefix];
}

-(void)initExpAmount:(int)exp
{
    if(exp <= 0) return;
    
    BaseImage *expImage = [[BaseImage alloc] initWithFrame:CGRectMake(5, 5, ITEM_IMAGE_SIZE.width, ITEM_IMAGE_SIZE.height) andImage:[UIImage imageNamed:ASSET_VISUAL_EXP_ICON_SMALL]];
    expImage.userInteractionEnabled = FALSE;

    BaseLabel *expAmount = [[BaseLabel alloc] initWithFrame:CGRectMake(-20, expImage._y + expImage._height - 2, expImage._width + 40, 25)];
    expAmount.font = [UIFont fontWithName:FONT_DEFAULT size:ITEM_FONT_SIZE];
    expAmount.textColor = [UIColor whiteColor];
    expAmount.textAlignment = UITextAlignmentCenter;
    expAmount.text = [NSString stringWithFormat:@"+ %d",exp];
    
    [rewardBackground addSubview:expImage];
    [rewardBackground addSubview:expAmount];
    
    [self destroy:expAmount];
    [self destroy:expImage];
}

/*
 * Interaction
 */
- (void)initInteraction
{
    //Press
    UITapGestureRecognizer *pressGesture = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onPressGesture:)] autorelease];
    pressGesture.delegate = self;
    pressGesture.numberOfTouchesRequired = 1;
    pressGesture.numberOfTapsRequired = 1;
    [self addGestureRecognizer:pressGesture];
}

- (void)onPressGesture:(UILongPressGestureRecognizer *)gesture
{
    [self sendEventOnce:EVENT_QUEST_NOTIFICATION_HIDE andObject:self];
}

/*
 * UI Handling
 */
- (void)initBackground
{
    self.backgroundColor = [UIColor colorWithHue:0.0f saturation:0.0f brightness:0.0f alpha:0.85];
    self.layer.borderWidth = 1.0f;
    self.layer.borderColor = [UIColor colorWithRed:207.0f/255.0f green:207.0f/255.0f blue:207.0f/255.0f alpha:0.5].CGColor;
}

- (void)initItem:(NSDictionary *)data andXPosition:(float)xPos
{
    //Image
    NSString *image = Item_Image([(NSNumber *)[data objectForKey:@"type"] intValue], [(NSNumber *)[data objectForKey:@"uid"] unsignedLongLongValue]);
    
    BaseImage *itemImage = [[BaseImage alloc] initWithFrame:CGRectMake(5 + xPos, 5, ITEM_IMAGE_SIZE.width, ITEM_IMAGE_SIZE.height) andImage:[UIImage imageNamed:image]];
    
    UIButton *imageButton = [[UIButton alloc] initWithFrame:CGRectMake(-15, -15, itemImage._width + (itemImage._x * 2) + 30, (itemImage._y * 2) + 30)];
    [imageButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    //Name
    BaseLabel *itemName = [[BaseLabel alloc] initWithFrame:CGRectMake(-20, itemImage._height - 2, itemImage._width + 40, 25)];
    itemName.font = [UIFont fontWithName:FONT_DEFAULT size:ITEM_FONT_SIZE];
    itemName.textColor = [UIColor whiteColor];
    itemName.numberOfLines = 2;
    itemName.textAlignment = UITextAlignmentCenter;
    itemName.text = (NSString *)[data objectForKey:@"name"];
    
    [rewardBackground addSubview:itemImage];
    [itemImage addSubview:itemName];
    [itemImage addSubview:imageButton];
    
    [self destroy:itemImage];
    [self destroy:imageButton];
    [self destroy:itemName];
}

- (void)buttonClicked:(id)sender
{
    [Shell.shell openInventoryDiaog];
}

- (void)positionRewards
{
    rewardBackground._x = (self._width - rewardBackground._width) / 2;
    rewardBackground._y = self._y + 24;
}

- (void)dealloc
{    
    [self destroy:rewardBackground];
    [self destroy:rewards];
    
    [super dealloc];
}

@end
