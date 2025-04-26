//
//  BaseDialogHandler.h
//  LegendOfTheShadowRealm
//
//  Created by Andrew Apperley on 2013-03-05.
//
//

#import "BaseView.h"

@class BaseDialog;

@interface BaseDialogHandler : BaseView
{
    int currentDialogIndex;
    Class currentDialogString;
    BaseDialog *currentDialog;
    BOOL addingView;
    BOOL active;
}

@property(nonatomic,retain)NSMutableArray *queue;
@property(nonatomic,retain)NSArray *_dialogSet;

- (id)initWithFrame:(CGRect)frame andDialogSet:(NSArray *)dialogSet;
-(void)addView:(Class)view andDirection:(int)direction
;
@end