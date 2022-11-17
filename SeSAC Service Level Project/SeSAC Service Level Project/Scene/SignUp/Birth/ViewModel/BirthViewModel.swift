//
//  BirthViewModel.swift
//  SeSAC Service Level Project
//
//  Created by 이명진 on 2022/11/08.
//

import Foundation
import RxSwift
import RxCocoa


final class BirthViewModel {
    
    struct Input {
        let date: ControlProperty<Date>
        let tap: ControlEvent<Void>
    }
    
    struct Output {
        let validation: Observable<Bool>
        let datePickerChange: ControlEvent<Date>
        let tap: Observable<Bool>
    }
    
    func transform(input: Input) -> Output {
        let valid = input.date
            .map { $0.ageValid() ? true : false }
        
        let datePickerChanged = input.date
            .changed
        
        let tap = input.tap
            .withLatestFrom(valid)
        
        return Output(validation: valid, datePickerChange: datePickerChanged, tap: tap)
    }
}
