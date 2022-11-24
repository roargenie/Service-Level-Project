//
//  SectionModel.swift
//  SeSAC Service Level Project
//
//  Created by 이명진 on 2022/11/23.
//

import Foundation
import RxDataSources

struct StudyList: Hashable {
    let study: String
    
    init(study: String) {
        self.study = study
    }
}

extension StudyList: IdentifiableType, Equatable {
    var identity: String {
        return UUID().uuidString
    }
}

struct SearchSection {
    let header: String
    var items: [StudyList]
}

extension SearchSection: AnimatableSectionModelType {
    typealias Item = StudyList
    typealias Identity = String
    
    var identity: String {
        return header
    }
    
    init(original: SearchSection, items: [Item]) {
        self = original
        self.items = items
    }
}
