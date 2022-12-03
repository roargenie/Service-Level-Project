//
//  MyPageModel.swift
//  SeSAC Service Level Project
//
//  Created by 이명진 on 2022/11/27.
//

import Foundation

// MARK: - MyPage

struct MyPage: Codable {
    let searchable, ageMin, ageMax, gender: Int
    let study: String
}

struct MyPageStatus: Codable {
    
}
