//
//  Proc.h
//  LegendOfTheShadowRealm
//
//  Created by Jeremy Fuellert on 2013-02-04.
//
//

#import "BaseView.h"

@class ParticleSystem;

@interface Proc : BaseView
{
    @private
    ParticleSystem * particleSystem;
    NSDictionary *skill;
}

@property (nonatomic, readonly) BOOL isActive;

- (id)initWithFrame:(CGRect)frame andSkillName:(NSString *)skillName;
- (BOOL)tryForProc;
- (void)start;
- (void)stop;
- (void)changeDirection;

@end
