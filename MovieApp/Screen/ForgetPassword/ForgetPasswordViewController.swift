//
//  ForgetPasswordViewController.swift
//  MovieApp
//
//  Created by AsherFelix on 09/10/2023.
//

import UIKit

class ForgetPasswordViewController: UIViewController {
    var checkRadio: Bool = false
    @IBOutlet weak var viaSms: UIView!
    @IBOutlet weak var viaEmail: UIView!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var radioCheckPhone: UIImageView!
    @IBOutlet weak var radiocheckEmail: UIImageView!
    @IBOutlet weak var phoneView: UIView!
    @IBOutlet weak var emailView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        let tapViaSms = UITapGestureRecognizer(target: self, action: #selector(viaSmsTap))
        viaSms.addGestureRecognizer(tapViaSms)
        let tapViaEmail = UITapGestureRecognizer(target: self, action: #selector(viaEmailTap))
        viaEmail.addGestureRecognizer(tapViaEmail)
    }
    @objc func viaSmsTap() {
        checkRadio.toggle()
        if checkRadio == true {
            radioCheckPhone.image = UIImage(named: "Radiocheck")
            radiocheckEmail.image = UIImage(named: "Radiouncheck")
            nextBtn.isEnabled = true
        }
    }
    @objc func viaEmailTap() {
        checkRadio.toggle()
        if checkRadio == true {
            radiocheckEmail.image = UIImage(named: "Radiocheck")
            radioCheckPhone.image = UIImage(named: "Radiouncheck")
            nextBtn.isEnabled = true
        }
    }
    private func setupView() {
        viaSms.layer.cornerRadius = 15
        viaSms.layer.borderWidth = 2
        viaEmail.layer.cornerRadius = 15
        viaEmail.layer.borderWidth = 2
        nextBtn.layer.cornerRadius = 6
        nextBtn.isEnabled = false
        phoneView.layer.cornerRadius = 6
        phoneView.clipsToBounds = true
        emailView.layer.cornerRadius = 6
        emailView.clipsToBounds = true
    }
    
    @IBAction func nextBtn(_ sender: Any) {
        let gotoForgetEmailNav = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ForgetPasswordEmailViewController") as! ForgetPasswordEmailViewController
        navigationController?.pushViewController(gotoForgetEmailNav, animated: true)
    }
}
