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
    
    var signValidation = PublishRelay<Bool>()
    
    struct Input {
//        let celltap: ControlEvent<IndexPath>
        let tap: ControlEvent<Void>
    }

    struct Output {
//        let validation: Observable<Bool>
//        let celltap: ControlEvent<IndexPath>
        let tap: ControlEvent<Void>
    }

    func transform(input: Input) -> Output {
//        let valid = input.celltap


//        let text = signValidation.asDriver()

        return Output(tap: input.tap)
    }
}
