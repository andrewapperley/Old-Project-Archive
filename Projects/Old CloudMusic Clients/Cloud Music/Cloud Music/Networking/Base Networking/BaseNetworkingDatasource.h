//
//  BaseNetworkingDatasource.h
//  Cloud Music
//
//  Created by Andrew Apperley on 2015-01-11.
//  Copyright (c) 2015 Andrew Apperley. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetworkingStatics.h"

@interface BaseNetworkingDatasource : NSObject

- (NSURLSessionDataTask *)makeRequestWithType:(NetworkRequestType)type endpoint:(NSString *)endpoint params:(NSDictionary *)params success:(BaseNetworkingSuccess)success failure:(BaseNetworkingFailure)failure;

@end