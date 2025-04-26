//
//  AFFVector.h
//  AFFramework
//
//  Created by Andrew Apperley on 2013-04-10.
//  Copyright (c) 2013 AFFramework. All rights reserved.
//
//
//  Permission is hereby granted, free of charge, to any person
//  obtaining a copy of this software and associated documentation
//  files (the "Software"), to deal in the Software without
//  restriction, including without limitation the rights to use,
//  copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the
//  Software is furnished to do so, subject to the following
//  conditions:
//
//  The above copyright notice and this permission notice shall be
//  included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
//  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
//  OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
//  HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
//  WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
//  OTHER DEALINGS IN THE SOFTWARE.
//

#import <Foundation/Foundation.h>

#define LogVector2(v)     NSLog(@"{%f , %f}",v.x, v.y);
#define LogVector3(v)     NSLog(@"{%f , %f , %f}",v.x,v.y,v.z);


struct Vector2 {
    float x,
    y;
};

struct Vector3 {
    float x,
    y,
    z;
};

typedef struct Vector2 Vector2;
typedef struct Vector3 Vector3;

@interface AFFVector : NSObject

+ (Vector2)vectorWithX:(float)lx andY:(float)ly;
+ (Vector3)vectorWithX:(float)lx andY:(float)ly andZ:(float)lz;
+ (Vector2)addVector2:(Vector2)v1 withVector2:(Vector2)v2;
+ (Vector2)minusVector2:(Vector2)v1 withVector2:(Vector2)v2;
+ (float)magnitudeOfVector2:(Vector2)v1;
+ (float)dotProductofVector2:(Vector2)v1 andVector2:(Vector2)v2;
+ (float)angleBetweenVector2:(Vector2)v1 andVector2:(Vector2)v2;

+ (Vector3)addVector3:(Vector3)v1 withVector3:(Vector3)v2;
+ (Vector3)minusVector3:(Vector3)v1 withVector3:(Vector3)v2;
+ (float)magnitudeOfVector3:(Vector3)v1;
+ (float)dotProductofVector3:(Vector3)v1 andVector3:(Vector3)v2;
+ (float)angleBetweenVector3:(Vector3)v1 andVector3:(Vector3)v2;
@end
