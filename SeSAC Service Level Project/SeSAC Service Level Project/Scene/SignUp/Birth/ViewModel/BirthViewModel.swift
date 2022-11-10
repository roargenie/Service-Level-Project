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
    
    let auth = PublishRelay<Date>()
    
    
    struct Input {
        let date: ControlProperty<Date>
    }
    
    struct Output {
        
    }
    
    func ageValidCheck() {
        
    }
//    func transform(input: Input) -> Output {
//
//
//
//        return
//    }
}
