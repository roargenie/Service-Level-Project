//
//  SignUpViewModel.swift
//  SeSAC Service Level Project
//
//  Created by 이명진 on 2022/11/07.
//

import Foundation
import RxSwift
import RxCocoa


final class NicknameViewModel: CommonViewModel {
    
    var authValidation = BehaviorRelay(value: "인증번호 입력")
    
    struct Input {
        let text: ControlProperty<String?>
        let tap: ControlEvent<Void>
    }
    
    struct Output {
        let validation: Observable<Bool>
        let tap: ControlEvent<Void>
        let text: Driver<String>
    }
    
    func transform(input: Input) -> Output {
        let valid = input.text
            .orEmpty
            .map { $0.count > 0 }
            .share()
        
        let text = authValidation.asDriver()
        
        return Output(validation: valid, tap: input.tap, text: text)
    }
}

