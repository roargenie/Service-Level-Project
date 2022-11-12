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
    
    typealias Completion<T> = ((Result<T, APIError>) -> Void)
    
    func requestData<T: Decodable>(_ object: T.Type = T.self,
                                   router: SeSACRouter,
                                   completion: @escaping Completion<T>) {
        AF.request(router)
            .responseDecodable(of: object) { response in
                guard let statusCode = response.response?.statusCode else { return }
                switch response.result {
                case .success(let data):
                    completion(.success(data))
                    
                case .failure(_):
                    guard let error = APIError(rawValue: statusCode) else { return }
                    completion(.failure(error))
                    print(error.localizedDescription)
                }
            }
    }
}
