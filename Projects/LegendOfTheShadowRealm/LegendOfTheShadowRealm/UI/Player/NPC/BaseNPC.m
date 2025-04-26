//
//  BaseNPC.m
//  LegendOfTheShadowRealm
//
//  Created by Andrew Apperley on 2012-12-15.
//
//

#import "BaseNPC.h"
#import "Shell.h"
#import "BaseXMLParser.h"

@implementation BaseNPC

//Conversation Element & Attribute
#define C_E @"dialog"
#define C_A @"text"

@synthesize positionX;
@synthesize positionY;
@synthesize quests;
@synthesize name;
@synthesize conversation;
@synthesize inConversation;

- (id)initWithOrigin:(CGPoint)frame andData:(NSDictionary *)data
{
    self = [super initWithOrigin:frame andImage:nil];
    if (self) {
        self.userInteractionEnabled = FALSE;
        boundsPosition = CGPointZero;
        
        [self setData:data];
        [self addListener:[NSString stringWithFormat:@"%@_%lld",EVENT_INTERACT_WITH_NPC,self.uid] andSel:@selector(startConversation:)];
        [self addListener:[NSString stringWithFormat:@"%@_%lld",EVENT_NPC_DONE_CONVO,self.uid] andSel:@selector(endConversation)];
    }
    
    return self;
}

- (void)setData:(NSDictionary *)ldictionary
{
    NSDictionary *dictionary = [ldictionary retain];
    
    self.uid = (unsigned long long)[(NSNumber *)[dictionary objectForKey:@"uid"] unsignedLongLongValue];
    self.positionX = (int)[(NSNumber *)[dictionary objectForKey:@"positionX"] intValue];
    self.positionY = (int)[(NSNumber *)[dictionary objectForKey:@"positionY"] intValue];
    self.boundsX = (int)[(NSNumber *)[dictionary objectForKey:@"boundsX"] intValue];
    self.boundsY = (int)[(NSNumber *)[dictionary objectForKey:@"boundsY"] intValue];
    self.speed = (float)[(NSNumber *)[dictionary objectForKey:@"speed"] floatValue];
    self.directionChangeTime = (float)[(NSNumber *)[dictionary objectForKey:@"directionChangeTime"] floatValue];
    self.quests = [(NSArray *)[dictionary objectForKey:@"quests"] retain];
    self.name = [(NSString *)[dictionary objectForKey:@"name"] retain];
    self.map = [(NSString *)[dictionary objectForKey:@"map"] retain];
    self.zone = [(NSString *)[dictionary objectForKey:@"zone"] retain];
    self.radius = (float)[(NSNumber *)[dictionary objectForKey:@"radius"] floatValue];
    
    //Set default image
    NSString *imageName = Enemy_NPC_Image(self.prefix, self.uid, self.direction, ACTION_IDLE, 0);
    UIImage *image = [UIImage imageNamed:imageName];
    [self setImage:image];
    
    NSString *filePath = [NSString stringWithFormat:@"%lld_conversation",self.uid];
    
    [self generateConversationFromFile:filePath];
    
    [self destroy:dictionary];
}

-(void)generateConversationFromFile:(NSString *)c
{
    BaseXMLParser *conversationParser = [[BaseXMLParser alloc] initWithElementName:C_E andAttribute:C_A];
    [conversationParser loadXMLFile:[[NSBundle mainBundle] pathForResource:c ofType:@"xml"]];
    
    self.conversation = [NSArray arrayWithArray:conversationParser.parsedObjects];
    
    [self destroy:conversationParser];
}

- (void)startMovement
{
    [self stop];
    [self changeRandomDirection];
    
    if(self.speed >= MAX_VELOCITY || self.speed <= - MAX_VELOCITY)
        [self startRun];
    else
        [self startWalk];
}

-(void)startConversation:(UIEvent *)e
{
    if(inConversation)
        return;
    inConversation = TRUE;
    //send event to trigger box to show up
    NSArray *object = [NSArray arrayWithObjects:self.conversation, [NSNumber numberWithUnsignedLongLong:self.uid], nil];
    [self sendEvent:EVENT_NPC_START_CONVO andObject:object];
}

-(void)endConversation
{
    if(inConversation)
    {
        inConversation = FALSE;
    }
}

- (void)startWalk
{
    _isWalking = TRUE;
    _isRunning = FALSE;
    [self setAction:ACTION_WALKING];
    [self setNumberOfStates:3];
    
    if(![timer isValid])
    {
        if(!self.isBlockedByPlayer)
        {
            timer = [NSTimer scheduledTimerWithTimeInterval:SPRITE_ANIMATION_WALK_DURATION target:self selector:@selector(incrementState) userInfo:nil repeats:YES];
       
            timer = [NSTimer scheduledTimerWithTimeInterval:SPRITE_ANIMATION_WALK_DURATION target:self selector:@selector(moveNPC) userInfo:nil repeats:YES];
            
            timer = [NSTimer scheduledTimerWithTimeInterval:self.directionChangeTime target:self selector:@selector(changeRandomDirection) userInfo:nil repeats:YES];
        }
    }
}

- (void)startRun
{
    _isRunning = TRUE;
    _isWalking = FALSE;
    [self setAction:ACTION_WALKING];
    [self setNumberOfStates:3];
    
    if(![timer isValid])
    {
        if(!self.isBlockedByPlayer)
        {
            timer = [NSTimer scheduledTimerWithTimeInterval:SPRITE_ANIMATION_RUN_DURATION target:self selector:@selector(incrementState) userInfo:nil repeats:YES];
        
            timer = [NSTimer scheduledTimerWithTimeInterval:SPRITE_ANIMATION_RUN_DURATION target:self selector:@selector(moveNPC) userInfo:nil repeats:YES];
            
            timer = [NSTimer scheduledTimerWithTimeInterval:self.directionChangeTime target:self selector:@selector(changeRandomDirection) userInfo:nil repeats:YES];
        }
    }
}


- (void)moveNPC
{
    if(self.isBlockedByPlayer) return;
    
    if(![self isOkayToMoveInBounds])
    {
        [self changeRandomDirection];
        return;
    }
        
    //Send move event to Interaction Layer
    NSDictionary *sendValues = [NSDictionary dictionaryWithObjectsAndKeys:self, @"npc", [NSValue valueWithCGPoint:CGPointMake(movePoint.x, movePoint.y)], @"move", nil];
    
    [self sendEventOnce:EVENT_NPC_ANIMATION_MOVED andObject:sendValues];
}

- (BOOL)isOkayToMoveInBounds
{    
    if(boundsPosition.x + movePoint.x > self.boundsX * TILE_WIDTH ||
       boundsPosition.y + movePoint.y > self.boundsY * TILE_HEIGHT ||
       boundsPosition.x + movePoint.x < 0 ||
       boundsPosition.y + movePoint.y < 0)
    {
        return FALSE;
    }
    
    boundsPosition.x += movePoint.x;
    boundsPosition.y += movePoint.y;

    return TRUE;
}

- (void)kill
{
    [UIView animateWithDuration:1.0f animations:^{
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (NSString *)prefix
{
    return PREFIX_NPC_IMAGE;
}

- (void)dealloc
{
    [self destroy:quests];
    [self destroy:name];
    
    [super dealloc];
}

@end
