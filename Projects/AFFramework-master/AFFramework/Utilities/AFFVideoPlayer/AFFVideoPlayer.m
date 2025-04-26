//
//  AFFVideoPlayer.m
//  AFFramework
//
//  Created by Andrew Apperley on 2013-03-03.
//
// This is a ready to use full screen video player with all the controls/delegate methods mapped to functions that can be accessed
// externally. Load it with a NSURL object and it just works.
//
//
//  Permission is hereby granted, free of charge, to any person
//  obtaining a copy of this software and associated documentation
//  files (the "Software"), to deal in the Software without
//  restriction, including without limitation the rights to use,
//  copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the
//  Software is furnished to do so, subject to the following
//  conditions:
//
//  The above copyright notice and this permission notice shall be
//  included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
//  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
//  OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
//  HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
//  WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
//  OTHER DEALINGS IN THE SOFTWARE.
//

#import "AFFVideoPlayer.h"
#import "ARCHelper.h"

@implementation AFFVideoPlayer

@synthesize isPreparedToPlay, currentPlaybackRate, currentPlaybackTime, _videoPlayer;

- (id)initWithFrame:(CGRect)frame andVideoFile:(NSURL *)_video
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;

        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(MPMoviePlayerLoadStateDidChange:) name:nil object:_videoPlayer];

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
    [_videoPlayer ah_release];
    _videoPlayer = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super ah_dealloc];
}
@end
