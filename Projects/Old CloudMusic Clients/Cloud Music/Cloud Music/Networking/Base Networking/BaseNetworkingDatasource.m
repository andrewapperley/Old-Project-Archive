//
//  BaseNetworkingDatasource.m
//  Cloud Music
//
//  Created by Andrew Apperley on 2015-01-11.
//  Copyright (c) 2015 Andrew Apperley. All rights reserved.
//

#import "BaseNetworkingDatasource.h"
#import <AFNetworking/AFNetworking.h>

@implementation BaseNetworkingDatasource

- (NSURLSessionDataTask *)makeRequestWithType:(NetworkRequestType)type endpoint:(NSString *)endpoint params:(NSDictionary *)params success:(BaseNetworkingSuccess)success failure:(BaseNetworkingFailure)failure {
    
    //Setup Session Manager
    static dispatch_once_t onceToken;
    static AFHTTPSessionManager *sessionManager;
    dispatch_once(&onceToken, ^{
        sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:kBaseNetworkingBaseURL]];
        //Response serializer
        AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
        responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
        sessionManager.responseSerializer = responseSerializer;
        
        //Request serializer
        AFJSONRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializerWithWritingOptions:NSJSONWritingPrettyPrinted];
        sessionManager.requestSerializer = requestSerializer;
        
    });
    
    switch (type) {
        case NetworkRequestType_GET:
            return nil;
            break;
        case NetworkRequestType_POST:
            return nil;
            break;
    }
}

@end