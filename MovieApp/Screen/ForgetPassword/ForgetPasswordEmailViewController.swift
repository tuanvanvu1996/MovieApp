//
//  ForgetPasswordEmailViewController.swift
//  MovieApp
//
//  Created by AsherFelix on 09/10/2023.
//

import UIKit
import MBProgressHUD
import FirebaseAuth
class ForgetPasswordEmailViewController: UIViewController {
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var emailError: UIView!
    @IBOutlet weak var emailErrorLabel: UILabel!
    @IBOutlet weak var nextBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
       setupview()
        setupEmailSuccess()
    }
    private func setupview() {
        emailTF.placeholder = "Enter your Email"
        emailTF.layer.cornerRadius = 6
        emailTF.layer.borderWidth = 1
        emailTF.clearButtonMode = .whileEditing
        emailTF.keyboardType = .emailAddress
        nextBtn.layer.cornerRadius = 6
        
    }
    private func setupEmailSuccess() {
        emailError.isHidden = true
    }
    private func setupEmailError() {
        emailError.isHidden = false
        emailTF.layer.borderColor = UIColor(red: 0.76, green: 0.00, blue: 0.32, alpha: 1.00).cgColor
        emailTF.backgroundColor = UIColor(red: 1.00, green: 0.95, blue: 0.97, alpha: 1.00)
    }
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: email)
    }
    @IBAction func nextBtn(_ sender: Any) {
        let emailText = emailTF.text ?? ""
        var emailCheck:Bool = false
        if emailText.isEmpty {
            emailErrorLabel.text = "Email can't Empty"
            setupEmailError()
        }else if emailText.count < 6 || emailText.count > 40 {
            emailErrorLabel.text = "Email must been 6 and 40 character"
            setupEmailError()
        }else if !isValidEmail(emailText) {
            emailErrorLabel.text = "Invalid Email"
            setupEmailError()
        } else {
            setupEmailSuccess()
            emailCheck = true
        }
        var isValidEmail = emailCheck
        if isValidEmail == true {
            forgetPasswordWithFirebase()
        }
        
    }
    private func forgetPasswordWithFirebase() {
        isShow(loading: true)
        guard let email = emailTF.text else {
            return
        }
        var messenger = ""
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                switch AuthErrorCode.Code(rawValue: error._code) {
                case .userNotFound:
                    messenger = "Email Not Found"
                case .invalidEmail:
                    messenger = "Invalid Email"
                case.appNotAuthorized:
                    messenger = "App Not Authorized"
                default:
                    break
                }
                self.showAlert(messenger: messenger)
                self.isShow(loading: false)
                return
            }
            self.gotoForgetSuccess()
        }
    }
    
    private func gotoForgetSuccess() {
        let alert = UIAlertController(title: "Note", message: "Send Code Success,Please check Email!", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel) { _ in
            let gotoForgetSuccessVc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ForgetPasswordSuccessViewController")
            self.navigationController?.pushViewController(gotoForgetSuccessVc, animated: true)
        }
        alert.addAction(action)
        present(alert, animated: true)
    }
}
