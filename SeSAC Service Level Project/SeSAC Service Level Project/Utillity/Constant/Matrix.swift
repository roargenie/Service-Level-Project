//
//  Text.swift
//  SeSAC Service Level Project
//
//  Created by 이명진 on 2022/11/08.
//

import Foundation


@frozen enum Matrix {
    // MARK: - Onboarding
    
    static let firstVCText = "위치 기반으로 빠르게\n주위 친구를 확인"
    static let secondVCText = "스터디를 원하는 친구를\n찾을 수 있어요"
    static let thirdVCText = "SeSAC Study"
    
    // MARK: - UserDefaults Key
    
    static let verificationID = "verificationID"
    static let FCMToken = "FCMToken"
    static let phoneNumber = "phonenumber"
    static let nickname = "nickname"
    static let birth = "birth"
    static let email = "email"
    static let gender = "gender"
}
