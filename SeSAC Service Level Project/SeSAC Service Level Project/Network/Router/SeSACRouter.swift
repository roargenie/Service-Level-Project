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
    case queue(_ queue: MyQueue)
    case queueStop
    case myPage(_ mypage: MyPage)
    case withdraw
    case studyRequest(_ studyRequest: StudyRequest)
    case studyAccept(_ studyAccept: StudyAccept)
    case postChat(chat: String, userId: String)
    case chat(userId: String, lastChatDate: String)
    case dodge(_ studyDodge: StudyDodge)
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
        case .queue, .queueStop:
            return "/v1/queue"
        case .myPage:
            return "/v1/user/mypage"
        case .withdraw:
            return "/v1/user/withdraw"
        case .studyRequest:
            return "/v1/queue/studyrequest"
        case .studyAccept:
            return "/v1/queue/studyaccept"
        case .postChat(_ , let userId):
            return "/v1/chat/\(userId)"
        case .chat(let userId, _):
            return "/v1/chat/\(userId)"
        case .dodge:
            return "/v1/queue/dodge"
        }
    }

    var headers: [String: String] {
        return ["Content-Type": "application/x-www-form-urlencoded",
                "idtoken": UserDefaults.standard.string(forKey: Matrix.IdToken) ?? ""
        ]
    }

    var method: HTTPMethod {
        switch self {
        case .login, .myQueueState, .chat:
            return .get
        case .signup, .search, .queue, .studyRequest, .studyAccept, .postChat, .dodge, .withdraw:
            return .post
        case .myPage:
            return .put
        case .queueStop:
            return .delete
        }
    }
    
    var parameters: Parameters {
        switch self {
        case .queue(let queue):
            return ["long": queue.long,
                    "lat": queue.lat,
                    "studylist": queue.studylist]
        case .postChat(let chat, _):
            return ["chat": chat]
        case .chat(_, let date):
            return ["lastchatDate": date]
        default:
            return ["":""]
        }
    }
    
    var encoding: ParameterEncoding {
        switch self {
        case .queue:
            return URLEncoding(arrayEncoding: .noBrackets)
        case .chat:
            return URLEncoding.queryString
        default:
            return URLEncoding.default
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
        case .myPage(let mypage):
            request = try URLEncodedFormParameterEncoder().encode(mypage, into: request)
        case .queue:
            request = try URLEncoding(arrayEncoding: .noBrackets).encode(request, with: parameters)
        case .studyRequest(let studyReqeust):
            request = try URLEncodedFormParameterEncoder().encode(studyReqeust, into: request)
        case .studyAccept(let studyAccept):
            request = try URLEncodedFormParameterEncoder().encode(studyAccept, into: request)
        case .postChat:
            request = try URLEncoding().encode(request, with: parameters)
        case .chat:
            request = try URLEncoding().encode(request, with: parameters)
        case .dodge(let studyDodge):
            request = try URLEncodedFormParameterEncoder().encode(studyDodge, into: request)
        default:
            return request
        }
        
        return request
    }
}
