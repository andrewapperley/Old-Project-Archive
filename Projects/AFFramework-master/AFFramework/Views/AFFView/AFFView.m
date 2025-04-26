//
//  AFFView.m
//  AFFramework
//
//  Created by Jeremy Fuellert on 2013-04-13.
//  Copyright (c) 2013 AFFramework. All rights reserved.
//
//
//  AFFView will use 'evtReady' event to trigger it's parent view controller or view to handler it.
//  This event MUST be sent from the view to be shown by an AFFViewController and it should be used after all
//  of the view's contents are loaded.
//
//  AFFView will use 'evtReadyFailed' event to trigger a failure in the view's creation.
//  This will disallow it's parent view controller from opening it.
//
//  isReady property is used for the parent AFFViewCotroller to know if the view was loaded before
//  AFFViewCotroller could recieve the 'evtReady' event.
//
#import "AFFView.h"
#import "ARCHelper.h"

@implementation AFFView
@synthesize parentViewController;
@synthesize isReady = _isReady;

AFFEventSynthesize(AFFEventInstance, evtReady);
AFFEventSynthesize(AFFEventInstance, evtReadyFailed);

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self)
    {
        _isReady = FALSE;
        [[self evtReady] addHandlerOneTime:AFFHandler(@selector(setReady))];
    }
    return self;
}

- (id)init
{
    self = [super init];
    if(self)
    {
        _isReady = FALSE;
        [[self evtReady] addHandlerOneTime:AFFHandler(@selector(setReady))];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        _isReady = FALSE;
        [[self evtReady] addHandlerOneTime:AFFHandler(@selector(setReady))];
    }
    return self;
}

- (void)setReady
{
    _isReady = TRUE;
}

- (void)dealloc
{
    AFFRemoveAllEvents();
    
    [super ah_dealloc];
}

@end
