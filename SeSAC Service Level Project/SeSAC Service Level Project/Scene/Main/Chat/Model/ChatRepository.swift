//
//  ChatRepository.swift
//  SeSAC Service Level Project
//
//  Created by 이명진 on 2022/12/24.
//

import Foundation
import RealmSwift

protocol ChatRepositoryType {
    func fetch(uid: String) -> [Payload]
    func addChat(item: ChatDataModel)
}

final class ChatRepository: ChatRepositoryType {
    
    static let shared = ChatRepository()
    
    let localRealm = try! Realm()
    
    private init() { }
    
    func fetch(uid: String) -> [Payload] {
        
        let chatData: [Payload] = ChatRepository.shared.localRealm.objects(ChatDataModel.self).sorted(byKeyPath: "createdAt", ascending: true).map { data in
            
            let id = data.id
            let to = data.to
            let from = data.from
            let chat = data.chat
            let createdAt = data.createdAt
            
            return Payload(id: id, to: to, from: from, chat: chat, createdAt: createdAt.dateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"))
        }.filter { $0.to == uid || $0.from == uid }
        
        return chatData
    }
    
    func fetchLastDateFilter() -> Date? {
        return localRealm.objects(ChatDataModel.self).sorted(byKeyPath: "createdAt", ascending: false).first?.createdAt
    }
    
    func addChat(item: ChatDataModel) {
        do {
            try localRealm.write {
                localRealm.add(item)
            }
        } catch {
            print("error")
        }
    }
}
