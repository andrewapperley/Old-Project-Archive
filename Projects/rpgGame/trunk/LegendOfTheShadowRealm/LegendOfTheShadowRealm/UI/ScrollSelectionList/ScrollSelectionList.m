//
//  ScrollSelectionList.m
//  LegendOfTheShadowRealm
//
//  Created by Jeremy Fuellert on 2013-03-16.
//
//

#import "BaseScrollView.h"
#import "Constants.h"
#import "ScrollSelectionList.h"

@implementation ScrollSelectionList

- (id)initWithFrame:(CGRect)frame andScrollDirection:(int)ldirection andListItems:(NSMutableArray *)llistItems andItemSpacing:(float)lspacing
{
    self = [super initWithFrame:frame];
    if(self)
    {
        direction = ldirection;
        listItems = [llistItems retain];
        spacing = lspacing;
        [self createScrollView];
        [self addScrollListItems];
        [self positionSrollListItems];
    }
    return self;
}

- (void)createScrollView
{
    scrollView = [[BaseScrollView alloc] initWithFrame:CGRectMake(0, 0, self._width, self._height)];
    [self addSubview:scrollView];
}

- (void)addScrollListItems
{
    for(uint i = 0; i < listItems.count; i++)
    {
        [scrollView addSubview:[listItems objectAtIndex:i]];
    }
}

- (void)addObject:(id)object
{
    [listItems addObject:object];
    [scrollView addSubview:object];
    
    [self positionSrollListItems];
}

- (void)removeObjectAtIndex:(int)index
{
    UIView *listItemObject = [listItems objectAtIndex:index];
    [listItemObject removeFromSuperview];
    [listItems removeObjectAtIndex:index];
    
    [self positionSrollListItems];
}

/*
 * Positioning
 */
- (void)positionSrollListItems
{
    float position = 0.0f;
    float listItemSize = 0.0f;
    
    if([self isHorizontal])
    {
        for(uint i = 0; i < listItems.count; i++)
        {
            UIView *listItemObject = [[listItems objectAtIndex:i] retain];
            listItemObject.frame = CGRectMake(position, listItemObject.frame.origin.y, listItemObject.frame.size.width, listItemObject.frame.size.height);
            
            position += listItemObject.frame.size.width + spacing;
            
            listItemSize = MAX(listItemSize, listItemObject.frame.size.width);
            
            [self destroy:listItemObject];
        }
        [scrollView setContentSize:CGSizeMake(position + listItemSize, scrollView._height)];

    } else {
        for(uint i = 0; i < listItems.count; i++)
        {
            UIView *listItemObject = [[listItems objectAtIndex:i] retain];
            listItemObject.frame = CGRectMake(listItemObject.frame.origin.x, position, listItemObject.frame.size.width, listItemObject.frame.size.height);
            
            position += listItemObject.frame.size.height;
            
            listItemSize = MAX(listItemSize, listItemObject.frame.size.height);
            
            [self destroy:listItemObject];
        }
        [scrollView setContentSize:CGSizeMake(scrollView._width, position + listItemSize)];
    }
}

/*
 * Horizontal check
 */
- (BOOL)isHorizontal
{
    return direction == HORIZONTAL;
}

/*
 * Selected item
 */
@synthesize selectedItem = _selectedItem;
- (void)setSelectedItem:(id)selectedItem
{
    _selectedItem = selectedItem;
    [self setSelectedItemOverlay:_selectedItem];
}

- (id)selectedItem
{
    return _selectedItem;
}

- (void)setSelectedItemOverlay:(id)item
{
    for(UIView *item in listItems)
    {
        item.alpha = 1.0f;
    }
    
    //TODO : Overlay
    NSLog(@"ScrollSelectionList - TODO : Overlay");
    [(UIView *)item setAlpha:0.25];
}

- (void)dealloc
{
    [self destroy:listItems];
    [self destroy:scrollView];
    
    [super dealloc];
}

@end
