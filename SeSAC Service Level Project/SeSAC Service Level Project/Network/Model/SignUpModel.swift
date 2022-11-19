//
//  SignUpModel.swift
//  SeSAC Service Level Project
//
//  Created by 이명진 on 2022/11/13.
//

import Foundation

//MARK: - SignUp

struct SignUp: Codable {
    let phoneNumber, fcMtoken, nick, birth: String
    let email: String
    let gender: Int

    enum CodingKeys: String, CodingKey {
        case phoneNumber
        case fcMtoken = "FCMtoken"
        case nick, birth, email, gender
    }
}

struct SignUpStatus: Codable {
    
}
