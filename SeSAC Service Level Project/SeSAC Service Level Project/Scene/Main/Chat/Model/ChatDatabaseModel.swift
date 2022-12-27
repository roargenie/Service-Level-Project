//
//  ChatDatabaseModel.swift
//  SeSAC Service Level Project
//
//  Created by 이명진 on 2022/12/24.
//

import UIKit
import RealmSwift

class ChatDataModel: Object {
    
    @Persisted var id: String
    @Persisted var to: String
    @Persisted var from: String
    @Persisted var chat: String
    @Persisted var createdAt: Date
    
    @Persisted(primaryKey: true) var objectId: ObjectId
    
    convenience init(id: String, to: String, from: String, chat: String, createdAt: Date) {
        self.init()
        self.id = id
        self.to = to
        self.from = from
        self.chat = chat
        self.createdAt = createdAt
    }
}
