//
//  LoginEmailViewController.swift
//  MovieApp
//
//  Created by AsherFelix on 08/10/2023.
//

import UIKit
import MBProgressHUD
import FirebaseAuth
import GoogleSignIn
import FirebaseCore
class LoginEmailViewController: UIViewController {
    let window = (UIApplication.shared.delegate as? AppDelegate)?.window
    var rememberLogin: Bool = false
    var checkPassword: Bool = false
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var errorEmail: UIView!
    @IBOutlet weak var errorPassword: UIView!
    @IBOutlet weak var passwordCheck: UIImageView!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var signInFB: UIView!
    @IBOutlet weak var signInGG: UIView!
    @IBOutlet weak var signInApple: UIView!
    @IBOutlet weak var errorEmailLabel: UILabel!
    @IBOutlet weak var rememberImage: UIImageView!
    @IBOutlet weak var errorPasswordLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupEmailLoginSuccess()
        setupPasswordLoginSuccess()
        checkRememberLogin()
    }
    private func setupView() {
        emailTF.layer.cornerRadius = 6
        emailTF.layer.borderWidth = 1
        emailTF.layer.borderColor = UIColor(red: 0.31, green: 0.29, blue: 0.40, alpha: 1.00).cgColor
        passwordTF.layer.cornerRadius = 6
        passwordTF.layer.borderWidth = 1
        passwordTF.layer.borderColor = UIColor(red: 0.31, green: 0.29, blue: 0.40, alpha: 1.00).cgColor
        loginBtn.layer.cornerRadius = 6
        signInFB.layer.cornerRadius = signInFB.frame.size.width / 2
        signInFB.clipsToBounds = true
        signInFB.backgroundColor = UIColor(red: 0.93, green: 0.91, blue: 0.93, alpha: 1.00)
        signInGG.layer.cornerRadius = signInGG.frame.size.width / 2
        signInGG.clipsToBounds = true
        signInGG.backgroundColor = UIColor(red: 0.93, green: 0.91, blue: 0.93, alpha: 1.00)
        signInApple.layer.cornerRadius = signInApple.frame.size.width / 2
        signInApple.backgroundColor = UIColor(red: 0.93, green: 0.91, blue: 0.93, alpha: 1.00)
        signInApple.clipsToBounds = true
    }
    private func setupEmailLoginSuccess() {
        errorEmail.isHidden = true
        emailTF.placeholder = "Enter your Email"
        emailTF.clearButtonMode = .whileEditing
        emailTF.keyboardType = .emailAddress
    }
    
    @IBAction func rememberBtn(_ sender: Any) {
        rememberLogin.toggle()
        if rememberLogin {
            rememberImage.image = UIImage(named: "check")
        } else {
            rememberImage.image = UIImage(named: "uncheck")
        }
    }
    
    private func setupPasswordLoginSuccess() {
        errorPassword.isHidden = true
        passwordTF.isSecureTextEntry = true
        passwordTF.placeholder = "Enter your Password"
    }
    private func setupErroEmailLogin() {
        errorEmail.isHidden = false
        emailTF.layer.borderColor = UIColor(red: 0.76, green: 0.00, blue: 0.32, alpha: 1.00).cgColor
        emailTF.backgroundColor = UIColor(red: 1.00, green: 0.95, blue: 0.97, alpha: 1.00)
    }
    private func setupErroPasswordLogin() {
        errorPassword.isHidden = false
        passwordTF.layer.borderColor = UIColor(red: 0.76, green: 0.00, blue: 0.32, alpha: 1.00).cgColor
        passwordTF.backgroundColor = UIColor(red: 1.00, green: 0.95, blue: 0.97, alpha: 1.00)
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: email)
    }
    
    @IBAction func showPassword(_ sender: Any) {
        checkPassword.toggle()
        if checkPassword {
            passwordCheck.image = UIImage(named: "showPassword")
            passwordTF.isSecureTextEntry = false
        } else {
            passwordCheck.image = UIImage(named: "hiddenPassword")
            passwordTF.isSecureTextEntry = true
        }
    }
    @IBAction func forgetPassword(_ sender: Any) {
        let gotoForget = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ForgetPasswordViewController")
        let gotoForgetNav = UINavigationController(rootViewController: gotoForget)
        window?.rootViewController = gotoForgetNav
        
    }
    
    @IBAction func loginBtn(_ sender: Any) {
        let emailLogin = emailTF.text ?? ""
        var emailSuccess:Bool = false
        if emailLogin.isEmpty {
            errorEmailLabel.text = "Email can't Empty"
            setupErroEmailLogin()
        } else if emailLogin.count < 6 || emailLogin.count > 40 {
            errorEmailLabel.text = "Email must been 6 and 40 character"
            setupErroEmailLogin()
        }else if !isValidEmail(emailLogin) {
            errorEmailLabel.text = "Invalid Email"
            setupErroEmailLogin()
        }else {
            setupEmailLoginSuccess()
            emailSuccess = true
        }
        
        
        let passwordLogin = passwordTF.text ?? ""
        var passwordSuccess: Bool = false
        if passwordLogin.isEmpty {
            errorPasswordLabel.text = "Password can't Empty"
            setupErroPasswordLogin()
        }else if passwordLogin.count < 6 && passwordLogin.count > 40 {
            errorPasswordLabel.text = "Password must been 6 and 40 character"
        }else {
            setupPasswordLoginSuccess()
            passwordSuccess = true
        }
        
        let isValid = emailSuccess && passwordSuccess
        if isValid == true {
            loginFirebase()
            if rememberLogin == true {
                UserDefaults.standard.set("1", forKey: "rememberMe")
                UserDefaults.standard.set(emailTF.text ?? "", forKey: "rememberEmail")
                UserDefaults.standard.set(passwordTF.text ?? "", forKey: "rememberPassword")
                print("Email and Password Save Success")
            } else {
                UserDefaults.standard.set("2", forKey: "rememberMe")
            }
        }
        
    }
    private func loginFirebase() {
        isShow(loading: true)
        guard let email = emailTF.text , let password = passwordTF.text else {
            return
        }
        Auth.auth().signIn(withEmail: email, password: password) { (authResult,error) in
            if let error = error {
                let alertLoginError = UIAlertController(title: "Note", message: "Wrong Email or Password", preferredStyle: .alert)
                let action = UIAlertAction(title: "Ok", style: .cancel)
                alertLoginError.addAction(action)
                self.present(alertLoginError, animated: true)
                self.isShow(loading: false)
            } else {
                let alertLoginSuccess = UIAlertController(title: "Note", message: "Login Success", preferredStyle: .alert)
                let action = UIAlertAction(title: "Ok", style: .cancel) { _ in
                    let gotoMainVc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainViewController")
                    self.window?.rootViewController = gotoMainVc
                }
                alertLoginSuccess.addAction(action)
                self.present(alertLoginSuccess, animated: true)
            }
        }
    }
    @IBAction func signInFB(_ sender: Any) {
        
    }
    
    @IBAction func signInGG(_ sender: Any) {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config

        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { [unowned self] result, error in
          guard error == nil else {
              return
          }

          guard let user = result?.user,
            let idToken = user.idToken?.tokenString
          else {
              return
          }

          let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                         accessToken: user.accessToken.tokenString)
            Auth.auth().signIn(with: credential) { result, error in
                if let error = error {
                    print("\(error.localizedDescription)")
                }else {
                    print("Login thanh cong")
                }
            }
        }
        
    }
    
    @IBAction func signInApple(_ sender: Any) {
        
    }
    @IBAction func signUp(_ sender: Any) {
        let signUpVc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RegisterViewController")
        let signUpNav = UINavigationController(rootViewController: signUpVc)
        window?.rootViewController = signUpNav
    }
    func checkRememberLogin() {
        if UserDefaults.standard.string(forKey: "rememberMe") == "1" {
            if let image = UIImage(named: "check") {
                rememberImage.image = image
            }
            rememberLogin = true
            self.emailTF.text = UserDefaults.standard.string(forKey: "rememberEmail") ?? ""
            self.passwordTF.text = UserDefaults.standard.string(forKey: "rememberPassword") ?? ""
        } else {
            if let image = UIImage(named: "uncheck") {
                rememberImage.image = image
            }
            rememberLogin = false
        }
    }
    
    
}
