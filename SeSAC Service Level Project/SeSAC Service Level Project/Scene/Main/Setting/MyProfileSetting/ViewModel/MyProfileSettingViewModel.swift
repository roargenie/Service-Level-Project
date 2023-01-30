//
//  ProfileViewModel.swift
//  SeSAC Service Level Project
//
//  Created by 이명진 on 2022/11/14.
//

import Foundation
import RxSwift
import RxCocoa

final class MyProfileSettingViewModel {
    
    var myProfileSetting = BehaviorSubject<[Login]>(value: [])
    var withdrawResponse = PublishRelay<Int>()
    
    struct Input {
        
    }

    struct Output {
        
    }

    func transform(input: Input) -> Output {


        return Output()
    }
    
    func requestMyProfile() {
        APIManager.shared.requestData(Login.self,
                                      router: SeSACRouter.login) { [weak self] response, statusCode in
            guard let self = self else { return }
            
            switch response {
            case .success(let value):
                guard let value = value else { return }
                self.myProfileSetting.onNext([value, value, value])
            case .failure(let error):
                self.myProfileSetting.onError(error)
            }
        }
    }
    
    func requestWithdraw() {
        APIManager.shared.requestData(Int.self,
                                      router: SeSACRouter.withdraw) { [weak self] response, statusCode in
            guard let statusCode = statusCode,
                  let self = self else { return }
            self.withdrawResponse.accept(statusCode)
        }
    }
}
