//
//  LoginPhoneViewController.swift
//  MovieApp
//
//  Created by AsherFelix on 08/10/2023.
//

import UIKit
import FirebaseAuth
class LoginPhoneViewController: UIViewController {
    let window = (UIApplication.shared.delegate as? AppDelegate)?.window
    @IBOutlet weak var numberView: UIView!
    @IBOutlet weak var phoneTF: UITextField!
    @IBOutlet weak var errorPhone: UIView!
    @IBOutlet weak var errorPhoneLabel: UILabel!
    @IBOutlet weak var requestBtn: UIButton!
    @IBOutlet weak var signInFB: UIView!
    @IBOutlet weak var signInGG: UIView!
    @IBOutlet weak var signInApple: UIView!
    let bottomLine = CALayer()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        phoneLoginSuccess()
        phoneTF.delegate = self
        bottomLine.frame = CGRect(x: 0, y: phoneTF.frame.size.height - 1, width: phoneTF.frame.size.width, height: 1)
        bottomLine.backgroundColor = UIColor(red: 0.31, green: 0.29, blue: 0.40, alpha: 1.00).cgColor
        phoneTF.layer.addSublayer(bottomLine)
        numberView.layer.addSublayer(bottomLine)
    }
    private func setupView() {
        phoneTF.borderStyle = .none
        requestBtn.layer.cornerRadius = 6
        signInFB.layer.cornerRadius = signInFB.frame.size.width / 2
        signInFB.backgroundColor = UIColor(red: 0.93, green: 0.91, blue: 0.93, alpha: 1.00)
        signInFB.clipsToBounds = true
        signInGG.layer.cornerRadius = signInGG.frame.size.width / 2
        signInGG.backgroundColor = UIColor(red: 0.93, green: 0.91, blue: 0.93, alpha: 1.00)
        signInGG.clipsToBounds = true
        signInApple.layer.cornerRadius = signInApple.frame.size.width / 2
        signInApple.backgroundColor = UIColor(red: 0.93, green: 0.91, blue: 0.93, alpha: 1.00)
        signInApple.clipsToBounds = true
        phoneTF.placeholder = "XXX XXX XXXX"
        phoneTF.clearButtonMode = .whileEditing
    }
    private func phoneLoginSuccess() {
        errorPhone.isHidden = true
        phoneTF.layer.borderColor = UIColor(red: 0.31, green: 0.29, blue: 0.40, alpha: 1.00).cgColor
        phoneTF.keyboardType = .numberPad
    }
    private func phoneLoginError() {
        errorPhone.isHidden = false
        phoneTF.layer.borderColor = UIColor(red: 0.76, green: 0.00, blue: 0.32, alpha: 1.00).cgColor
        phoneTF.backgroundColor = UIColor(red: 1.00, green: 0.95, blue: 0.97, alpha: 1.00)
    }
    
    @IBAction func requestBtn(_ sender: Any) {
        guard let phoneText = phoneTF.text else {
            return
        }
        var checkPhone: Bool = false
        if phoneText.isEmpty {
            errorPhoneLabel.text = "Numberphone can't Empty"
            phoneLoginError()
        }else if phoneText.count < 12 {
            errorPhoneLabel.text = "Numberphone need 10 character"
            phoneLoginError()
        } else {
            phoneLoginSuccess()
            checkPhone = true
        }
        let isValidPhone = checkPhone
        if isValidPhone == true {
            loginphoneWithFirebase()
        }
    }
    
    
    func loginphoneWithFirebase() {
        Auth.auth().settings?.isAppVerificationDisabledForTesting = true
        guard let phoneNumber = phoneTF.text else {return}
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { (verificationID, error) in
            if let error = error {
                return
            }
            UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
        }
        let verifyVc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "VerifyOTPViewController") as! VerifyOTPViewController
        verifyVc.verifyPhone = phoneTF.text ?? ""
        let verifyNav = UINavigationController(rootViewController: verifyVc)
        window?.rootViewController = verifyVc
    }
    
    @IBAction func gotoSignUp(_ sender: Any) {
        let gotoSignUpNav = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "RegisterViewController")
        window?.rootViewController = gotoSignUpNav
    }
    
}
extension LoginPhoneViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let phoneFormatter = phoneTF.text else {
            return false
        }
        let newString = (phoneFormatter as NSString).replacingCharacters(in: range, with: string)
        phoneTF.text = formatter(mask: "XXX XXX XXXX", phoneNumber: newString)
        return false
    }
    private func formatter(mask: String, phoneNumber: String) -> String {
        let number = phoneNumber.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        var result: String = ""
        var index = number.startIndex
        for character in mask where index < number.endIndex {
            if character == "X" {
                result.append(number[index])
                index = number.index(after: index)
            }else {
                result.append(character)
            }
        }
        return result
    }
    
}
