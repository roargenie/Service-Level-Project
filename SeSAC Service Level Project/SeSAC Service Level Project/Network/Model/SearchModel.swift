//
//  SearchModel.swift
//  SeSAC Service Level Project
//
//  Created by 이명진 on 2022/11/19.
//

import Foundation
import RxDataSources


//MARK: - Search

struct Search: Codable {
    let lat, long: Double
}

// MARK: - SearchResult

struct SearchResult: Codable, Hashable {
    let fromQueueDB, fromQueueDBRequested: [FromQueueDB]
    let fromRecommend: [String]
}

// MARK: - FromQueueDB

struct FromQueueDB: Codable, Hashable {
    let uid, nick: String
    let lat, long: Double
    let reputation: [Int]
    let studylist, reviews: [String]
    let gender, type, sesac, background: Int
}


// MARK: - SearchResult

//struct SearchResult: Codable, Hashable {
//    let fromQueueDB, fromQueueDBRequested: [FromQueueDB]
//    let fromRecommend: [String]
//
//    init(fromQueueDB: [FromQueueDB], fromQueueDBRequested: [FromQueueDB], fromRecommend: [String]) {
//        self.fromQueueDB = fromQueueDB
//        self.fromQueueDBRequested = fromQueueDBRequested
//        self.fromRecommend = fromRecommend
//    }
//}

// MARK: - FromQueueDB
//
//struct FromQueueDB: Codable, Hashable {
//    let uid, nick: String
//    let lat, long: Double
//    let reputation: [Int]
//    let studylist, reviews: [String]
//    let gender, type, sesac, background: Int
//
//    init(uid: String, nick: String, lat: Double, long: Double, reputation: [Int], studylist: [String], reviews: [String], gender: Int, type: Int, sesac: Int, background: Int) {
//        self.uid = uid
//        self.nick = nick
//        self.lat = lat
//        self.long = long
//        self.reputation = reputation
//        self.studylist = studylist
//        self.reviews = reviews
//        self.gender = gender
//        self.type = type
//        self.sesac = sesac
//        self.background = background
//    }
//}
//
//extension SearchResult: IdentifiableType, Equatable {
//    var identity: String {
//        return UUID().uuidString
//    }
//}
//
//extension FromQueueDB: IdentifiableType, Equatable {
//    var identity: String {
//        return UUID().uuidString
//    }
//}

