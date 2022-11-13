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
        let datePickerChange: ControlEvent<Date>
        let tap: ControlEvent<Void>
    }
    
    func transform(input: Input) -> Output {
        let datePickerChanged = input.date
            .changed
        let tap = input.tap
        
        return Output(datePickerChange: datePickerChanged, tap: tap)
    }
}
