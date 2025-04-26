//
//  AnimatedTile.m
//  LegendOfTheShadowRealm
//
//  Created by Andrew Apperley on 2013-03-23.
//
//

#import "AnimatedTile.h"
#import "ImageCacheUtil.h"
#import "Shell.h"
#import "BattleSystem.h"
@implementation AnimatedTile

-(Tile *)initWithTile:(int)ltileId andPoint:(CGPoint)lpoint andFrame:(CGRect)lframe
{
    self = [super init];
    if(self)
    {
        //Disables all animations
        NSMutableDictionary *newActions = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                           [NSNull null], @"onOrderIn",
                                           [NSNull null], @"onOrderOut",
                                           [NSNull null], @"sublayers",
                                           //[NSNull null], @"contents",
                                           [NSNull null], @"bounds",
                                           [NSNull null], @"frame",
                                           [NSNull null], @"position",
                                           nil];
        self.actions = newActions;
        [newActions release];
        
        frameCount = 2;//will add later[[ltileObject objectForKey:@"frameCount"] intValue];
        self.point = lpoint;
        self.frame = lframe;
        self.opaque = TRUE;
        if([[UIDevice currentDevice].systemVersion floatValue] >= 6.0) {
            self.drawsAsynchronously = TRUE;
        }
                
        self.fore = TRUE;
        
        self.imageId = ltileId;
        
        currentFrame = 0;
        [self refreshAnimatedImage];
        displayLink = [[CADisplayLink displayLinkWithTarget:self selector:@selector(refreshAnimatedImage)] retain];
        [displayLink addToRunLoop:[NSRunLoop currentRunLoop]
                        forMode:NSDefaultRunLoopMode];
        displayLink.frameInterval = 15;
    }
    
    return self;
}

-(void)refreshAnimatedImage
{
    if(currentFrame > frameCount)
        currentFrame = 0;
    self.contents = (UIImage *)[ImageCacheUtil addImage:[NSString stringWithFormat:@"%d_%d",self.imageId,currentFrame] toSet:[[[Shell shell] battleSystem]tileImages] andCapacity:IMAGE_CACHE_LIMIT].CGImage;
    currentFrame++;
}

-(void)dealloc
{
    [displayLink invalidate];
    displayLink = nil;
    [super dealloc];
}

@end