/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2012 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 * 
 * WARNING: This is generated code. Modify at your own risk and without support.
 */
#ifdef USE_TI_UIBUTTON

#import "TiUIButtonProxy.h"
#import "TiUIButton.h"
#import "TiUINavBarButton.h"
#import "TiUtils.h"

@implementation TiUIButtonProxy

-(void)_destroy
{
	RELEASE_TO_NIL(button);
    toolbar = nil;
	[super _destroy];
}

-(void)_configure
{	
	[self replaceValue:NUMBOOL(YES) forKey:@"enabled" notification:NO];
	[super _configure];
}

-(NSMutableDictionary*)langConversionTable
{
    return [NSMutableDictionary dictionaryWithObject:@"title" forKey:@"titleid"];
}

-(void)setStyle:(id)value
{
	styleCache = [TiUtils intValue:value def:UIButtonTypeCustom];
	[self replaceValue:value forKey:@"style" notification:YES];
}

-(UIBarButtonItem*)barButtonItem
{
    /*
	id backgroundImageValue = [self valueForKey:@"backgroundImage"];
	if (!IS_NULL_OR_NIL(backgroundImageValue))
	{
		return [super barButtonItem];
	}
	*/
    
	if (button==nil || !isUsingBarButtonItem)
	{
		isUsingBarButtonItem = YES;
        if (button == nil) {
            button = [[TiUINavBarButton alloc] initWithProxy:self];
        }
	}
	return button;
}

-(CGFloat) verifyWidth:(CGFloat)suggestedWidth
{
	switch(styleCache)
	{
		case UIrenderingtestNativeItemInfoLight:
		case UIrenderingtestNativeItemInfoDark:
			return 18;
		case UIrenderingtestNativeItemDisclosure:
			return 29;
		default: {
			break;
		}
	}
	return suggestedWidth;
}

-(CGFloat) verifyHeight:(CGFloat)suggestedHeight
{
	switch(styleCache)
	{
		case UIrenderingtestNativeItemInfoLight:
		case UIrenderingtestNativeItemInfoDark:
			return 19;
		case UIrenderingtestNativeItemDisclosure:
			return 31;
		default: {
			break;
		}
	}
	return suggestedHeight;
}


-(UIViewAutoresizing) verifyAutoresizing:(UIViewAutoresizing)suggestedResizing
{
	switch (styleCache)
	{
		case UIrenderingtestNativeItemInfoLight:
		case UIrenderingtestNativeItemInfoDark:
		case UIrenderingtestNativeItemDisclosure:
			return suggestedResizing & ~(UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
		default: {
			break;
		}
	}
	return suggestedResizing;
}

-(BOOL)optimizeSubviewInsertion
{
    return YES;
}

-(UIView *) parentViewForChild:(TiViewProxy *)child
{
	return [(TiUIButton *)[self view] viewGroupWrapper];
}

-(void)removeBarButtonView
{
    // If we remove the button here, it could be the case that the system
    // sends a message to a released UIControl on the interior of the button,
    // causing a crash. Very timing-dependent.
    
    //	RELEASE_TO_NIL(button);
    [super removeBarButtonView];
}

-(void)setToolbar:(id<TiToolbar>)toolbar_
{
	toolbar = toolbar_;
}

-(id<TiToolbar>)toolbar
{
	return [[toolbar retain] autorelease];
}

-(BOOL)attachedToToolbar
{
	return toolbar!=nil;
}

-(void)fireEvent:(NSString *)type withObject:(id)obj withSource:(id)source propagate:(BOOL)propagate
{
	if (![TiUtils boolValue:[self valueForKey:@"enabled"] def:YES])
	{
		//Rogue event. We're supposed to be disabled!
		return;
	}
	[super fireEvent:type withObject:obj withSource:source propagate:propagate];
}

-(TiDimension)defaultAutoWidthBehavior:(id)unused
{
    return TiDimensionAutoSize;
}
-(TiDimension)defaultAutoHeightBehavior:(id)unused
{
    return TiDimensionAutoSize;
}

USE_VIEW_FOR_CONTENT_HEIGHT
USE_VIEW_FOR_CONTENT_WIDTH

@end

#endif