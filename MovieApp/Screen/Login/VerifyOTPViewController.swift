//
//  VerifyOTPViewController.swift
//  MovieApp
//
//  Created by AsherFelix on 08/10/2023.
//

import UIKit
class VerifyOTPViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var otpTextField: UITextField!
    @IBOutlet weak var resendCode: UIButton!
    @IBOutlet weak var verifyBtn: UIButton!
    @IBOutlet weak var countdownCode: UILabel!
    let bottomLine = CALayer()
    var verifyPhone: String = ""
    private var maximumCountdownTime = 60
    private var countCountdownTime = 60
    private var countdownTimer: Timer?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        bottomLine.frame = CGRect(x: 0, y: otpTextField.frame.size.height - 1, width: otpTextField.frame.size.width, height: 1)
        bottomLine.backgroundColor = UIColor(red: 0.31, green: 0.29, blue: 0.40, alpha: 1.00).cgColor
        otpTextField.layer.addSublayer(bottomLine)
        startCountdown()
    }
    private func setupView() {
        verifyBtn.layer.cornerRadius = 6
        otpTextField.borderStyle = .none
    
    }
    @IBAction func verifyBtn(_ sender: Any) {
    }
    
    @IBAction func resendCode(_ sender: Any) {
    }
    private func startCountdown() {
        if countdownTimer != nil , countdownTimer!.isValid {
            countdownTimer?.invalidate()
        }
        self.countdownCode.text = "\(countCountdownTime)s"
        countdownTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {
            timer in
            self.countCountdownTime -= 1
            if self.countCountdownTime == 0 {
                    timer.invalidate()
                self.countdownTimer = nil
            }
        }
    }
}
