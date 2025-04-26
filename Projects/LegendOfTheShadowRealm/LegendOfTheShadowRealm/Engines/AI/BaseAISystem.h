//
//  BaseAISystem.h
//  LegendOfTheShadowRealm
//
//  Created by Andrew Apperley on 2012-12-13.
//
//

#import "BasePlayer.h"

@interface BaseAISystem : BasePlayer
{
    @protected
    CGPoint movePoint;
}

@property (nonatomic, assign) BOOL isBlockedByPlayer;

- (void)increaseSpeed;
- (void)decreaseSpeed;
- (void)changeRandomDirection;
- (void)setOpposingDirectionToPlayer:(BasePlayer *)lplayer;

@end
