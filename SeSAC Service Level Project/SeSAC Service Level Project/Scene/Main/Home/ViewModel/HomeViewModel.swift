//
//  HomeViewModel.swift
//  SeSAC Service Level Project
//
//  Created by 이명진 on 2022/11/14.
//

import Foundation
import RxCocoa
import RxSwift

final class HomeViewModel {
    
    var wholeGenderButton = BehaviorRelay(value: true)
    var maleGenderButton = BehaviorRelay(value: false)
    var femaleGenderButton = BehaviorRelay(value: false)
    
    var searchButtonState = BehaviorRelay<[MyQueueState]>(value: [])
    
    struct Input {
        let searchButtonTap: ControlEvent<Void>
        let wholeGenderButtonTap: ControlEvent<Void>
        let maleGenderButtonTap: ControlEvent<Void>
        let femaleGenderButtonTap: ControlEvent<Void>
    }

    struct Output {
        let searchButtonTap: ControlEvent<Void>
        let wholeGenderButtonTap: ControlEvent<Void>
        let maleGenderButtonTap: ControlEvent<Void>
        let femaleGenderButtonTap: ControlEvent<Void>
    }

    func transform(input: Input) -> Output {
        
        return Output(searchButtonTap: input.searchButtonTap,
                      wholeGenderButtonTap: input.wholeGenderButtonTap,
                      maleGenderButtonTap: input.maleGenderButtonTap,
                      femaleGenderButtonTap: input.femaleGenderButtonTap)
    }
    
    func requestMyQueueState() {
        print(#function, "================================")
        APIManager.shared.requestData(MyQueueState.self,
                                      router: SeSACRouter.myQueueState) { response, statusCode in
            print(response)
            guard let statusCode = statusCode else { return }
            print("=============status", statusCode)
            switch response {
            case .success(let value):
                guard let value = value else { return }
                print("내 상태다!!!!!!!!!!!!!!!!!!!!!!!!!!!", value, statusCode)
            case .failure(let error):
                print(error.rawValue)
                print(error.localizedDescription)
            }
        }
    }
    
    
    
    
}
