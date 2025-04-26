//
//  EventCenter.h
//  LegendOfTheShadowRealm
//
//  Created by Andrew Apperley on 2012-11-17.
//
//
#import "EventConstants.h"
@protocol EventCenter

#define Center [NSNotificationCenter defaultCenter]

@optional

/*
 * Event handling
 */
- (void)addListener:(NSString*)key andSel:(SEL)selector;
- (void)addListener:(NSString*)key andSel:(SEL)selector andSender:(id)object;
- (void)addListener:(NSString*)key andQueue:(NSOperationQueue*)queue;

- (void)removeEvent:(NSString*)key;
- (void)removeAllEvents;

- (void)sendEvent:(NSString *)key;
- (void)sendEvent:(NSString *)key andObject:(id)object;
- (void)sendEvent:(NSString *)key andObject:(id)object withInfo:(NSDictionary *)info;
- (void)sendEventOnce:(NSString *)key;
- (void)sendEventOnce:(NSString *)key andObject:(id)object;
- (void)sendEventOnce:(NSString *)key andObject:(id)object withInfo:(NSDictionary*)info;
@end