//
//  BaseNPC.h
//  LegendOfTheShadowRealm
//
//  Created by Andrew Apperley on 2012-12-15.
//
//

#import "BaseAISystem.h"

@class NPCDialogView;

@interface BaseNPC : BaseAISystem
{
    @protected
    CGPoint boundsPosition;
}

@property (nonatomic, assign) int positionX;
@property (nonatomic, assign) int positionY;
@property (nonatomic, retain) NSArray *quests;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSArray *conversation;
@property (nonatomic, assign)BOOL inConversation;

- (id)initWithOrigin:(CGPoint)frame andData:(NSDictionary *)data;
- (void)startMovement;
- (void)kill;

@end
