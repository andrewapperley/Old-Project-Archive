//
//  AFFVector.m
//  AFFramework
//
//  Created by Andrew Apperley on 2013-04-10.
//  Copyright (c) 2013 AFFramework. All rights reserved.
//
// 
// This gives you access to Vector2 and Vector3 objects. It also lets you easily do
// basic calculations on/with them. Init a vector by making an AFFVector
// object call its class method of either vectorX:Y: or vectorX:Y:Z:.
// They are basic structs with floats so deallocing isn't necessary.
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

#import "AFFVector.h"



@implementation AFFVector

/*
 *
 * Vector Creation
 */

+ (Vector2)vectorWithX:(float)lx andY:(float)ly
{
    Vector2 vector;
    vector.x = lx;
    vector.y = ly;
    
    return vector;
}

+ (Vector3)vectorWithX:(float)lx andY:(float)ly andZ:(float)lz
{
    Vector3 vector;
    vector.x = lx;
    vector.y = ly;
    vector.z = lz;
    
    return vector;
}

/*
 *
 * Vector2 Math
 */

+ (Vector2)addVector2:(Vector2)v1 withVector2:(Vector2)v2
{
    Vector2 vector = {v1.x + v2.x , v1.y + v2.y};
    
    return vector;
}

+ (Vector2)minusVector2:(Vector2)v1 withVector2:(Vector2)v2
{
    Vector2 vector = {v2.x + -(v1.x), v2.y + -(v1.y)};
    
    return vector;
}

+ (float)magnitudeOfVector2:(Vector2)v1
{
    float mag = sqrtf(powf(v1.x, 2) + powf(v1.y, 2));
    
    return mag;
}

+ (float)dotProductofVector2:(Vector2)v1 andVector2:(Vector2)v2
{
    float dotProduct = (v1.x * v2.x) + (v1.y * v2.y);
    
    return ceilf(dotProduct);
}

+ (float)angleBetweenVector2:(Vector2)v1 andVector2:(Vector2)v2
{
    float mag1 = [AFFVector magnitudeOfVector2:v1];
    float mag2 = [AFFVector magnitudeOfVector2:v2];
    
    float dotProduct = [AFFVector dotProductofVector2:v1 andVector2:v2];
    
    return cosf( dotProduct / (mag1 * mag2) );
}

/*
 *
 * Vector3 Math
 */

+ (Vector3)addVector3:(Vector3)v1 withVector3:(Vector3)v2
{
    Vector3 vector = {v1.x + v2.x , v1.y + v2.y, v1.z + v2.z};
    
    return vector;
}

+ (Vector3)minusVector3:(Vector3)v1 withVector3:(Vector3)v2
{
    Vector3 vector = {v2.x + -(v1.x), v2.y + -(v1.y), v2.z + -(v1.z)};
    
    return vector;
}

+ (float)magnitudeOfVector3:(Vector3)v1
{
    float mag = sqrtf(powf(v1.x, 2) + powf(v1.y, 2) + powf(v1.z, 2));
    
    return mag;
}

+ (float)dotProductofVector3:(Vector3)v1 andVector3:(Vector3)v2
{
    float dotProduct = (v1.x * v2.x) + (v1.y * v2.y) + (v1.z * v2.z);
    
    return ceilf(dotProduct);
}

+ (float)angleBetweenVector3:(Vector3)v1 andVector3:(Vector3)v2
{
    float mag1 = [AFFVector magnitudeOfVector3:v1];
    float mag2 = [AFFVector magnitudeOfVector3:v2];
    
    float dotProduct = [AFFVector dotProductofVector3:v1 andVector3:v2];
    
    return cosf( dotProduct / (mag1 * mag2) );
}
@end
