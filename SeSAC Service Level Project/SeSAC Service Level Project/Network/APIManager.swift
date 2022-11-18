//
//  APIManager.swift
//  SeSAC Service Level Project
//
//  Created by 이명진 on 2022/11/12.
//

import Foundation
import Alamofire

final class APIManager {
    
    static let shared = APIManager()
    
    private init() { }
    
    typealias requestDataCompletion<T> = ((Result<T, APIError>, Int?) -> Void)
    typealias loginCompletion = ((Int) -> Void)
    typealias searchCompletion = (([FromQueueDB]?, [String]?, Int?) -> Void)
    
    func requestData<T: Decodable>(_ object: T.Type = T.self,
                                   router: SeSACRouter,
                                   completion: @escaping requestDataCompletion<T>) {
        AF.request(router)
            .responseDecodable(of: object) { response in
                guard let statusCode = response.response?.statusCode else { return }
                
                switch response.result {
                case .success(let value):
                    completion(.success(value), statusCode)
                    print(statusCode, value)
                case .failure(_):
                    guard let error = APIError(rawValue: statusCode) else { return }
                    completion(.failure(error), statusCode)
                    print(statusCode, error)
                }
            }
        print(#function)
    }
    
    func requestSearch(router: SeSACRouter,
                       completion: @escaping searchCompletion) {
        AF.request(router)
            .responseDecodable(of: SearchResult.self) { response in
                guard let statusCode = response.response?.statusCode else { return }
                
                switch response.result {
                case .success(let value):
                    completion(value.fromQueueDB, value.fromRecommend, statusCode)
                    print(statusCode, value)
                case .failure(_):
                    guard let error = APIError(rawValue: statusCode) else { return }
                    print(statusCode, error)
                }
            }
        print(#function)
    }
    
    func requestLogin<T>(_ object: T.Type = T.self,
                         router: SeSACRouter,
                         completion: @escaping loginCompletion) {
        AF.request(router)
            .response() { response in
                guard let statusCode = response.response?.statusCode else { return }
                completion(statusCode)
            }
    }
}
