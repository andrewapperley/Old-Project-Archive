//
//  BaseObject.m
//  LegendOfTheShadowRealm
//
//  Created by Andrew Apperley on 2012-11-17.
//
//

#import "BaseObject.h"

@implementation BaseObject

/*
 * Notification Center Handling
 */
- (void)addListener:(NSString*)key andSel:(SEL)selector
{
    [self addListener:key andSel:selector andSender:nil];
}

- (void)addListener:(NSString *)key andSel:(SEL)selector andSender:(id)object
{
    [Center addObserver:self selector:selector name:key object:object];
}

- (void)addListener:(NSString *)key andQueue:(NSOperationQueue *)queue
{
    [Center addObserverForName:key object:self queue:queue usingBlock:nil];
}

- (void)removeEvent:(NSString *)key withObject:(id)object
{
    [Center removeObserver:self name:key object:object];
}

- (void)removeAllEvents
{
    [Center removeObserver:self];
}

- (void)sendEvent:(NSString *)key
{
    [self sendEvent:key andObject:nil];
}

- (void)sendEvent:(NSString *)key andObject:(id)object
{
    [Center postNotificationName:key object:object];
}

- (void)sendEvent:(NSString *)key andObject:(id)object withInfo:(NSDictionary *)info
{
    [Center postNotificationName:key object:object userInfo:info];
}

- (void)sendEventOnce:(NSString *)key
{
    [self sendEventOnce:key andObject:nil];
}

- (void)sendEventOnce:(NSString *)key andObject:(id)object
{
    [Center postNotificationName:key object:object];
    [self removeEvent:key];
}

- (void)sendEventOnce:(NSString *)key andObject:(id)object withInfo:(NSDictionary*)info
{
    [Center postNotificationName:key object:object userInfo:info];
    [self removeEvent:key];
}

/*
 * Destroy Methods
 */

- (void)destroy
{
    [self removeAllEvents];
    [self release];
    self = nil;
}


- (void)destroy:(id)object
{
    if(object)
    {
        [object release];
        object = nil;
    }
}

- (void) dealloc
{
    [self removeAllEvents];
    [super dealloc];
}

@end
