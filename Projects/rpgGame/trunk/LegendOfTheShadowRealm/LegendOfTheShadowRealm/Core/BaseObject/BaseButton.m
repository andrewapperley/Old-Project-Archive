//
//  BaseButton.m
//  LegendOfTheShadowRealm
//
//  Created by Andrew Apperley on 2012-11-30.
//
//

#import "BaseButton.h"
#import <QuartzCore/QuartzCore.h>
@implementation BaseButton

- (void)addHandler:(SEL)action forControlEvent:(UIControlEvents)controlEvent;
{
    [self addTarget:self action:action forControlEvents:controlEvent];
}

- (void)removeHandler:(SEL)action forControlEvents:(UIControlEvents)controlEvents
{
    [self removeTarget:self action:action forControlEvents:controlEvents];
}

- (void)removeAllHandlers
{
    [self removeTarget:self action:nil forControlEvents:[self allControlEvents]];
}



/*
 * Frame Handling
 */

@synthesize _width;
- (float)_width
{
    return self.frame.size.width * self._scaleX;
}

- (void)set_width:(float)__width
{
    [self setBounds:CGRectMake(self._x, self._y, __width, self._height)];
}

@synthesize _height;
- (float)_height
{
    return self.frame.size.height * self._scaleY;
}

- (void)set_height:(float)__height
{
    [self setBounds:CGRectMake(self._x, self._y, self._width, __height)];
}

@synthesize _x;
- (float)_x
{
    return self.frame.origin.x;
}

- (void)set_x:(float)__x
{
    [self setBounds:CGRectMake(__x, self._y, self._width, self._height)];
}

@synthesize _y;
- (float)_y
{
    return self.frame.origin.y;
}

- (void)set_y:(float)__y
{
    [self setBounds:CGRectMake(self._x, __y, self._width, self._height)];
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

/*
 * Subview Handling
 */

- (void)removeAllSubviews
{
    if([[self subviews] count] > 0)
    {
        while([[self subviews] count] > 0)
        {
            [[[self subviews] objectAtIndex:0]removeFromSuperview];
        }
    }
}

- (void)removeAllSubviewsAtIndex:(int)index
{
    if([[self subviews] count] > 0)
    {
        for(int i = 0; i < [[[self subviews] objectAtIndex:index] count]; i++)
        {
            [[[self subviews] objectAtIndex:index]removeFromSuperview];
            [self destroy:[[self subviews] objectAtIndex:index]];
        }
    }
}

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
    [self removeAllSubviews];
    [self release];
    self = nil;
}

- (void)destroyAndRemove
{
    [self removeAllEvents];
    [self removeAllSubviews];
    [self removeFromSuperview];
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

- (void)destroyAndRemove:(id)object
{
    if(object)
    {
        [object removeFromSuperview];
        [object release];
        object = nil;
    }
}

-(id)initWithImageBackground:(UIImage *)image andPoint:(CGPoint)point withDelay:(BOOL)delay
{
    self = [super init];
    if(self)
    {
        self.frame = CGRectMake(point.x, point.y, image.size.width, image.size.height);
        [self setImage:image forState:UIControlStateNormal];
        
        if(delay){
            [self addHandler:@selector(onClickedWithDelay:) forControlEvent:UIControlEventTouchDown];
            [self addHandler:@selector(onDoneClickingWithDelay:) forControlEvent:UIControlEventTouchUpInside];
        } else{
            [self addHandler:@selector(onClicked:) forControlEvent:UIControlEventTouchDown];
            [self addHandler:@selector(onDoneClicking:) forControlEvent:UIControlEventTouchUpInside];
        }
    }
    
    return self;
}

-(id)initWithImageBackground:(UIImage *)image andSelected:(UIImage *)selected andDisabled:(UIImage *)disabled andPoint:(CGPoint)point withDelay:(BOOL)delay
{
    self = [super init];
    if(self)
    {
        self.frame = CGRectMake(point.x, point.y, image.size.width, image.size.height);
        [self setImage:image forState:UIControlStateNormal];
        [self setImage:selected forState:UIControlStateHighlighted];
        [self setImage:disabled forState:UIControlStateDisabled];
        
        if(delay){
            [self addHandler:@selector(onClickedWithDelay:) forControlEvent:UIControlEventTouchDown];
            [self addHandler:@selector(onDoneClickingWithDelay:) forControlEvent:UIControlEventTouchUpInside];
        } else{
            [self addHandler:@selector(onClicked:) forControlEvent:UIControlEventTouchDown];
            [self addHandler:@selector(onDoneClicking:) forControlEvent:UIControlEventTouchUpInside];
        }

    }
    
    return self;
}

-(void)onClickedWithDelay:(UIEvent *)event
{
    self.userInteractionEnabled = FALSE;
    [self sendEvent:EVENT_BUTTON_CLICKED andObject:self];
}

-(void)onDoneClickingWithDelay:(UIEvent *)event
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1.0f * NSEC_PER_SEC), dispatch_get_current_queue(), ^{
       self.userInteractionEnabled = TRUE; 
    });
}

-(void)onClicked:(UIEvent *)event
{
    [self sendEvent:EVENT_BUTTON_CLICKED andObject:self];
}

-(void)onDoneClicking:(UIEvent *)event
{
    //do something maybe
}


- (void) dealloc
{
    [self removeAllHandlers];
    [self removeAllEvents];
    [self removeAllSubviews];
    [super dealloc];
}@end
