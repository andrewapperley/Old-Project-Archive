//
//  BasePlayer.h
//  LegendOfTheShadowRealm
//
//  Created by Jeremy Fuellert on 2012-12-10.
//
//

#import "BaseImage.h"
#import "Constants.h"

@interface BasePlayer : BaseImage
{    
    @protected
    NSTimer *timer;

    BOOL _isWalking;
    BOOL _isRunning;
    
    @private
    NSMutableSet *images;
}

@property (nonatomic, readonly)NSString *prefix;
@property (nonatomic, assign)uint direction;
@property (nonatomic, retain)NSString *action;
@property (nonatomic, assign)int state;
@property (nonatomic, assign)uint numberOfStates;
@property (nonatomic, retain)NSArray *activeSkills;

@property (nonatomic, assign) unsigned long long uid;
@property (nonatomic, assign) int boundsX;
@property (nonatomic, assign) int boundsY;
@property (nonatomic, assign) float speed;
@property (nonatomic, assign) float directionChangeTime;
@property (nonatomic, assign) float radius;
@property (nonatomic, retain) NSString *map;
@property (nonatomic, retain) NSString *zone;

@property (nonatomic, readonly) BOOL isWalking;
@property (nonatomic, readonly) BOOL isRunning;

- (void)startWalk;
- (void)startRun;
- (void)idle;
- (void)stop;
- (void)refreshImage;
- (void)incrementState;
- (void)decrementState;

@end
