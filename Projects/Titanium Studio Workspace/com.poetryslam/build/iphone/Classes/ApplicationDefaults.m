/**
* Appcelerator Titanium Mobile
* This is generated code. Do not modify. Your changes *will* be lost.
* Generated code is Copyright (c) 2009-2011 by Appcelerator, Inc.
* All Rights Reserved.
*/
#import <Foundation/Foundation.h>
#import "TiUtils.h"
#import "ApplicationDefaults.h"
 
@implementation ApplicationDefaults
  
+ (NSMutableDictionary*) copyDefaults
{
    NSMutableDictionary * _property = [[NSMutableDictionary alloc] init];

    [_property setObject:[TiUtils stringValue:@"7fwSUD9gJCCOBAOcAwz9vqE9qWPJJcXu"] forKey:@"acs-oauth-secret-production"];
    [_property setObject:[TiUtils stringValue:@"KOsyKg5I0LJiUjMlOsvm1Hw1TvQJTiq9"] forKey:@"acs-oauth-key-production"];
    [_property setObject:[TiUtils stringValue:@"9z6SGd7DcnaIX3RcVNWopndBVAatGFZI"] forKey:@"acs-api-key-production"];
    [_property setObject:[TiUtils stringValue:@"VE2iKTPBQ9KEaaHGAgtIrGLCSgHN670p"] forKey:@"acs-oauth-secret-development"];
    [_property setObject:[TiUtils stringValue:@"ESyERVCCibf8lSvK4JGmDkZPL10MT4UA"] forKey:@"acs-oauth-key-development"];
    [_property setObject:[TiUtils stringValue:@"y8CL7qL75F4JyrGuuJsscJAjCIZ9Cqfy"] forKey:@"acs-api-key-development"];

    return _property;
}
@end
