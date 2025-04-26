//
//  QuestDialogListItem.m
//  LegendOfTheShadowRealm
//
//  Created by Jeremy Fuellert on 2013-03-10.
//
//

#import "BaseButton.h"
#import "BaseLabel.h"
#import "Database.h"
#import "QuestDialogListItem.h"

@implementation QuestDialogListItem
@synthesize isComplete = _isComplete;
@synthesize isSelected = _isSelected;
@synthesize questId = _questId;

- (id)initWithFrame:(CGRect)frame andQuestUid:(unsigned long long)uid anIsComplete:(BOOL)lisComplete
{
    self = [super initWithFrame:frame];
    if(self)
    {
        _questId = uid;
        [self createQuestName:uid];
        self.isComplete = lisComplete;
    }
    return self;
}

- (void)createQuestName:(unsigned long long)uid
{
    label = [BaseLabel new];
    label.font = [UIFont fontWithName:FONT_DEFAULT size:12];
    label.text = [questDatabase nameByUid:uid];
    [label sizeToFit];
    
    [self addSubview:label];
}

/*
 * Complete
 */
- (void)setIsComplete:(BOOL)isComplete
{
    _isComplete = isComplete;
    
    label.textColor = _isComplete ? [UIColor grayColor] : [UIColor whiteColor];
    
    //Apply strikethrough
    if(_isComplete && !strikeThrough)
    {
        strikeThrough = [BaseView new];
        strikeThrough.frame = CGRectMake(0, (label._height - 1) / 2, label._width, 1);
        strikeThrough.backgroundColor = label.textColor;
        [self addSubview:strikeThrough];
    }
}

- (BOOL)isComplete
{
    return _isComplete;
}

/*
 * Selected
 */
- (void)setIsSelected:(BOOL)isSelected
{
    _isSelected = isSelected;
    
    if(_isSelected)
    {
        label.textColor = _isComplete ? RGB(246, 250, 188) : RGB(236, 240, 178);

        //Apply strikethrough
        if(strikeThrough)
            strikeThrough.backgroundColor = label.textColor;
    } else {
        label.textColor = _isComplete ? [UIColor grayColor] : [UIColor whiteColor];
        
        //Apply strikethrough
        if(strikeThrough)
            strikeThrough.backgroundColor = label.textColor;
    }
}

- (BOOL)isSelected
{
    return _isSelected;
}

- (void)dealloc
{
    [self destroy:label];
    
    if(strikeThrough)
        [self destroy:strikeThrough];
    
    [super dealloc];
}

@end
