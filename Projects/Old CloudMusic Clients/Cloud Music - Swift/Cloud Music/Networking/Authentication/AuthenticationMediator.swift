//
//  AuthenticationMediator.swift
//  Cloud Music
//
//  Created by Andrew Apperley on 2015-01-06.
//  Copyright (c) 2015 Andrew Apperley. All rights reserved.
//

import UIKit

enum AuthenticationMediatorCurrentStage {
    case None
    case Create_Account
    case Finalize_Account
    case Sign_On
    case Authenticate_Account
}

let kAuthenticationResonseObjectKeyAccountId = "account_id"
let kAuthenticationResonseObjectKeySessionId = "session_id"
let kAuthenticationResonseObjectKeyPasswordHash = "password_hash"
let kAuthenticationResonseObjectKeyOffset = "offset"

let kAuthenticationCurrentUserKey = "AuthenticationCurrentUser"

public class AuthenticationMediator: NSObject {
    
    var current_user : AuthenticationUserModel = AuthenticationUserModel()
    var request_queue : NSOperationQueue = NSOperationQueue()
    var current_stage : AuthenticationMediatorCurrentStage = AuthenticationMediatorCurrentStage.None
    
    override init() {
        super.init()
        self.current_user = self.saved_current_user()
        request_queue.maxConcurrentOperationCount = 1
    }
    
    public func login(completion: (success: Bool, error: NSError?) -> ()) {
        let dataSource = AuthenticationDataSource()
        if (!self.current_user.signed_in && self.current_stage != AuthenticationMediatorCurrentStage.Authenticate_Account) {
            if(self.current_user.account_id == "" || self.current_user.account_id == nil) {
                dataSource.createAccount({ (task, responseObject) -> () in
                    if (responseObject[kBaseNetworkingStatusKey] as Bool) {
                        self.current_user.account_id = responseObject[kAuthenticationResonseObjectKeyAccountId] as? String
                        self.current_user.session_id = responseObject[kAuthenticationResonseObjectKeySessionId] as? String
                        self.current_user.offset = responseObject[kAuthenticationResonseObjectKeyOffset] as? Int
                        self.current_stage = AuthenticationMediatorCurrentStage.Finalize_Account
                        self.login(completion)
                    } else {
                        completion(success: false, error: nil)
                    }
                    
                    }, failure: { (task, error) -> () in
                        completion(success: false, error: error)
                })
            } else {
                if (self.current_user.finalized) {
                    let params : [String: AnyObject!] = [
                        kAuthenticationResonseObjectKeyAccountId: self.current_user.account_id
                    ]
                    dataSource.signIntoAccount(params, success: { (task, responseObject) -> () in
                        if (responseObject[kBaseNetworkingStatusKey] as Bool) {
                            self.current_user.account_id = responseObject[kAuthenticationResonseObjectKeyAccountId] as? String
                            self.current_user.session_id = responseObject[kAuthenticationResonseObjectKeySessionId] as? String
                            self.current_user.offset = responseObject[kAuthenticationResonseObjectKeyOffset] as? Int
                            self.current_stage = AuthenticationMediatorCurrentStage.Authenticate_Account
                            self.login(completion)
                        } else {
                            completion(success: false, error: nil)
                        }
                    }, failure: { (task, error) -> () in
                        completion(success: false, error: error)
                    })
                } else {
                    let params : [String: AnyObject!] = [
                        kAuthenticationResonseObjectKeyAccountId: self.current_user.account_id,
                        kAuthenticationResonseObjectKeySessionId: self.current_user.session_id,
                        kAuthenticationResonseObjectKeyPasswordHash: self.current_user.createPasswordHash()
                    ]
                    dataSource.finalizeAccount(
                        params, success: { (task, responseObject) -> () in
                            if (responseObject[kBaseNetworkingStatusKey] as Bool) {
                                self.current_user.account_id = responseObject[kAuthenticationResonseObjectKeyAccountId] as? String
                                self.current_user.session_id = nil
                                self.current_user.offset = nil
                                self.current_user.finalized = true
                                self.current_stage = AuthenticationMediatorCurrentStage.Sign_On
                                self.login(completion)
                            } else {
                                completion(success: false, error: nil)
                            }
                        }, failure: { (task, error) -> () in
                            completion(success: false, error: nil)
                    })
                }
                
            }
        } else {
            if (self.current_user.finalized && (self.current_user.account_id) != nil && (self.current_user.session_id) != nil && (self.current_user.offset) != nil) {
                let params : [String: AnyObject!] = [
                    kAuthenticationResonseObjectKeyAccountId: self.current_user.account_id,
                    kAuthenticationResonseObjectKeySessionId: self.current_user.session_id,
                    kAuthenticationResonseObjectKeyPasswordHash: self.current_user.createPasswordHash()
                ]
                dataSource.authenticateAccount(params, success: { (task, responseObject) -> () in
                    if (responseObject[kBaseNetworkingStatusKey] as Bool) {
                        self.current_user.account_id = responseObject[kAuthenticationResonseObjectKeyAccountId] as? String
                        self.current_user.session_id = responseObject[kAuthenticationResonseObjectKeySessionId] as? String
                        self.current_user.offset = nil
                        self.current_user.signed_in = true
                        self.current_stage = AuthenticationMediatorCurrentStage.None
                        self.save_current_user()
                        completion(success: true, error: nil)
                    }
                }, failure: { (task, error) -> () in
                    completion(success: false, error: error)
                })
            }
        }
    }
    
    public func logout(completion: (success: Bool, error: NSError?) -> ()) {
        if (self.loggedIn()) {
            let dataSource = AuthenticationDataSource()
            let params : [String: AnyObject!] = [
                kAuthenticationResonseObjectKeyAccountId: self.current_user.account_id,
                kAuthenticationResonseObjectKeySessionId: self.current_user.session_id,
                kAuthenticationResonseObjectKeyPasswordHash: self.current_user.createPasswordHash()
            ]
            dataSource.signOutOfAccount(params, success: { (task, responseObject) -> () in
                completion(success: responseObject[kBaseNetworkingStatusKey] as Bool, error: nil)
            }, failure: { (task, error) -> () in
                completion(success: false, error: error)
            })
        } else {
            completion(success: false, error: nil)
        }
        
    }
    
    public func loggedIn() -> Bool {
        return self.current_user.signed_in
    }
    
    private func save_current_user() {
        NSUserDefaults.standardUserDefaults().setObject(self.current_user.toJSON(), forKey: kAuthenticationCurrentUserKey)
    }
    
    private func saved_current_user() -> AuthenticationUserModel {
        var error: NSError?
        var user: AuthenticationUserModel? = NSJSONSerialization.JSONObjectWithData(NSUserDefaults.standardUserDefaults().objectForKey(kAuthenticationCurrentUserKey), options: NSJSONReadingOptions.AllowFragments, error: &error) as? AuthenticationUserModel
        if (user == nil) {
            user = AuthenticationUserModel()
        }
        return user!
    }
    
}