//
//  BaseDialog.m
//  LegendOfTheShadowRealm
//
//  Created by Andrew Apperley on 2013-03-05.
//
//

#import "BaseDialog.h"
#import "BaseButton.h"

@implementation BaseDialog
@synthesize dialogStage = _dialogStage,blocker = _blocker;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        [self initBlocker];
        [self initUI];
    }
    return self;
}

-(void)initUI
{
    _dialogStage._x = (self._width - _dialogStage._width)/2;
    _dialogStage._y = (self._height - _dialogStage._height)/2;
}

-(void)initBlocker
{
    _blocker = [[BaseButton alloc] initWithFrame:self.frame];
    _blocker.backgroundColor = [UIColor blackColor];
    _blocker.alpha = 0.7f;
    [_blocker addHandler:@selector(blockerClicked) forControlEvent:UIControlEventTouchUpInside];
    
    [self addSubview:_blocker];
}

-(void)blockerClicked
{
    [self closeDialog:0];
}

-(void)closeDialog:(int)direction
{
    [self sendEvent:EVENT_SHOW_OUT andObject:[NSNumber numberWithInt:direction]];
}

-(void)dealloc
{
    [self destroy:_dialogStage];
    [self destroy:_blocker];
    
    [super dealloc];
}

@end
