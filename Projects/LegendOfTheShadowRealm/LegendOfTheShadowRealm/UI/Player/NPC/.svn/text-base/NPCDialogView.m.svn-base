//
//  NPCDialogView.m
//  LegendOfTheShadowRealm
//
//  Created by Andrew Apperley on 2013-02-06.
//
//

#import "Constants.h"
#import "NPCDialogView.h"
#import "EventConstants.h"
#import <QuartzCore/QuartzCore.h>
#import "BaseLabel.h"
#import "Database.h"

@implementation NPCDialogView
@synthesize _convo;

#define BOX_WIDTH SCREEN_WIDTH / 2
#define BOX_HEIGHT 70
#define BOX_FRAME CGRectMake(BOX_WIDTH / 2 , SCREEN_HEIGHT - (BOX_HEIGHT - 1), BOX_WIDTH, BOX_HEIGHT)

- (id)init
{
    self = [super initWithFrame:BOX_FRAME];
    if (self) {
        
        self.frame = BOX_FRAME;
        
        [self initUI];
        
        self.userInteractionEnabled = FALSE;
        
        [self addTarget:self action:@selector(nextDialog:) forControlEvents:UIControlEventTouchDown];
        [self addListener:EVENT_NPC_START_CONVO andSel:@selector(showConversation:)];
    }
    return self;
}

-(void)initUI
{
    self.layer.borderWidth = 1.0f;
    self.layer.borderColor = [UIColor colorWithRed:207.0f/255.0f green:207.0f/255.0f blue:207.0f/255.0f alpha:0.5].CGColor;

    self.alpha = 0.0;
    self.backgroundColor = [UIColor blackColor];
    self.layer.frame = CGRectMake((SCREEN_WIDTH - BOX_WIDTH)/2 , SCREEN_HEIGHT, BOX_WIDTH, BOX_HEIGHT);
    
    currentIndex = 0;
    
    npcName = [[BaseLabel alloc] initWithFrame:CGRectMake(8, 8, self._width, 12)];
    npcName.font = [UIFont fontWithName:FONT_DEFAULT size:12.0];
    npcName.numberOfLines = 0;
    npcName.lineBreakMode = UILineBreakModeWordWrap;
    
    npcName.textColor = [UIColor redColor];
    
    npcName.layer.opacity = 0.0;
    
    
    textBox = [[BaseLabel alloc] initWithFrame:CGRectMake(0, 12, self._width*0.87, 63)];
    textBox._x = (self._width - textBox._width)/2;
    textBox.font = [UIFont fontWithName:FONT_DEFAULT size:11.0];
    textBox.numberOfLines = 0;
    textBox.lineBreakMode = UILineBreakModeWordWrap;
    
    textBox.textColor = [UIColor whiteColor];
    
    textBox.layer.opacity = 0.0;

    
    
    [self addSubview:textBox];
    [self addSubview:npcName];
}

- (void)showConversation:(NSNotification *)notification
{
    currentNPC = nil;
    currentNPC = (unsigned long long)[[[notification object] objectAtIndex:1]unsignedLongLongValue];
    self.userInteractionEnabled = TRUE;
    [self startConversationWithConvo:[(NSArray *)[notification object] objectAtIndex:0]];
    
}


-(void)startConversationWithConvo:(NSArray *)convo
{
    currentIndex = 0;
    if(self._convo)
        self._convo = nil;
    
    
    self._convo = [NSArray arrayWithArray:convo];
    textBox.text = [NSString stringWithString:[self._convo objectAtIndex:currentIndex]];
    npcName.text = [[npcDatabase npcFromUid:currentNPC] objectForKey:@"name"];
    
    [UIView animateWithDuration:0.75f delay:0.0 options:UIViewAnimationCurveEaseIn animations:^{
        
        
        [textBox.layer setOpacity:1.0f];
        [npcName.layer setOpacity:1.0f];
        [self setAlpha:1.0f];
        self.layer.frame = BOX_FRAME;
        
    } completion:^(BOOL done) {}];
}

-(void)nextDialog:(UIEvent *)event
{
    currentIndex++;
    [self setUserInteractionEnabled:FALSE];
    if(currentIndex == [_convo count])
    {
        [self sendEvent:[NSString stringWithFormat:@"%@_%lld",EVENT_NPC_DONE_CONVO,currentNPC]];
        [self hideConversation];
        currentNPC = nil;
        return;
    }
    
    [UIView animateWithDuration:0.5f delay:0.0 options:UIViewAnimationCurveEaseIn animations:^{
        
        [textBox.layer setOpacity:0.0f];
        
    } completion:^(BOOL done) {
        if(done) {
            [textBox setText:[_convo objectAtIndex:MIN(currentIndex, [_convo count]-1)]];
        
        [UIView animateWithDuration:0.5f delay:0.0 options:UIViewAnimationCurveEaseIn animations:^{
            
            [textBox.layer setOpacity:1.0f];
            
            
        } completion:^(BOOL done) {
        
            if(done)
                [self setUserInteractionEnabled:TRUE];        
        }];
    }
}];
    

}

-(void)hideConversation
{
    //Send Quest Event Notification
    [self sendEvent:EVENT_QUEST_TALK andObject:[NSNumber numberWithUnsignedLongLong:currentNPC]];

    [UIView animateWithDuration:0.75f delay:0.0 options:UIViewAnimationCurveEaseIn animations:^{
        
        
        [textBox.layer setOpacity:0.0f];
        [npcName.layer setOpacity:0.0f];
        [self setAlpha:0.0f];
        self.layer.frame = CGRectMake((SCREEN_WIDTH - BOX_WIDTH)/2 , SCREEN_HEIGHT, BOX_WIDTH, BOX_HEIGHT);
        
    } completion:^(BOOL done) {
       
        
    }];

}

-(void)dealloc
{
    [self destroyAndRemove:textBox];
    [self destroyAndRemove:npcName];
    
    [self destroy:self._convo];
    
    [super dealloc];
}
@end
