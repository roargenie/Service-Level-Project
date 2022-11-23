//
//  SectionModel.swift
//  SeSAC Service Level Project
//
//  Created by 이명진 on 2022/11/23.
//

import Foundation
import RxDataSources

//struct StudyList: Hashable {
//    let study: String
//    let recommend: String
//
//    init(study: String, recommend: String) {
//        self.study = study
//        self.recommend = recommend
//    }
//}
//
//extension StudyList: IdentifiableType, Equatable {
//    var identity: String {
//        return UUID().uuidString
//    }
//}

struct SearchSection: Hashable {
    let header: String
    var items: [String]
}

extension SearchSection: AnimatableSectionModelType {
    typealias Item = String
    
    var identity: String {
        return header
    }
    
    init(original: SearchSection, items: [String]) {
        self = original
        self.items = items
    }
}
