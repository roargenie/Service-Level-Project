//
//  AuthViewModel.swift
//  SeSAC Service Level Project
//
//  Created by 이명진 on 2022/11/07.
//

import Foundation
import RxSwift
import RxCocoa

final class AuthViewModel: CommonViewModel {
    
    var authValidation = PublishRelay<String>()
    
    struct Input {
        let text: ControlProperty<String?>
        let tap: ControlEvent<Void>
    }
    
    struct Output {
        let validation: Observable<Bool>
        let phoneNumberText: ControlProperty<String>
        let tap: Observable<Bool>
    }
    
    func transform(input: Input) -> Output {
        let valid = input.text
            .orEmpty
            .map { [weak self] in $0.count >= 11 && self?.checkPhoneNumber(with: $0) == true }
            .share()
        
        let phoneText = input.text
            .orEmpty
        
        let tap = input.tap
            .withLatestFrom(valid)
        
        return Output(validation: valid, phoneNumberText: phoneText, tap: tap)
    }
    
    func checkPhoneNumber(with phoneText: String) -> Bool {
        let regex = "^01([0-9]?)-?([0-9]{3,4})-?([0-9]{4})$"
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: phoneText)
    }
    
    func addHyphen(text: String) {
        if text.count > 3 && text.count < 8 {
            let phoneText = text.replacingOccurrences(of: "(\\d{3})(\\d{1})", with: "$1-$2", options: .regularExpression, range: nil)
            authValidation.accept(phoneText)
        } else if text.count > 6 && text.count <= 10 {
            let phoneText = text.replacingOccurrences(of: "(\\d{3})-(\\d{4})(\\d{1})", with: "$1-$2-$3", options: .regularExpression, range: nil)
            authValidation.accept(phoneText)
        }
    }
    
    func removeHyphen(text: String) -> String {
        let phoneText = text.replacingOccurrences(of: "-", with: "")
        // 첫번째 0도 지워줘야 함.
        return phoneText
    }
    
}


