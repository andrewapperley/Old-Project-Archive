//
//  BaseObject.h
//  LegendOfTheShadowRealm
//
//  Created by Andrew Apperley on 2012-11-17.
//
//

#import <Foundation/Foundation.h>
#import "EventCenter.h"

@interface BaseObject : NSObject<EventCenter>

- (void)destroy;
- (void)destroy:(id)object;

@end

