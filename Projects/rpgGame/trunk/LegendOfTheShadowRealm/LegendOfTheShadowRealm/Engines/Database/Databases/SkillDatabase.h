//
//  SkillDatabase.h
//  LegendOfTheShadowRealm
//
//  Created by Jeremy Fuellert on 2012-12-29.
//
//

#import "DatabaseBase.h"

@interface SkillDatabase : DatabaseBase

- (NSArray *)listAllActiveSkills;
- (NSArray *)listAllPassiveSkills;

- (NSDictionary *)skillByName:(NSString *)skill;
- (NSArray *)skillsByNames:(NSArray *)skills;

//Multiplier
- (float)multiplierBySkill:(NSString *)skill;

//Emitter Width
- (float)emitterWidthBySkill:(NSString *)skill;

//Emitter Height
- (float)emitterHeightBySkill:(NSString *)skill;

//Birth Rate
- (float)birthRateBySkill:(NSString *)skill;

//Velocity
- (float)velocityBySkill:(NSString *)skill;

//Velocity Range
- (float)velocityRangeBySkill:(NSString *)skill;

//ParticleImage
- (NSString *)particleImageBySkill:(NSString *)skill;

//Particle Red
- (float)particleRedBySkill:(NSString *)skill;

//Particle Blue
- (float)particleBlueBySkill:(NSString *)skill;

//Partcle Green
- (float)particleGreenBySkill:(NSString *)skill;

//Spin
- (float)spinBySkill:(NSString *)skill;

//Emitter Shape
- (NSString *)emitterShapeBySkill:(NSString *)skill;

//Emitter Mode
- (NSString *)emitterModeBySkill:(NSString *)skill;

//Active Skill
- (BOOL)activeSkillBySkill:(NSString *)skill;

//ToolTip
- (NSString *)toolTipBySkill:(NSString *)skill;

//Description
- (NSString *)descriptionBySkill:(NSString *)skill;

//Forumla
- (NSString *)formulaBySkill:(NSString *)skill;

//Proc Chance
- (float)procChanceBySkill:(NSString *)skill;

//Lifetime
- (float)lifetimeBySkill:(NSString *)skill;

@end
