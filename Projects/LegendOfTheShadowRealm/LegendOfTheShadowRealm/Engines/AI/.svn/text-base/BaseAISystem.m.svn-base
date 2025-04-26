//
//  BaseAISystem.m
//  LegendOfTheShadowRealm
//
//  Created by Andrew Apperley on 2012-12-13.
//
//

#import "BaseAISystem.h"

@implementation BaseAISystem
@synthesize isBlockedByPlayer;

- (void)changeRandomDirection
{
    [self setDirection:[self checkChangeDirection]];
    [self alterPointToDirection];
}

- (uint)checkChangeDirection
{
    uint oldDirection = self.direction;
    uint newDirection = (uint)arc4random_uniform(DIRECTION_COUNT);
    
    while (oldDirection == newDirection || newDirection == Idle)
    {
        newDirection = (uint)arc4random_uniform(DIRECTION_COUNT);
    }
    return newDirection;
}


- (void)alterPointToDirection
{
    switch (self.direction) {
        case NorthWest:
            movePoint = CGPointMake( self.speed, self.speed);
            break;
        case North:
            movePoint = CGPointMake(0.0, self.speed);
            break;
        case NorthEast:
            movePoint = CGPointMake( -self.speed, self.speed);
            break;
        case West:
            movePoint = CGPointMake( self.speed, 0.0);
            break;
        case Idle:
            [self changeRandomDirection];
            break;
        case East:
            movePoint = CGPointMake( -self.speed, 0.0);
            break;
        case SouthWest:
            movePoint = CGPointMake( self.speed, -self.speed);
            break;
        case South:
            movePoint = CGPointMake(0.0, -self.speed);
            break;
        case SouthEast:
            movePoint = CGPointMake( -self.speed, -self.speed);
            break;
            movePoint = CGPointZero;
        default:
            break;
    }
}

- (void)increaseSpeed
{
    self.speed = MIN(self.speed + 0.5, MAX_VELOCITY * 2);
}

- (void)decreaseSpeed
{
    self.speed = MIN(self.speed - 0.5, - MAX_VELOCITY * 2);
}

- (void)setOpposingDirectionToPlayer:(BasePlayer *)lplayer
{
    BasePlayer *player = [lplayer retain];
    
    switch (player.direction) {
        case North:
        case South:
        case Idle:
            if(self.frame.origin.y > player.frame.origin.y)
                self.direction = North;
            else
                self.direction = South;
            break;
        case East:
        case West:
            if(self.frame.origin.x > player.frame.origin.x)
                self.direction = West;
            else
                self.direction = East;
            break;
        case NorthEast:
        case NorthWest:
        case SouthWest:
        case SouthEast:
            if(self.frame.origin.x > player.frame.origin.x && self.frame.origin.y > player.frame.origin.y)
                self.direction = NorthWest;
            else if(self.frame.origin.x < player.frame.origin.x && self.frame.origin.y > player.frame.origin.y)
                self.direction = NorthEast;
            else if(self.frame.origin.x < player.frame.origin.x && self.frame.origin.y < player.frame.origin.y)
                self.direction = SouthEast;
            else
                self.direction = SouthWest;
            break;
    }
    
    [self destroy:player];
}

@end
