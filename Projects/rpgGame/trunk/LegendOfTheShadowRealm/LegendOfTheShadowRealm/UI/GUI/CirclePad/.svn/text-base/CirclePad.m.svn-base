//
//  CirclePad.m
//  LegendOfTheShadowRealm
//
//  Created by Jeremy Fuellert on 2012-12-02.
//
//

#import "BaseImage.h"
#import "Constants.h"
#import "CirclePad.h"
#import "InteractionLayer.h"
#import "Player.h"
#import "Shell.h"

#define MAX_DIVISIONS 3
#define WIDTH_SEGMENT           self._width / MAX_DIVISIONS
#define HEIGHT_SEGMENT          self._height / MAX_DIVISIONS
#define WIDTH_SEGMENT_CENTER    WIDTH_SEGMENT / MAX_DIVISIONS
#define HEIGHT_SEGMENT_CENTER   HEIGHT_SEGMENT / MAX_DIVISIONS

#define Grid(valueH, valueV) CGRectMake(WIDTH_SEGMENT * valueH, HEIGHT_SEGMENT * valueV, WIDTH_SEGMENT, HEIGHT_SEGMENT)
#define CenterGrid(valueH, valueV) CGRectMake(WIDTH_SEGMENT_CENTER * valueH, HEIGHT_SEGMENT_CENTER * valueV, WIDTH_SEGMENT_CENTER, HEIGHT_SEGMENT_CENTER)

#define CENTER_GRID 0

@implementation CirclePad

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initCirclePad];
    }
    return self;
}

- (void)initCirclePad
{
    self.layer.contents = (id)[UIImage imageNamed:ASSET_VISUAL_MAIN_GUI_THUMBSTICK_BACKGROUND].CGImage;
    
    thumbImage = [[BaseImage alloc]initWithOrigin:CGPointZero andImage:[UIImage imageNamed:ASSET_VISUAL_MAIN_GUI_THUMBSTICK_FOREGROUND]];
    thumbImage.userInteractionEnabled = FALSE;
    thumbImage._x = (self._width - thumbImage._width) / 2;
    thumbImage._y = (self._height - thumbImage._height) / 2;
    
    [self addSubview:thumbImage];
}

/*
 * Handle touches
 */
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self stopMovement];

    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:touches forKey:@"touches"];
    
    if(![timer isValid] && timer == nil)
        timer = [NSTimer scheduledTimerWithTimeInterval:0.0170/60 target:self selector:@selector(moveMapEvent:) userInfo:userInfo repeats:YES];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self touchesBegan:touches withEvent:event];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self stopMovementAndAnimate:TRUE];
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self stopMovementAndAnimate:TRUE];
}

//Send movement
- (void)moveMapEvent:(NSNotification *)ltouches
{
    NSSet *touches = [[ltouches userInfo] objectForKey:@"touches"];
    CGPoint touchLocation = [[touches anyObject] locationInView:self];
    
    //Check if touch is out of view
    BOOL outRight = touchLocation.x > self._x + self._width - (thumbImage._width / 2) - 16;
    BOOL outLeft = touchLocation.x < self._x + (thumbImage._width / 2) - 14;
    BOOL outDown = touchLocation.y > self._height - (thumbImage._height / 2) - 1;
    BOOL outUp = touchLocation.y < thumbImage._height / 2;
    
    if(outRight || outLeft || outDown || outUp)
    {
        [self stopMovementAndAnimate:TRUE];
        return;
    }
    
    thumbImage._x = touchLocation.x - (thumbImage._width / 2);
    thumbImage._y = touchLocation.y - (thumbImage._height / 2);
    
    //Make a center point for touch to be translated onto map
    touchLocation.x -=  self._width / 2 - 10;
    touchLocation.y -= self._height / 2 - 10;
    
    //Check direction
    [self checkDirection:touchLocation];
    
    //Make a suitable velocity to be used for map movement
    touchLocation.x /= VELOCITY_DIVISION;
    touchLocation.y /= VELOCITY_DIVISION;
    
    if(run)
    {
        touchLocation.x *= 2;
        touchLocation.y *= 2;
    }
    
    [self moveMapWithVelocity:touchLocation];
}

//Check player sprite direction
- (void)checkDirection:(CGPoint)touchLocation
{    
    int direction = 0;
    
    //Make a special case for the center grid so there isn't a large idle zone. The center grid has to be divided to allow more precise directional handling.
    if(CGRectContainsPoint(Grid(CENTER_GRID, CENTER_GRID), touchLocation))
    {        
        for(int x = -1; x < MAX_DIVISIONS - 1; x++)
        {
            for(int y = -1; y < MAX_DIVISIONS - 1; y++)
            {
                direction ++;
                
                if(CGRectContainsPoint(CenterGrid(y, x), touchLocation))
                {
                    if(direction == Idle)
                    {
                        [[[[Shell shell] battleSystem] playerObject] idle];
                        
                        run = FALSE;
                        return;
                    }

                    if([[[[Shell shell] battleSystem] playerObject] direction] != direction)
                        [[[[Shell shell] battleSystem] playerObject] setDirection:direction];
                    
                    run = FALSE;
                    return;
                }
            }
        }
    } else {
        for(int x = -1; x < MAX_DIVISIONS -1; x++)
        {
            for(int y = -1; y < MAX_DIVISIONS - 1; y++)
            {
                direction ++;
                
                if(CGRectContainsPoint(Grid(y, x), touchLocation))
                {
                    if([[[[Shell shell] battleSystem] playerObject] direction] != direction)
                        [[[[Shell shell] battleSystem] playerObject] setDirection:direction];
                    
                    run = TRUE;
                    return;
                }
            }
        }
    }
}

- (void)moveMapWithVelocity:(CGPoint)location
{
    [self sendEventOnce:EVENT_PLAYER_ANIMATION_START andObject:[NSNumber numberWithBool:run]];
    [self sendEventOnce:EVENT_CIRCLEPAD_MOVE_START andObject:[NSValue valueWithCGPoint:location]];
}

//Stop movement
- (void)stopMovement
{
    [self stopMovementAndAnimate:FALSE];
}

- (void)stopMovementAndAnimate:(BOOL)animate
{
    [self sendEvent:EVENT_PLAYER_ANIMATION_STOP];
    [self sendEvent:EVENT_CIRCLEPAD_MOVE_STOP];
    
    [timer invalidate];
    timer = nil;
    
    if(!animate) return;
    
    [UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        
        thumbImage._x = (self._width - thumbImage._width) / 2;
        thumbImage._y = (self._height - thumbImage._height) / 2;
        
    } completion:^(BOOL finished) {}];
}

- (void)dealloc
{

    [self destroy:thumbImage];
    [super dealloc];
}

@end
