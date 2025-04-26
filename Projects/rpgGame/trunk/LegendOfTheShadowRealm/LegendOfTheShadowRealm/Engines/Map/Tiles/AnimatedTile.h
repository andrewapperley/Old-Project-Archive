//
//  AnimatedTile.h
//  LegendOfTheShadowRealm
//
//  Created by Andrew Apperley on 2013-03-23.
//
//

#import "Tile.h"

@interface AnimatedTile : Tile
{
    int frameCount;
    int currentFrame;
    CADisplayLink *displayLink;
}
-(Tile *)initWithTile:(int)ltileId andPoint:(CGPoint)lpoint andFrame:(CGRect)lframe;
@end
