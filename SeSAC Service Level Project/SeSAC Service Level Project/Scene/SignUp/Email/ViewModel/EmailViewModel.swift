//
//  EmailViewModel.swift
//  SeSAC Service Level Project
//
//  Created by 이명진 on 2022/11/08.
//

import Foundation
import RxSwift
import RxCocoa

final class EmailViewModel: CommonViewModel {
    
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
            .map { [weak self] in self?.checkEmail(with: $0) == true }
            .share()
        
        let text = authValidation.asDriver(onErrorJustReturn: "")
        
        return Output(validation: valid, tap: input.tap, text: text)
    }
    
    func checkEmail(with emailText: String) -> Bool {
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: emailText)
    }
    
}
