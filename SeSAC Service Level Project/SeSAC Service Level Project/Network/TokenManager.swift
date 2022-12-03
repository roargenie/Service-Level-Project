//
//  TokenManager.swift
//  SeSAC Service Level Project
//
//  Created by 이명진 on 2022/11/30.
//

import Foundation
import FirebaseAuth

final class TokenManager {
    
    static let shared = TokenManager()
    
    private init() { }
    
    func refreshIdToken(completion: @escaping () -> Void) {
        let currentUser = Auth.auth().currentUser
        currentUser?.getIDTokenForcingRefresh(true, completion: { idToken, error in
            if let error = error {
                print(error.localizedDescription)
                print("LogIn Failed...")
            }
            UserDefaults.standard.set(idToken, forKey: Matrix.IdToken)
            print("Refresh idToken")
            completion()
            // 컴플리션 시점? 유저디폴트에 저장된게 컴플리션하고 시점이 안맞아서? 여러번 호출???
        })
    }
    
}
