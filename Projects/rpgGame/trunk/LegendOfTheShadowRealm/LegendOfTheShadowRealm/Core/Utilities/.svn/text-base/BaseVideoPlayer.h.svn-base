//
//  BaseVideoPlayer.h
//  LegendOfTheShadowRealm
//
//  Created by Andrew Apperley on 2013-03-03.
//
//

#import "BaseView.h"
#import <MediaPlayer/MediaPlayer.h>
@interface BaseVideoPlayer : BaseView<MPMediaPlayback>

- (id)initWithFrame:(CGRect)frame andVideoFile:(NSURL *)_video;

-(void)play;
-(void)pause;
-(void)stop;
-(void)prepareToPlay;
-(void)beginSeekingBackward;
-(void)beginSeekingForward;
-(void)endSeeking;

@property(nonatomic,retain)MPMoviePlayerViewController *_videoPlayer;

@end