//
//  ScreenViewController.swift
//  MovieApp
//
//  Created by AsherFelix on 08/10/2023.
//

import UIKit
import FirebaseAuth
class ScreenViewController: UIViewController {
    let window = (UIApplication.shared.delegate as? AppDelegate)?.window
    @IBOutlet weak var signInBtn: UIButton!
    @IBOutlet weak var registerBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBtn()
    }
    private func setupBtn() {
        signInBtn.layer.cornerRadius = 6
        registerBtn.layer.cornerRadius = 6
    }
    
    @IBAction func signinBtn(_ sender: Any) {
        let loginVc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "LoginViewController")
        let loginNav = UINavigationController(rootViewController: loginVc)
        window?.rootViewController = loginVc
    }
    
    
    @IBAction func registerBtn(_ sender: Any) {
        let loginVc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RegisterViewController")
        window?.rootViewController = loginVc
        window?.makeKeyAndVisible()
    }
    @IBAction func guestBtn(_ sender: Any) {
        Auth.auth().signInAnonymously() { authResult,error in
            if let error = error {
                print("Dang nhap khach that bai")
            }else {
                print("Dang nhap khach thanh conh")
                let guestVc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainViewController")
                self.window?.rootViewController = guestVc
                self.window?.makeKeyAndVisible()
            }
        }
    }
    
}
