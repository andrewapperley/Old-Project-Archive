//
//  StringUtil.m
//  LegendOfTheShadowRealm
//
//  Created by Jeremy Fuellert on 2013-02-20.
//
//

#import "StringUtil.h"

@implementation StringUtil

+ (NSString *)trimString:(NSString *)string toIndexString:(NSString *)rangeString
{
    NSUInteger trimLocation = [string rangeOfString:@"="].location;
    
    if(trimLocation != NAN && trimLocation < 2147483647)
    {
        string = [string substringToIndex:trimLocation];
    }
    
    return string;
}

@end
