//
//  RegisterViewController.swift
//  MovieApp
//
//  Created by AsherFelix on 08/10/2023.
//

import UIKit
import MBProgressHUD
import FirebaseAuth
import FirebaseCore
import FirebaseStorage
class RegisterViewController: UIViewController {
    let window = (UIApplication.shared.delegate as? AppDelegate)?.window
    var checkPassword:Bool = false
    var checkConfirmPassword: Bool = false
    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var usernameError: UIView!
    @IBOutlet weak var usernameErrorLabel: UILabel!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var emailError: UIView!
    @IBOutlet weak var emailErrorLabel: UILabel!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var passwordError: UIView!
    @IBOutlet weak var showPassword: UIImageView!
    @IBOutlet weak var passwordErrorLabel: UILabel!
    @IBOutlet weak var confirmPasswordTF: UITextField!
    @IBOutlet weak var confirmPasswordError: UIView!
    @IBOutlet weak var showPasswordConfirm: UIImageView!
    @IBOutlet weak var confirmPasswordErrorLabel: UILabel!
    @IBOutlet weak var signInFB: UIView!
    @IBOutlet weak var signInGG: UIView!
    @IBOutlet weak var signInApple: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupEmailSuccess()
        setupUsernameSuccess()
        setupPasswordSuccess()
        setupConfirmPassSuccess()
        
    }
    private func setupView() {
        usernameTF.placeholder = "Enter your Username"
        emailTF.placeholder = "Enter your Email"
        passwordTF.placeholder = "Enter your Password"
        confirmPasswordTF.placeholder = "Enter Confirm Password"
        usernameTF.layer.cornerRadius = 6
        usernameTF.layer.borderWidth = 1
        emailTF.layer.cornerRadius = 6
        emailTF.layer.borderWidth = 1
        passwordTF.layer.cornerRadius = 6
        passwordTF.layer.borderWidth = 1
        confirmPasswordTF.layer.cornerRadius = 6
        confirmPasswordTF.layer.borderWidth = 1
        signInFB.layer.cornerRadius = signInFB.frame.size.width / 2
        signInFB.clipsToBounds = true
        signInFB.backgroundColor = UIColor(red: 0.93, green: 0.91, blue: 0.93, alpha: 1.00)
        signInGG.layer.cornerRadius = signInFB.frame.size.width / 2
        signInGG.clipsToBounds = true
        signInGG.backgroundColor = UIColor(red: 0.93, green: 0.91, blue: 0.93, alpha: 1.00)
        signInApple.layer.cornerRadius = signInFB.frame.size.width / 2
        signInApple.clipsToBounds = true
        signInApple.backgroundColor = UIColor(red: 0.93, green: 0.91, blue: 0.93, alpha: 1.00)
        usernameTF.clearButtonMode = .whileEditing
        emailTF.clearButtonMode = .whileEditing
        emailTF.keyboardType = .emailAddress
        passwordTF.isSecureTextEntry = true
        confirmPasswordTF.isSecureTextEntry = true
    }
    private func setupUsernameSuccess() {
        usernameError.isHidden = true
        usernameTF.layer.borderColor = UIColor(red: 0.31, green: 0.29, blue: 0.40, alpha: 1.00).cgColor
    }
    private func setupUsernameError() {
        usernameError.isHidden = false
        usernameTF.layer.borderColor = UIColor(red: 0.76, green: 0.00, blue: 0.32, alpha: 1.00).cgColor
        usernameTF.backgroundColor = UIColor(red: 1.00, green: 0.95, blue: 0.97, alpha: 1.00)
    }
    private  func setupEmailSuccess() {
        emailError.isHidden = true
        emailTF.layer.borderColor = UIColor(red: 0.31, green: 0.29, blue: 0.40, alpha: 1.00).cgColor
    }
    private func setupEmailError() {
        emailError.isHidden = false
        emailTF.layer.borderColor = UIColor(red: 0.76, green: 0.00, blue: 0.32, alpha: 1.00).cgColor
        emailTF.backgroundColor = UIColor(red: 1.00, green: 0.95, blue: 0.97, alpha: 1.00)
    }
    private  func setupPasswordSuccess() {
        passwordError.isHidden = true
        passwordTF.layer.borderColor = UIColor(red: 0.31, green: 0.29, blue: 0.40, alpha: 1.00).cgColor
    }
    private func setupPasswordError() {
        passwordError.isHidden = false
        passwordTF.layer.borderColor = UIColor(red: 0.76, green: 0.00, blue: 0.32, alpha: 1.00).cgColor
        passwordTF.backgroundColor = UIColor(red: 1.00, green: 0.95, blue: 0.97, alpha: 1.00)
    }
    private  func setupConfirmPassSuccess() {
        confirmPasswordError.isHidden = true
        confirmPasswordTF.layer.borderColor = UIColor(red: 0.31, green: 0.29, blue: 0.40, alpha: 1.00).cgColor
    }
    private func setupConfirmPassError() {
        confirmPasswordError.isHidden = false
        confirmPasswordTF.layer.borderColor = UIColor(red: 0.76, green: 0.00, blue: 0.32, alpha: 1.00).cgColor
        confirmPasswordTF.backgroundColor = UIColor(red: 1.00, green: 0.95, blue: 0.97, alpha: 1.00)
    }
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: email)
    }
    
    @IBAction func showPassword(_ sender: Any) {
        checkPassword.toggle()
        if checkPassword {
            showPassword.image = UIImage(named: "showPassword")
            passwordTF.isSecureTextEntry = false
        }else {
            showPassword.image = UIImage(named: "hiddenPassword")
        }
    }
    
    @IBAction func showConfirmPassword(_ sender: Any) {
        checkConfirmPassword.toggle()
        if checkConfirmPassword {
            showPasswordConfirm.image = UIImage(named: "showPassword")
            confirmPasswordTF.isSecureTextEntry = false
        }else {
            showPasswordConfirm.image = UIImage(named: "hiddenPassword")
            confirmPasswordTF.isSecureTextEntry = false
        }
    }
    
    @IBAction func registerBtn(_ sender: Any) {
        var usernameText = usernameTF.text ?? ""
        var usernameCheck = false
        if usernameText.isEmpty {
            usernameErrorLabel.text = "Username can't Empty"
            setupUsernameError()
        } else if usernameText.count < 6 || usernameText.count > 40 {
            usernameErrorLabel.text = "Username must been 6 and 40 character"
            setupUsernameError()
        } else {
            setupUsernameSuccess()
            usernameCheck = true
        }
        
        var emailText = emailTF.text ?? ""
        var emailCheck = false
        if emailText.isEmpty {
            emailErrorLabel.text = "Email can't Empty"
            setupEmailError()
        }else if emailText.count < 6 || emailText.count > 40 {
            emailErrorLabel.text = "Email must been 6 and 40 character"
            setupEmailError()
        }else if !isValidEmail(emailText) {
            emailErrorLabel.text = "Invalid Email"
            setupEmailError()
        }else {
            setupEmailSuccess()
            emailCheck = true
        }
        
        var passwordText = passwordTF.text ?? ""
        var passwordCheck = false
        if passwordText.isEmpty {
            passwordErrorLabel.text = "Password can't Empty"
            setupPasswordError()
        }else if passwordText.count < 6 || passwordText.count > 40 {
            passwordErrorLabel.text = "Password must been 6 and 40 character"
            setupPasswordError()
        }else if !passwordText.contains(where: { $0.isUppercase }) {
            passwordErrorLabel.text = "Password need one Uppercase"
            setupPasswordError()
        }else if !passwordText.contains(where: { !$0.isLetter && !$0.isNumber}) {
            passwordErrorLabel.text = "Incorrect password format"
            setupPasswordError()
        }else {
            setupPasswordSuccess()
            passwordCheck = true
        }
        
        var confirmPassword = confirmPasswordTF.text ?? ""
        var confirmPasswordCheck = false
        if confirmPassword.isEmpty {
            confirmPasswordErrorLabel.text = "Password can't Empty"
            setupConfirmPassError()
        }else if confirmPassword != passwordText {
            confirmPasswordErrorLabel.text = "Invalid Password"
            setupConfirmPassError()
        } else if confirmPassword == passwordText {
            setupConfirmPassSuccess()
            confirmPasswordCheck = true
        }
        
        var isValid = usernameCheck && emailCheck && passwordCheck && confirmPasswordCheck
        if isValid == true {
            registerFirebase()
        }
    }
    private func registerFirebase() {
        isShow(loading: true)
        guard let email = emailTF.text, let password = passwordTF.text, let username = usernameTF.text else {
            return
        }
        Auth.auth().createUser(withEmail: email, password: password) {
            authResult, error in
            guard error == nil else {
                var messenger = ""
                switch AuthErrorCode.Code(rawValue: error!._code) {
                case .emailAlreadyInUse:
                    messenger = "Email already exists"
                case.invalidEmail :
                    messenger = "Email is invalid"
                default:
                    messenger = error?.localizedDescription ?? ""
                }
                self.isShow(loading: false)
                self.alertRegister(messenger: messenger)
                return
            }
            self.gotologin()
        }
    }
    private func alertRegister(messenger: String) {
        let alertRegister = UIAlertController(title: "Note", message: messenger, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel)
        alertRegister.addAction(action)
        present(alertRegister, animated: true)
    }
    private func gotologin() {
        let gotoLoginNav = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController")
        navigationController?.pushViewController(gotoLoginNav, animated: true)
    }
    
    @IBAction func gotoLogin(_ sender: Any) {
        let gotoLoginVc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController")
        window?.rootViewController = gotoLoginVc
        window?.makeKeyAndVisible()
    }
}
