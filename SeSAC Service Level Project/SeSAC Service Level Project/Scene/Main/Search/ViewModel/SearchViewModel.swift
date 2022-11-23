//
//  SearchViewModel.swift
//  SeSAC Service Level Project
//
//  Created by 이명진 on 2022/11/14.
//

import Foundation
import RxSwift
import RxCocoa

final class SearchViewModel {
    
    
    struct Input {
        let celltap: ControlEvent<IndexPath>
    }

    struct Output {
        let celltap: ControlEvent<IndexPath>
    }

    func transform(input: Input) -> Output {

        
        return Output(celltap: input.celltap)
    }
}
