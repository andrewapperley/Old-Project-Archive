//
//  ItemNotificationListItem.m
//  LegendOfTheShadowRealm
//
//  Created by Jeremy Fuellert on 2013-01-24.
//
//

#import "BaseImage.h"
#import "BaseLabel.h"
#import "ItemNotificationListItem.h"
#import "Database.h"

@implementation ItemNotificationListItem
@synthesize uid = _uid;

- (id)initWithFrame:(CGRect)frame andUid:(unsigned long long)luid
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.clipsToBounds = FALSE;
        _uid = luid;
                
        [self retrieveItemData];
    }
    return self;
}

- (void)retrieveItemData
{
    NSDictionary *item = [[itemDatabase itemByUid:_uid] retain];
    
    [self initInteraction];
    [self initBackground];
    [self initItemName:(NSString *)[item objectForKey:@"name"]];
    [self initItemImage:Item_Image([[item objectForKey:@"type"] intValue], _uid)];
    [self initItemDescription:(NSString *)[item objectForKey:@"description"]];
    [self initItemType:[[item objectForKey:@"type"] intValue]];
    
    [self destroy:item];
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
    [self sendEventOnce:EVENT_ITEM_NOTIFICATION_HIDE andObject:self];
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

- (void)initItemImage:(NSString *)imageName
{    
    BaseImage *itemImage = [[BaseImage alloc] initWithOrigin:CGPointMake(5, 5) andImage:[UIImage imageNamed:imageName]];
   
    UIButton *imageButton = [[UIButton alloc] initWithFrame:CGRectMake(-15, -15, itemImage._width + (itemImage._x * 2) + 30, (itemImage._y * 2) + 30)];
    [imageButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:itemImage];    
    [itemImage addSubview:imageButton];
    
    [self destroy:imageButton];
    [self destroy:itemImage];
}

- (void)buttonClicked:(id)sender
{
    [Shell.shell openInventoryDiaog];
}

- (void)initItemName:(NSString *)litemName
{
    _itemName = [[BaseLabel alloc] initWithFrame:CGRectMake(60, 5, 0, 15)];
    _itemName.font = [UIFont fontWithName:FONT_DEFAULT size:13];
    _itemName.textColor = [UIColor whiteColor];
    _itemName.text = litemName;
    [_itemName sizeToFit];
    
    [self addSubview:_itemName];
    [self destroy:_itemName];
}

- (void)initItemDescription:(NSString *)description
{
    BaseLabel *itemDescription = [[BaseLabel alloc] initWithFrame:CGRectMake(60, 12, self._width - 65, 50)];
    itemDescription.font = [UIFont fontWithName:FONT_DEFAULT size:10];
    itemDescription.textColor = [UIColor colorWithWhite:255.0f alpha:0.8];
    itemDescription.text = description;
    itemDescription.numberOfLines = 0;
        
    [self addSubview:itemDescription];
    [self destroy:itemDescription];
}

- (void)initItemType:(int)type
{
    BaseLabel *itemType = [[BaseLabel alloc] initWithFrame:CGRectMake(_itemName._x + _itemName._width + 2, 7, 0, 15)];
    itemType.font = [UIFont fontWithName:FONT_DEFAULT size:11];
    itemType.textColor = [UIColor yellowColor];
    itemType.alpha = 0.8;
    
    NSMutableString *text = [NSMutableString stringWithString:@"("];
    
    switch(type)
    {
        case Misc:
            [text appendString:TEXT_CONSTANT_ITEM_TYPE_MISC];
            break;
        case Dagger:
            [text appendString:TEXT_CONSTANT_ITEM_TYPE_DAGGER];
            break;
        case Axe:
            [text appendString:TEXT_CONSTANT_ITEM_TYPE_AXE];
            break;
        case Bow:
            [text appendString:TEXT_CONSTANT_ITEM_TYPE_BOW];
            break;
        case Sword:
            [text appendString:TEXT_CONSTANT_ITEM_TYPE_SWORD];
            break;
        case Throwing:
            [text appendString:TEXT_CONSTANT_ITEM_TYPE_THROWING];
            break;
        case WristBlades:
            [text appendString:TEXT_CONSTANT_ITEM_TYPE_WRIST_BLADES];
            break;
        case Darts:
            [text appendString:TEXT_CONSTANT_ITEM_TYPE_DARTS];
            break;
        case Helmet:
            [text appendString:TEXT_CONSTANT_ITEM_TYPE_HELMET];
            break;
        case Shoulder:
            [text appendString:TEXT_CONSTANT_ITEM_TYPE_SHOULDER];
            break;
        case Chest:
            [text appendString:TEXT_CONSTANT_ITEM_TYPE_CHEST];
            break;
        case Hands:
            [text appendString:TEXT_CONSTANT_ITEM_TYPE_HANDS];
            break;
        case Belt:
            [text appendString:TEXT_CONSTANT_ITEM_TYPE_BELT];
            break;
        case Legs:
            [text appendString:TEXT_CONSTANT_ITEM_TYPE_LEGS];
            break;
        case Feet:
            [text appendString:TEXT_CONSTANT_ITEM_TYPE_FEET];
            break;
        case Ring:
            [text appendString:TEXT_CONSTANT_ITEM_TYPE_RING];
            break;
        default:
            break;
    }
    
    [text appendString:@")"];
    [itemType setText:text];
    [itemType sizeToFit];
    
    [self addSubview:itemType];
    [self destroy:itemType];
}

@end
