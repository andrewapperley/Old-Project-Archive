//
//  AuthenticationDataSource.swift
//  Cloud Music
//
//  Created by Andrew Apperley on 2015-01-05.
//  Copyright (c) 2015 Andrew Apperley. All rights reserved.
//

import UIKit

let kAuthenticationCreateAccoutEndpoint = "auth/account/create"
let kAuthenticationFinalizeAccoutEndpoint = "auth/account/finalize"
let kAuthenticationSignonAccoutEndpoint = "auth/account/signOn"
let kAuthenticationAuthenticateAccoutEndpoint = "auth/account/authenticate"
let kAuthenticationSignoutAccoutEndpoint = "auth/account/logout"

class AuthenticationDataSource: BaseNetworkingDataSource {
    
    func createAccount(success: (task: NSURLSessionDataTask, responseObject: AnyObject) -> (), failure: (task: NSURLSessionDataTask, error: NSError) -> ()) -> NSURLSessionDataTask? {
        return super.makeRequest(NetworkRequestType.NetworkRequestType_POST, endpoint: kAuthenticationCreateAccoutEndpoint, params: nil, success: success, failure: failure)
    }
    
    func finalizeAccount(params: Dictionary<String, AnyObject>, success: (task: NSURLSessionDataTask, responseObject: AnyObject) -> (), failure: (task: NSURLSessionDataTask, error: NSError) -> ()) -> NSURLSessionDataTask? {
        return super.makeRequest(NetworkRequestType.NetworkRequestType_POST, endpoint: kAuthenticationFinalizeAccoutEndpoint, params: params, success: success, failure: failure)
    }
    
    func signIntoAccount(params: Dictionary<String, AnyObject>, success: (task: NSURLSessionDataTask, responseObject: AnyObject) -> (), failure: (task: NSURLSessionDataTask, error: NSError) -> ()) -> NSURLSessionDataTask? {
        return super.makeRequest(NetworkRequestType.NetworkRequestType_POST, endpoint: kAuthenticationSignonAccoutEndpoint, params: params, success: success, failure: failure)
    }
    
    func authenticateAccount(params: Dictionary<String, AnyObject>, success: (task: NSURLSessionDataTask, responseObject: AnyObject) -> (), failure: (task: NSURLSessionDataTask, error: NSError) -> ()) -> NSURLSessionDataTask? {
        return super.makeRequest(NetworkRequestType.NetworkRequestType_POST, endpoint: kAuthenticationAuthenticateAccoutEndpoint, params: params, success: success, failure: failure)
    }
    
    func signOutOfAccount(params: Dictionary<String, AnyObject>, success: (task: NSURLSessionDataTask, responseObject: AnyObject) -> (), failure: (task: NSURLSessionDataTask, error: NSError) -> ()) -> NSURLSessionDataTask? {
        return super.makeRequest(NetworkRequestType.NetworkRequestType_POST, endpoint: kAuthenticationSignoutAccoutEndpoint, params: params, success: success, failure: failure)
    }
    
}