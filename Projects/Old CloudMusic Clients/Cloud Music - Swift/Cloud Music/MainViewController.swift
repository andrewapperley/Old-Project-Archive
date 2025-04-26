//
//  MainViewController.swift
//  Cloud Music
//
//  Created by Andrew Apperley on 2015-01-04.
//  Copyright (c) 2015 Andrew Apperley. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.redColor()
        var authM = AuthenticationMediator()
        authM.login { (success, error) -> () in
            
        }
    }

}