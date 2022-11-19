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
    
    typealias requestDataCompletion<T> = ((Result<T?, APIError>, Int?) -> Void)
    
    func requestData<T: Decodable>(_ object: T.Type = T.self,
                                   router: SeSACRouter,
                                   completion: @escaping requestDataCompletion<T>) {
        AF.request(router)
            .responseDecodable(of: object) { response in
//                print(response.response?.statusCode)
                guard let statusCode = response.response?.statusCode else { return }
                completion(.success(response as? T), statusCode)
                switch response.result {
                case .success(let value):
//                    guard let value = value else { return }
                    completion(.success(value), statusCode)
                    print(statusCode, value)
                case .failure(_):
                    guard let error = APIError(rawValue: response.response!.statusCode) else { return }
                    completion(.failure(error), statusCode)
                    print(statusCode, error)
                }
            }
        print(#function)
    }
}
