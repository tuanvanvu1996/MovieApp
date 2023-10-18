//
//  AuthServices.swift
//  MovieApp
//
//  Created by AsherFelix on 09/10/2023.
//

import Foundation
import KeychainSwift

class AutheService {
//    khoi tao doi tuong the hien cua AutheSerVice
    static var shared = AutheService()
    private init() {
        
    }
    enum Keys:String {
        case KeyAccessToken
    }
    

    func saveAcessToken(accessToken: String) {
        let keychain = KeychainSwift()
        keychain.set(accessToken, forKey: Keys.KeyAccessToken.rawValue)
    }
    func getAccessToken() -> String? {
        let keychain = KeychainSwift()
        return keychain.get(Keys.KeyAccessToken.rawValue)
    }
    func clearAccessToken() {
        let keychain = KeychainSwift()
        keychain.delete(Keys.KeyAccessToken.rawValue)
    }
    var isLoggedIn: Bool {
        let token = getAccessToken()
        return token != nil && !(token!.isEmpty)
    }
}

