//
//  OnBoard.swift
//  MovieApp
//
//  Created by AsherFelix on 09/10/2023.
//

import Foundation
class OnboardService {
    static var shared = OnboardService()
    
    private init() {
        print("OnboardService init")
    }
    
    enum Keys: String {
        case keyOnboard
    }
    
    func markOnboarded() {
        let userDefault = UserDefaults.standard
        userDefault.setValue(true, forKey: Keys.keyOnboard.rawValue)
    }
    
    func isOnboarded() -> Bool {
        let userDefault = UserDefaults.standard
        return userDefault.bool(forKey: Keys.keyOnboard.rawValue)
    }
}
