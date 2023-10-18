//
//  LoginViewController.swift
//  MovieApp
//
//  Created by AsherFelix on 08/10/2023.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var segemented: UISegmentedControl!
    @IBOutlet weak var loginPhoneSemented: UIView!
    @IBOutlet weak var loginEmailSemented: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func sementedChange(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            self.view.bringSubviewToFront(loginEmailSemented)
        case 1:
            self.view.bringSubviewToFront(loginPhoneSemented)
        default:
            break
        }
    }
    
   

}
