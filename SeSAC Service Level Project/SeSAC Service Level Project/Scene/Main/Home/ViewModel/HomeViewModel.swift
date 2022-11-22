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
}
