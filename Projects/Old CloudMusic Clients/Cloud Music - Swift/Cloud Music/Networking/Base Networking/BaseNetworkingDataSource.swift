//
//  BaseNetworkingDataSource.swift
//  Cloud Music
//
//  Created by Andrew Apperley on 2015-01-05.
//  Copyright (c) 2015 Andrew Apperley. All rights reserved.
//

import UIKit

enum NetworkRequestType {
    case NetworkRequestType_POST
    case NetworkRequestType_GET
}

let kBaseNetworkingParamsKey = "params"
let kBaseNetworkingStatusKey = "status"
let kBaseNetworkingMessageKey = "message"
let kBaseNetworkingHTTPCodeKey = "HTTP_Code"

class BaseNetworkingDataSource: NSObject {
    
    let manager = AFHTTPSessionManager(baseURL: NSURL(string: kCMBaseNetworkURLString))
    var once_token : dispatch_once_t = 0
    
    func makeRequest(type: NetworkRequestType, endpoint: String, params: Dictionary<String, AnyObject>?, success: (task: NSURLSessionDataTask, responseObject: AnyObject) -> (), failure: (task: NSURLSessionDataTask, error: NSError) -> ()) -> NSURLSessionDataTask? {
        
        dispatch_once(&self.once_token, { () -> Void in
            //Response serializer
            var responseSerializer = AFJSONResponseSerializer(readingOptions: NSJSONReadingOptions.AllowFragments)
            responseSerializer.acceptableContentTypes = NSSet(object: "application/json")
            self.manager.responseSerializer = responseSerializer
            
            //Request serializer
            var requestSerializer = AFJSONRequestSerializer(writingOptions: NSJSONWritingOptions.PrettyPrinted)
            self.manager.requestSerializer = requestSerializer
        })
        
        switch type {
            case .NetworkRequestType_POST:
                return POSTRequestWithSessionMananger(endpoint, params: params, success, failure)
            case .NetworkRequestType_GET:
                return GETRequestWithSessionMananger(endpoint, params: params, success: success, failure: failure)
        }
    }
    
    private func POSTRequestWithSessionMananger(endpoint: String, params: Dictionary<String, AnyObject>?, success: (task: NSURLSessionDataTask, responseObject: AnyObject) -> (), failure: (task: NSURLSessionDataTask, error: NSError) -> ()) -> NSURLSessionDataTask {
        var _params: Dictionary<String, AnyObject>?
        if ((params) != nil) {
            _params = [kBaseNetworkingParamsKey: params!]
        } else {
            _params = params
        }
        
        return self.manager.POST(endpoint, parameters: _params, success: { (task, responseObject) -> Void in
            success(task: task, responseObject: responseObject)
        }, failure: { (task, error) -> Void in
            failure(task: task, error: error)
        })
    }
    
    private func GETRequestWithSessionMananger(endpoint: String, params: Dictionary<String, AnyObject>?, success: (task: NSURLSessionDataTask, responseObject: AnyObject) -> (), failure: (task: NSURLSessionDataTask, error: NSError) -> ()) -> NSURLSessionDataTask {
        return self.manager.GET(endpoint, parameters: params, success: { (task, responseObject) -> Void in
            success(task: task, responseObject: responseObject)
            }, failure: { (task, error) -> Void in
                failure(task: task, error: error)
        })
    }
    
}