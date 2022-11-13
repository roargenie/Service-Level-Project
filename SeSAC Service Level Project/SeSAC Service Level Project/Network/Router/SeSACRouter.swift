//
//  SeSACRouter.swift
//  SeSAC Service Level Project
//
//  Created by 이명진 on 2022/11/12.
//

import Foundation
import Alamofire

enum SeSACRouter {
    case login
    case signup(_ signup: SignUp)
}

extension SeSACRouter: URLRequestConvertible {
    
    var baseURL: URL {
        return URL(string: EndPoint.BaseURL)!
    }
    
    var path: String {
        switch self {
        case .login, .signup:
            return "/v1/user"
        }
    }

    var headers: [String: String] {
        return ["Content-Type": "application/x-www-form-urlencoded",
                "idtoken": UserDefaults.standard.string(forKey: Matrix.IdToken) ?? ""
        ]
    }

    var method: HTTPMethod {
        switch self {
        case .login:
            return .get
        case .signup:
            return .post
        }
    }

//    var parameters: [String: Any] {
//        switch self {
//        case .login:
//            return ["":""]
//        case .signup(let signup):
//            return ["phoneNumber": signup.phoneNumber,
//                    "FCMtoken": signup.fcMtoken,
//                    "nick": signup.nick,
//                    "birth": signup.birth,
//                    "email": signup.email,
//                    "gender": signup.gender
//            ]
//        }
//    }
    
    func asURLRequest() throws -> URLRequest {
        let url = baseURL.appendingPathComponent(path)

        var request = URLRequest(url: url)
        request.method = method
        request.headers = HTTPHeaders(headers)

        switch self {
        case .signup(let signup):
            request = try URLEncodedFormParameterEncoder().encode(signup, into: request)
        default:
            return request
        }

        return request
    }
}
