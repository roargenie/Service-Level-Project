//
//  SearchModel.swift
//  SeSAC Service Level Project
//
//  Created by 이명진 on 2022/11/19.
//

import Foundation


import Foundation

//MARK: - Search

struct Search: Codable {
    let lat, long: Double
}

// MARK: - SearchResult

struct SearchResult: Codable {
    let fromQueueDB, fromQueueDBRequested: [FromQueueDB]
    let fromRecommend: [String]
}

// MARK: - FromQueueDB

struct FromQueueDB: Codable {
    let uid, nick: String
    let lat, long: Double
    let reputation: [Int]
    let studylist, reviews: [String]
    let gender, type, sesac, background: Int
}


