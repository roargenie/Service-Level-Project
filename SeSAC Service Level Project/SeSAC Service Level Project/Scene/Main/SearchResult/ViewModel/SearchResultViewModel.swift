//
//  SearchResultViewModel.swift
//  SeSAC Service Level Project
//
//  Created by 이명진 on 2022/11/21.
//

import Foundation
import RxCocoa
import RxSwift

final class SearchResultViewModel {
    
    var nearSeSAC = BehaviorRelay<[FromQueueDB]>(value: [])
    var requestSeSAC = BehaviorRelay<[FromQueueDB]>(value: [])
    
    var requestStatus = PublishRelay<Int>()
    
    struct Input {
        
    }

    struct Output {
        
    }

    func transform(input: Input) -> Output {

        
        return Output()
    }
    
    func requestNearSeSAC() {
        APIManager.shared.requestData(SearchResult.self,
                                      router: SeSACRouter.search(Search(lat: UserDefaults.standard.double(forKey: "lat"),
                                                                        long: UserDefaults.standard.double(forKey: "long")))) { [weak self] response, statusCode in
            guard let statusCode = statusCode,
                  let self = self else { return }
            print(statusCode)
            switch response {
            case .success(let value):
                guard let value = value else { return }
                self.nearSeSAC.accept(value.fromQueueDB)
                print("응답하라 🟢===========", self.nearSeSAC.value)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func requestReceivedRequest() {
        APIManager.shared.requestData(SearchResult.self,
                                      router: SeSACRouter.search(Search(lat: UserDefaults.standard.double(forKey: "lat"),
                                                                        long: UserDefaults.standard.double(forKey: "long")))) { [weak self] response, statusCode in
            guard let statusCode = statusCode,
                  let self = self else { return }
            print(statusCode)
            switch response {
            case .success(let value):
                guard let value = value else { return }
                self.requestSeSAC.accept(value.fromQueueDBRequested)
                print("응답하라 🟢===========", self.requestSeSAC.value)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func requestStudyRequest(_ uid: String) {
        APIManager.shared.requestData(Int.self,
                                      router: SeSACRouter.studyRequest(StudyRequest(otheruid: uid))) { [weak self] response, statusCode in
            guard let statusCode = statusCode,
                  let self = self else { return }
            print("🟢===========", statusCode)
            self.requestStatus.accept(statusCode)
        }
    }
}
