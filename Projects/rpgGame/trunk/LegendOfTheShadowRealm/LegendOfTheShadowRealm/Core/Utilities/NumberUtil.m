//
//  NumberUtil.m
//  LegendOfTheShadowRealm
//
//  Created by Jeremy Fuellert on 2013-03-10.
//
//

#import "NumberUtil.h"

@implementation NumberUtil

+ (int)numberOfDigits:(NSNumber *)number
{
    unsigned long long num = [number unsignedLongLongValue];
    int returnNumber = 0;
    
    while(num > 0)
    {
        num %= 10;
        returnNumber ++;
    }
    
    return returnNumber;
}

@end
