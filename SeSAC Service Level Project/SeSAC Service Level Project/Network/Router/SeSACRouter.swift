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
    case search(_ search: Search)
    case myQueueState
}

extension SeSACRouter: URLRequestConvertible {
    
    var baseURL: URL {
        return URL(string: EndPoint.BaseURL)!
    }
    
    var path: String {
        switch self {
        case .login, .signup:
            return "/v1/user"
        case .search:
            return "/v1/queue/search"
        case .myQueueState:
            return "/v1/queue/myQueueState"
        }
    }

    var headers: [String: String] {
        return ["Content-Type": "application/x-www-form-urlencoded",
                "idtoken": UserDefaults.standard.string(forKey: Matrix.IdToken) ?? ""
        ]
    }

    var method: HTTPMethod {
        switch self {
        case .login, .myQueueState:
            return .get
        case .signup, .search:
            return .post
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = baseURL.appendingPathComponent(path)

        var request = URLRequest(url: url)
        request.method = method
        request.headers = HTTPHeaders(headers)

        switch self {
        case .signup(let signup):
            request = try URLEncodedFormParameterEncoder().encode(signup, into: request)
        case .search(let search):
            request = try URLEncodedFormParameterEncoder().encode(search, into: request)
        default:
            return request
        }

        return request
    }
}
