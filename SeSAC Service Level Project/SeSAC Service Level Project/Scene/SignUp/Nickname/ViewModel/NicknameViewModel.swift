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
    
    var authValidation = PublishRelay<String>()
    
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
            .map { [weak self] in self?.checkNickname(with: $0) == true }
            .share()
        
        let text = authValidation.asDriver(onErrorJustReturn: "")
        
        return Output(validation: valid, tap: input.tap, text: text)
    }
    
    func checkNickname(with nicknamdText: String) -> Bool {
        let regex = "[가-힣A-Za-z0-9]{1,10}"
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: nicknamdText)
    }
    
}

