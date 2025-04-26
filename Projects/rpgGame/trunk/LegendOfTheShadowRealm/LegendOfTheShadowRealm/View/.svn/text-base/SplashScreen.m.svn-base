//
//  SplashScreen.m
//  LegendOfTheShadowRealm
//
//  Created by Andrew Apperley on 2012-11-17.
//
//

#import "SplashScreen.h"
#import <QuartzCore/QuartzCore.h>
#import "EventConstants.h"

@implementation SplashScreen

- (id)initWithFrame:(CGRect)frame andImage:(NSString *)imageString
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self loadImage:imageString];
        [self setUserInteractionEnabled:FALSE];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame andMapFile:(NSString *)mapFile
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setUserInteractionEnabled:FALSE];
        
        [self addListener:EVENT_MAP_LOADED andSel:@selector(fadeOutSplash)];
        
        [self.layer setBackgroundColor:[UIColor blackColor].CGColor];
        self.layer.opacity = 0.0;
        
        [UIView animateWithDuration:2.0 delay:0.0 options:UIViewAnimationCurveEaseInOut animations:^{
            
            
            [self.layer setOpacity:1.0];
            
        } completion:^(BOOL done){
            if(done){
                [self sendEvent:EVENT_SLASHSCREEN_UP andObject:mapFile];
                return;
            }
        }];

    }
    return self;
}

-(void)fadeOutSplash
{
    
    [UIView animateWithDuration:2.0 delay:0.0 options:UIViewAnimationCurveEaseInOut animations:^{
        
        [self.layer setOpacity:0.0];
        
    } completion:^(BOOL done){
        if(done){
            [self sendEventOnce:EVENT_SHELL_LOAD_COMPLETE];
            return;
        }
    }];

}

- (void)loadImage:(NSString*)image
{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:image]];
    [self addSubview:imageView];
    
    [self destroy:imageView];
}

-(void)dealloc
{
    [super dealloc];
}

@end
