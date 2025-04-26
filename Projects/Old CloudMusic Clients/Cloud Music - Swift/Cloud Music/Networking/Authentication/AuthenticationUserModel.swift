//
//  AuthenticationUserModel.swift
//  Cloud Music
//
//  Created by Andrew Apperley on 2015-01-08.
//  Copyright (c) 2015 Andrew Apperley. All rights reserved.
//

import UIKit

class AuthenticationUserModel: NSObject {
    
    var account_id : String?
    var session_id : String?
    var offset : Int?
    var finalized : Bool = false
    var signed_in : Bool = false
    
    func createPasswordHash() -> String {
        return ""
    }
    
    func toJSON() -> String {
        return "".stringByAppendingFormat("{'account_id': %s, 'session_id': %s, 'offset': 0, 'finalized': %i, 'signed_in': %i}", self.account_id!, self.session_id!, self.finalized, self.signed_in)
    }
    
}
