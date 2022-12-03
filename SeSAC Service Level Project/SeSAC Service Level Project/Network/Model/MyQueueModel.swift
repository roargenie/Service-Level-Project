//
//  MyQueueModel.swift
//  SeSAC Service Level Project
//
//  Created by 이명진 on 2022/11/27.
//

import Foundation

// MARK: - MyQueue

struct MyQueue: Codable {
    let long, lat: Double
    let studylist: [String]
}

struct MyQueueStatus: Codable {
    
}
