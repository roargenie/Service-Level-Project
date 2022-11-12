//
//  NetworkError.swift
//  SeSAC Service Level Project
//
//  Created by 이명진 on 2022/11/12.
//

import Foundation


@frozen enum APIError: Int, Error {
    case firebaseTokenErr = 401
    case notSignUp = 406
    case serverError = 500
    case clientError = 501
}

extension APIError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .firebaseTokenErr:
            return "토큰 만료"
        case .notSignUp:
            return "미가입 유저"
        case .serverError:
            return "서버 에러"
        case .clientError:
            return "Header, Body 확인"
        }
    }
}
