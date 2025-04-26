//
//  BaseVideoPlayer.m
//  LegendOfTheShadowRealm
//
//  Created by Andrew Apperley on 2013-03-03.
//
//

#import "BaseVideoPlayer.h"

@implementation BaseVideoPlayer

@synthesize isPreparedToPlay, currentPlaybackRate, currentPlaybackTime, _videoPlayer;

- (id)initWithFrame:(CGRect)frame andVideoFile:(NSURL *)_video
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;

        
        [self addListener:MPMoviePlayerReadyForDisplayDidChangeNotification andSel:@selector(MPMoviePlayerLoadStateDidChange:) andSender:_videoPlayer];

        _videoPlayer = [[MPMoviePlayerViewController alloc] initWithContentURL:_video];
        _videoPlayer.view.frame = self.frame;
        _videoPlayer.moviePlayer.shouldAutoplay=YES;
        _videoPlayer.moviePlayer.scalingMode = MPMovieScalingModeAspectFill;
        _videoPlayer.moviePlayer.controlStyle = MPMovieControlStyleNone;
        _videoPlayer.moviePlayer.repeatMode = YES;
        [_videoPlayer.moviePlayer setFullscreen:YES animated:NO];
        [self addSubview:_videoPlayer.view];
        [_videoPlayer.moviePlayer prepareToPlay];
        
    }
    return self;
}

- (void)MPMoviePlayerLoadStateDidChange:(NSNotification *)notification
{
    
    if ((_videoPlayer.moviePlayer.loadState & MPMovieLoadStatePlaythroughOK) == MPMovieLoadStatePlaythroughOK) {
        isPreparedToPlay = TRUE;
        [_videoPlayer.moviePlayer play];
    }
}

//Delegate Functions
-(void)play
{
    [_videoPlayer.moviePlayer play];
}

-(void)pause
{
    [_videoPlayer.moviePlayer pause];
}

-(void)stop
{
    [_videoPlayer.moviePlayer stop];
}

-(void)prepareToPlay
{
    [_videoPlayer.moviePlayer prepareToPlay];
}

-(void)beginSeekingBackward
{
    [_videoPlayer.moviePlayer beginSeekingBackward];
}

-(void)beginSeekingForward
{
    [_videoPlayer.moviePlayer beginSeekingForward];
}

-(void)endSeeking
{
    [_videoPlayer.moviePlayer endSeeking];
}

-(void)dealloc
{
    [self destroy:_videoPlayer];
    [self removeAllEvents];
    [super dealloc];
}
@end
