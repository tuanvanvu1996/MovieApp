//
//  SceneDelegate.swift
//  MovieApp
//
//  Created by AsherFelix on 07/10/2023.
//

import UIKit
import FirebaseAuth
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        (UIApplication.shared.delegate as? AppDelegate)?.window = window
        if OnboardService.shared.isOnboarded() {
            if Auth.auth().currentUser != nil {
                gotoMain()
            }else {
                gotoOnScreen()
            }
        } else {
            gotoOnBoard()
        }
    }
    private func gotoMain() {
        let gotoMain = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainViewController")
        window?.rootViewController = gotoMain
        window?.makeKeyAndVisible()
        
    }
    private func gotoOnScreen() {
        let gotoOnScreen = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ScreenViewController")
        window?.rootViewController = gotoOnScreen
        window?.makeKeyAndVisible()
        
    }
    private func gotoOnBoard() {
        let gotoOnBoard = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "OnBoardViewController")
        window?.rootViewController = gotoOnBoard
        window?.makeKeyAndVisible()
    }
    
    private func gotoLogin() {
        let gotoLogin = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController")
        window?.rootViewController = gotoLogin
        window?.makeKeyAndVisible()
    }


}

