//
//  AuthDetailViewModel.swift
//  SeSAC Service Level Project
//
//  Created by 이명진 on 2022/11/08.
//

import Foundation
import RxSwift
import RxCocoa


final class AuthDetailViewModel: CommonViewModel {
    
    var statusRelay = PublishRelay<Int>()
    
    struct Input {
        let text: ControlProperty<String?> // - 1
        let tap: ControlEvent<Void>
    }
    
    struct Output {
        let validation: Observable<Bool> // - 3
        let tap: Observable<Bool>
        let messageText: ControlProperty<String>
    }
    
    func transform(input: Input) -> Output {
        let valid = input.text // - 2
            .orEmpty
            .map { $0.count >= 6 }
            .share()
        
        let messageText = input.text
            .orEmpty
        
        let tap = input.tap
            .withLatestFrom(valid)
        
        return Output(validation: valid, tap: tap, messageText: messageText)
    }
    
    func requestLogin() {
        APIManager.shared.requestData(Login.self, router: SeSACRouter.login) { [weak self] response, status in
            guard let statusCode = status else { return }
            self?.statusRelay.accept(statusCode)
        }
    }
}
