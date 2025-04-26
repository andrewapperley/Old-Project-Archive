//
//  AFFCleanup.h
//  AFFramework
//
//  Created by Jeremy Fuellert on 2013-04-07.
//  Copyright (c) 2013 AFFramework. All rights reserved.
//

#define destroy($x)                                             \
if($x)                                                          \
{                                                               \
    [$x release];                                               \
    $x = nil;                                                   \
}

#define destroyAndRemove($x)                                    \
if($x)                                                          \
{                                                               \
    [$x removeFromSuperview];                                   \
    [$x release];                                               \
    $x = nil;                                                   \
}

#define removeAllSubviews($x)                                   \
if($x && $x.subviews.count > 0)                                 \
{                                                               \
    while ($x.subviews.count > 0)                               \
        [[$x.subviews objectAtIndex:0] removeFromSuperview];    \
}