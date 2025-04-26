//
//  ParticleSystem.m
//  LegendOfTheShadowRealm
//
//  Created by Andrew Apperley on 2013-01-02.
//
//

#import "BattleSystem.h"
#import "ParticleSystem.h"
#import "Shell.h"

@implementation ParticleSystem
@synthesize isActive = _isActive;

-(id)init
{
    self = [super init];
    if(self)
    {
        emitter = [[CAEmitterLayer layer] retain];
    }
    return self;
}

/*
 * Particle Handling
 */
- (void)startParticle:(NSDictionary *)particleData
{
    _isActive = TRUE;
    self.opacity = 1.0;

    //Disables all animations
    self.actions = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                    [NSNull null], @"onOrderIn",
                    [NSNull null], @"onOrderOut",
                    [NSNull null], @"sublayers",
                    [NSNull null], @"contents",
                    [NSNull null], @"bounds",
                    [NSNull null], @"frame",
                    [NSNull null], @"position",
                          nil];
    
    lifetime = [(NSNumber *)[particleData objectForKey:@"lifetime"] floatValue];//[[particleData objectForKey:@"multiplier"]floatValue];
    
    //Create the emitter layer
    emitter.emitterSize = [[particleData objectForKey:@"emitterSize"] CGSizeValue];
    emitter.emitterMode = [particleData objectForKey:@"emitterMode"];
    emitter.emitterShape = [particleData objectForKey:@"emitterShape"];
    emitter.renderMode = kCAEmitterLayerUnordered;
    emitter.preservesDepth = TRUE;
    if([[UIDevice currentDevice].systemVersion floatValue] >= 6.0) {
        self.drawsAsynchronously = TRUE;
        [emitter setDrawsAsynchronously:TRUE];
    }
    
    //Create the emitter cell
    particle = [CAEmitterCell emitterCell];
    particle.emissionLongitude = M_PI / angle;
    particle.birthRate = [[particleData objectForKey:@"birthRate"]floatValue] * lifetime;
    particle.lifetime = lifetime;
    particle.lifetimeRange = lifetime * 2;
    particle.velocity = [[particleData objectForKey:@"velocity"] floatValue];
    particle.velocityRange = [[particleData objectForKey:@"velocityRange"]floatValue];
    particle.emissionRange = lifetime / angle * 1.01;
    particle.color = [[UIColor colorWithRed:[[particleData objectForKey:@"particleRed"]floatValue] / 255 green:[[particleData objectForKey:@"particleGreen"]floatValue] / 255 blue:[[particleData objectForKey:@"particleBlue"]floatValue] / 255 alpha:0.35] CGColor];
    particle.contents = (id)([UIImage imageNamed:[particleData objectForKey:@"particleImage"]].CGImage);
    particle.spin = [[particleData objectForKey:@"spin"]floatValue];
    particle.name = @"particle";
    
    emitter.emitterCells = [NSArray arrayWithObject:particle];
        
    [self addSublayer:emitter];
    
    [self changeParticleDirection];
    
    [self performSelector:@selector(stopParticle) withObject:nil afterDelay:lifetime * 2];
}

- (void)changeParticleDirection
{
    uint direction = [[[Shell shell] battleSystem] playerObject].direction;
    switch (direction)
    {
        case NorthWest:
            angle = -1.5;
            break;
        case North:
            angle = -2;
            break;
        case NorthEast:
            angle = -3;
            break;
        case West:
            angle = 1;
            break;
        case Idle:
            angle = 2;
            break;
        case East:
            angle = .5;
            break;
        case SouthWest:
            angle = 1.5;
            break;
        case South:
            angle = 2;
            break;
        case SouthEast:
            angle = 6;
            break;
    }
    if(direction == South || direction == SouthEast || direction == SouthWest || direction == Idle)
    {
        emitter.zPosition = 1;
    } else {
        emitter.zPosition = -1;
    }

    [emitter setValue:[NSNumber numberWithFloat:(M_PI / angle)] forKeyPath:@"emitterCells.particle.emissionLongitude"];
    [emitter setValue:[NSNumber numberWithFloat:(lifetime / angle * 1.01)] forKeyPath:@"emitterCells.particle.emissionRange"];
}

- (void)stopParticle
{
    if(!isRemoving)
    {
        isRemoving = TRUE;
        
        [UIView animateWithDuration:2.0 animations:^{
            [emitter setValue:[NSNumber numberWithFloat:0] forKeyPath:@"emitterCells.particle.birthRate"];
        }completion:^(BOOL  completed){
            _isActive = FALSE;
        }];
    }
}

- (void)dealloc
{
    [emitter removeFromSuperlayer];
    [emitter release];
    emitter = nil;
    [self removeAllAnimations];
    [super dealloc];
}

@end
