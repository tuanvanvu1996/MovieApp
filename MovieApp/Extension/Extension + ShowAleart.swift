//
//  Extension + ShowAleart.swift
//  MovieApp
//
//  Created by AsherFelix on 10/10/2023.
//

import Foundation
import UIKit
import MBProgressHUD
extension UIViewController {
    func isShow(loading: Bool) {
        if loading {
            MBProgressHUD.hide(for: self.view, animated: true)
        }else {
            MBProgressHUD.hide(for: self.view, animated: true)
        }
    }
    func showAlert(messenger: String) {
        let alert = UIAlertController(title: "Note", message: messenger, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel)
        alert.addAction(action)
        present(alert, animated: true)
    }
}
