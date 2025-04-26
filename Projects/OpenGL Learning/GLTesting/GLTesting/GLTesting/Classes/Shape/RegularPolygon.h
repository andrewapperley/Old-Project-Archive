//
//  RegularPolygon.h
//  GLTesting
//
//  Created by Andrew Apperley on 2013-07-10.
//  Copyright (c) 2013 Andrew Apperley. All rights reserved.
//

#import "BaseShape.h"

@interface RegularPolygon : BaseShape


@property(readonly) int numSides;
@property float radius;

- (id)initWithNumSides:(int)numSides;

@end