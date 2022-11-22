//
//  SearchResultViewModel.swift
//  SeSAC Service Level Project
//
//  Created by 이명진 on 2022/11/21.
//

import Foundation
import RxCocoa
import RxSwift

final class SearchResultViewModel {
    
    var nearSeSAC = BehaviorSubject(value: SearchResult.self)
    var requestSeSAC = BehaviorSubject(value: SearchResult.self)
    
    struct Input {
        
    }

    struct Output {
        
    }

    func transform(input: Input) -> Output {

        
        return Output()
    }
}
