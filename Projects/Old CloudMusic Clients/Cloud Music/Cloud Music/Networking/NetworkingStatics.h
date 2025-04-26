//
//  NetworkingStatics.h
//  Cloud Music
//
//  Created by Andrew Apperley on 2015-01-11.
//  Copyright (c) 2015 Andrew Apperley. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^BaseNetworkingSuccess)(NSURLSessionDataTask *task, id responseObject);
typedef void(^BaseNetworkingFailure)(NSURLSessionDataTask *task, NSError *error);

typedef NS_ENUM(NSInteger, NetworkRequestType) {
    NetworkRequestType_POST,
    NetworkRequestType_GET
};

extern NSString *const kBaseNetworkingParamsKey;
extern NSString *const kBaseNetworkingStatusKey;
extern NSString *const kBaseNetworkingMessageKey;
extern NSString *const kBaseNetworkingHTTPCodeKey;
extern NSString *const kBaseNetworkingBaseURL;