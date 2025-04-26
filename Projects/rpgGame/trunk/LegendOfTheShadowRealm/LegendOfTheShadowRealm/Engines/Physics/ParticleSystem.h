//
//  ParticleSystem.h
//  LegendOfTheShadowRealm
//
//  Created by Andrew Apperley on 2013-01-02.
//
//

#import <QuartzCore/QuartzCore.h>

@interface ParticleSystem : CALayer
{
    CAEmitterLayer *emitter;
    CAEmitterCell *particle;
    float angle;
    float lifetime;
    
    @private
    BOOL isRemoving;
}

@property (nonatomic, readonly) BOOL isActive;

- (void)startParticle:(NSDictionary *)particleData;
- (void)stopParticle;
- (void)changeParticleDirection;

@end
