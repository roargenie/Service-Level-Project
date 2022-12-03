//
//  NearSeSACModel.swift
//  SeSAC Service Level Project
//
//  Created by 이명진 on 2022/12/03.
//

import Foundation

struct NearSeSACDTO {
    let uid, nick: String
    let reputation: [Int]
    let studylist, reviews: [String]
    let sesac, background: Int
    var isSelected: Bool
}
