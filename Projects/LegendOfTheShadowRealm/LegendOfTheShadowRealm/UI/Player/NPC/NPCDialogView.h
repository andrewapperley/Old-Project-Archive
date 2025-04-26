//
//  NPCDialogView.h
//  LegendOfTheShadowRealm
//
//  Created by Andrew Apperley on 2013-02-06.
//
//

#import "BaseButton.h"

@class BaseLabel;

@interface NPCDialogView : BaseButton
{
    BaseLabel *textBox;
    BaseLabel *npcName;
    int currentIndex;
    unsigned long long currentNPC;
}

-(void)startConversationWithConvo:(NSArray *)convo;

@property (nonatomic, retain)NSArray *_convo;

@end
