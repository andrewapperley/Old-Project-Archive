//
//  AFFMiscMacros.h
//  AFFramework
//
//  Created by Jeremy Fuellert on 2013-04-07.
//  Copyright (c) 2013 AFFramework. All rights reserved.
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

#define UserDefaults                        [NSUserDefaults standardUserDefaults]
#define NotificationCenter                  [NSNotificationCenter defaultCenter]
#define Bundle                              [NSBundle mainBundle]
#define MainScreen                          [UIScreen mainScreen]
#define ScreenWidth                         [[UIScreen mainScreen] bounds].size.width
#define ScreenHeight                        [[UIScreen mainScreen] bounds].size.height
#define SystemVersion                       [[UIDevice currentDevice].systemVersion floatValue]
#define DEGREES_TO_RADIANS(x)               (M_PI * x / 180.0) 
#define RGB(r, g, b)                        [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]
#define RGBA(r, g, b, a)                    [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define HEXCOLOR(c, a)                      [UIColor colorWithRed:((c>>16)&0xFF)/255.0 green:((c>>8)&0xFF)/255.0 blue:(c&0xFF)/255.0 alpha:a]
#define AFFLogObject(o,m)                     NSLog(@"\nLog Message: %@\nFunction: %s \nLine: %d \nObject:%@",m, __func__, __LINE__, o)
#define AFFLog(m)                            NSLog(@"\nLog Message: %@\nFunction: %s \nLine: %d",m, __func__, __LINE__)

//Center an object relative to it's container
#define CENTER_OBJECT_X($object, $container)                                                \
    [$object setAffX:($container.bounds.size.width - $object.bounds.size.width) / 2 ]

#define CENTER_OBJECT_Y($object, $container)                                                \
    [$object setAffY:($container.bounds.size.height - $object.bounds.size.height) / 2 ]

#define CENTER_OBJECT($object, $container)                                                  \
    [$object setAffX:($container.bounds.size.width - $object.bounds.size.width) / 2 ];      \
    [$object setAffY:($container.bounds.size.height - $object.bounds.size.height) / 2 ]
