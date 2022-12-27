//
//  ChatViewModel.swift
//  SeSAC Service Level Project
//
//  Created by 이명진 on 2022/12/04.
//

import Foundation
import RxCocoa
import RxSwift

final class ChatViewModel {
    
    var studyDodgeStatus = PublishRelay<Int>()
    
    struct Input {
        
    }

    struct Output {
        
    }

    func transform(input: Input) -> Output {

        
        return Output()
    }
    
    func requestStudyDodge(uid: String) {
        APIManager.shared.requestData(Int.self,
                                      router: SeSACRouter.dodge(StudyDodge(otheruid: uid))) { [weak self] response, statusCode in
            guard let statusCode = statusCode,
                  let self = self else { return }
            self.studyDodgeStatus.accept(statusCode)
            print(statusCode)
        }
    }
    
}
