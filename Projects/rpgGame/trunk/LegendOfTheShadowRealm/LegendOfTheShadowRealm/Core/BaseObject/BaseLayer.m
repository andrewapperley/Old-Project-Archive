//
//  BaseLayer.m
//  LegendOfTheShadowRealm
//
//  Created by Andrew Apperley on 2013-01-31.
//
//

#import "BaseLayer.h"

@implementation BaseLayer

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

- (void)removeEvent:(NSString *)key
{
    [Center removeObserver:self name:key object:self];
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


@synthesize _width;
- (float)_width
{
    return self.frame.size.width * self._scaleX;
}

- (void)set_width:(float)__width
{
    [self setFrame:CGRectMake(self._x, self._y, __width, self._height)];
}

@synthesize _height;
- (float)_height
{
    return self.frame.size.height * self._scaleY;
}

- (void)set_height:(float)__height
{
    [self setFrame:CGRectMake(self._x, self._y, self._width, __height)];
}

@synthesize _x;
- (float)_x
{
    return self.frame.origin.x;
}

- (void)set_x:(float)__x
{
    [self setFrame:CGRectMake(__x, self._y, self._width, self._height)];
    
}

@synthesize _y;
- (float)_y
{
    return self.frame.origin.y;
}

- (void)set_y:(float)__y
{
    [self setFrame:CGRectMake(self._x, __y, self._width, self._height)];
}


static float scaleX = 1.0;
@synthesize _scaleX;

- (void)set_scaleX:(float)__scaleX
{
    scaleX = __scaleX;
    [self set_width:self._width];
}

- (float)_scaleX
{
    return scaleX;
}

static float scaleY = 1.0;
@synthesize _scaleY;

- (void)set_scaleY:(float)__scaleY
{
    scaleY = __scaleY;
    [self set_height:self._height];
}

- (float)_scaleY
{
    return scaleY;
}

-(void)dealloc
{
    
    [self removeAllAnimations];
    [self removeAllEvents];
    [self removeFromSuperlayer];
    [self release];
    [super dealloc];
}


@end
