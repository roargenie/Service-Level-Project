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
}
