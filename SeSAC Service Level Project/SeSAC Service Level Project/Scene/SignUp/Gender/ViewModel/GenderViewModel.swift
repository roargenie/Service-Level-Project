//
//  GenderViewModel.swift
//  SeSAC Service Level Project
//
//  Created by 이명진 on 2022/11/08.
//

import Foundation
import RxSwift
import RxCocoa

final class GenderViewModel {
    
    var gender = Observable.of(GenderData().genderList)
    var statusRelay = PublishRelay<Int>()
    
    struct Input {
        let celltap: ControlEvent<IndexPath>
        let tap: ControlEvent<Void>
    }
    
    struct Output {
        let gender: Observable<[Gender]>
        let celltap: ControlEvent<IndexPath>
        let tap: Observable<ControlEvent<IndexPath>.Element>
    }

    func transform(input: Input) -> Output {
        let valid = input.celltap
        
        let tap = input.tap
            .withLatestFrom(valid)
        
        return Output(gender: gender, celltap: input.celltap, tap: tap)
    }
    
    func requestSignUp() {
        let userDefaults = UserDefaults.standard
        APIManager.shared.requestData(SignUpStatus.self,
                                      router: SeSACRouter
            .signup(SignUp(phoneNumber: userDefaults.string(forKey: Matrix.phoneNumber)!,
                           fcMtoken: userDefaults.string(forKey: Matrix.FCMToken) ?? "dzjnejNDh0d0u1aLzfS547:APA91bFvQSjDVFC4-2IA0QQ08KqsEKwIoK2hFBZIfdyNLPd22PvgLD6YM_kyQgv0BIK-1zjltbbKYQTGK50Pn21bctsuEC46qo7RDkcImbzyZBe0-ffMqhFhL4DO5tbP0Ri_Wn-vRVF5",
                           nick: userDefaults.string(forKey: Matrix.nickname)!,
                           birth: userDefaults.string(forKey: Matrix.birth)!,
                           email: userDefaults.string(forKey: Matrix.email)!,
                           gender: userDefaults.integer(forKey: Matrix.gender)))) { [weak self] response, statusCode in
            
            guard let statusCode = statusCode,
                  let self = self else { return }
            print(statusCode)
            self.statusRelay.accept(statusCode)
        }
    }
}
