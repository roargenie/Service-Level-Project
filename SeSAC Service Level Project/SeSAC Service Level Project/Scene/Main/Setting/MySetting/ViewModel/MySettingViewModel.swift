//
//  MySettingViewModel.swift
//  SeSAC Service Level Project
//
//  Created by 이명진 on 2022/11/15.
//

import Foundation
import RxSwift
import RxCocoa

final class MySettingViewModel {
    
    var mySetting = Observable.of(MySettingModelData().data)
//    var setting = Observable.of(Setting.allCases)
    
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
