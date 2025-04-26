//
//  Proc.m
//  LegendOfTheShadowRealm
//
//  Created by Jeremy Fuellert on 2013-02-04.
//
//

#import "Constants.h"
#import "Database.h"
#import "ParticleSystem.h"
#import "Proc.h"

@implementation Proc
@synthesize isActive = _isActive;

- (id)initWithFrame:(CGRect)frame andSkillName:(NSString *)skillName
{
    self = [super init];
    if(self)
    {
        self.frame = frame;
        
        _isActive = FALSE;
        particleSystem = [ParticleSystem layer];        
        [self.layer addSublayer:particleSystem];
        
        [self retrieveData:skillName];
    }
    return self;
}

- (void)retrieveData:(NSString *)skillName
{
    skill = [[skillDatabase skillByName:skillName] retain];
}

//Set size of proc in tiles (approx.)
- (void)setSize:(CGSize)size andPosition:(CGPoint)point
{
    [self setFrame:CGRectMake(point.x * TILE_WIDTH, point.y * TILE_HEIGHT, size.width * TILE_WIDTH, size.height * TILE_HEIGHT)];
}

/*
 * Run abilities
 */
- (void)start
{
    [particleSystem startParticle:skill];
}

- (void)stop
{
    [particleSystem stopParticle];
}

- (BOOL)isActive
{
    return [particleSystem isActive];
}

/*
 * Returns TRUE for the skill to be proc'd
 */
- (BOOL)tryForProc
{
    float percentToProc = [(NSNumber *)[skill objectForKey:@"procChance"] floatValue];
    
    return (uint)arc4random_uniform(100) < percentToProc;
}

/*
 * Directional Handling
 */
- (void)changeDirection
{
    [particleSystem changeParticleDirection];
}

- (void)dealloc
{
    [self destroy:particleSystem];
    [self destroy:skill];
    [super dealloc];
}

@end
