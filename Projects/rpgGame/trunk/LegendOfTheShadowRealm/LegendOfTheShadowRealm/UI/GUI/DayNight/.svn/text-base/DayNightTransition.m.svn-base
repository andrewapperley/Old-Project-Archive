//
//  DayNightTransition.m
//  LegendOfTheShadowRealm
//
//  Created by Andrew Apperley on 2013-01-29.
//
//

#import "DayNightTransition.h"
#import "Constants.h"
#import <QuartzCore/QuartzCore.h>
@implementation DayNightTransition
@synthesize dayNightTimer;

#define FULLDAY 3600

- (id)initWithFrame:(CGRect)frame andImage:(UIImage *)image
{
    self = [super initWithFrame:(CGRect)frame];
    if (self) {
        
        dayCount = 0;
        dayTime = 0;
        goBack = FALSE;
        self.layer.opacity = 0;
        self.layer.contents = (UIImage *)image.CGImage;
    }
    return self;
}

-(void)startDayTimer
{
   dayNightTimer = [NSTimer scheduledTimerWithTimeInterval:180.0 target:self selector:@selector(increaseTime) userInfo:nil repeats:TRUE];
}

-(void)stopDayTimer
{
    [dayNightTimer invalidate];
    dayNightTimer = nil;
}

-(void)increaseTime
{
    if(dayTime >= FULLDAY)
        dayCount = 1;
    
    goBack = (dayCount == 1);
    
    if(goBack && dayTime <= 0)
        dayCount = 0;
    
    if(!goBack)
        dayTime = dayTime + 180;
    else
        dayTime = dayTime - 180;
    
    
    self.layer.opacity = dayTime / FULLDAY;
}

-(void)dealloc
{
    [self destroy:dayNightTimer];
    [super dealloc];
}

@end