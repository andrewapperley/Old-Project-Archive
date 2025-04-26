//
//  BaseViewUtilities.h
//  LegendOfTheShadowRealm
//
//  Created by Jeremy Fuellert on 2012-11-24.
//
//

#import <Foundation/Foundation.h>

#define DEGREES_TO_RADIANS(x) (M_PI * x / 180.0) 

@protocol BaseFrameUtility <NSObject>
@required

@property(nonatomic, assign)float _width;
@property(nonatomic, assign)float _height;

@property(nonatomic, assign)float _x;
@property(nonatomic, assign)float _y;

@property(nonatomic, assign)float _scaleX;
@property(nonatomic, assign)float _scaleY;

@end
