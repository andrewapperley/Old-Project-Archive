//
//  ScrollSelectionList.h
//  LegendOfTheShadowRealm
//
//  Created by Jeremy Fuellert on 2013-03-16.
//
//

#import "BaseView.h"

@class BaseScrollView;

enum ScrollDirection
{
    VERTICAL,
    HORIZONTAL
};

@interface ScrollSelectionList : BaseView
{
    @private
    BaseScrollView *scrollView;
    
    int direction;
    float spacing;
    NSMutableArray *listItems;
}

@property (nonatomic, retain) id selectedItem;

- (id)initWithFrame:(CGRect)frame andScrollDirection:(int)ldirection andListItems:(NSMutableArray *)llistItems andItemSpacing:(float)lspacing;

- (void)addObject:(id)object;
- (void)removeObjectAtIndex:(int)index;

@end
