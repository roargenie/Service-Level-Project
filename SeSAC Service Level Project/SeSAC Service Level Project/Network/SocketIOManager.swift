//
//  SocketIOManager.swift
//  SeSAC Service Level Project
//
//  Created by 이명진 on 2022/12/16.
//

import Foundation
import SocketIO

final class SocketIOManager {
    
    static let shared = SocketIOManager()
    
    // 서버와 메시지를 주고 받기 위한 클래스
    var manager: SocketManager!
    
    var socket: SocketIOClient!
    
    private init() {
        
        manager = SocketManager(socketURL: URL(string: EndPoint.BaseURL)!, config: [
           .forceWebsockets(true)
        ])
        
        socket = manager.defaultSocket
        
        // 연결
        socket.on(clientEvent: .connect) { data, ack in
            print("SOCKET IS CONNECTED", data, ack)
            guard let myUID = UserDefaults.standard.string(forKey: Matrix.myUID) else { return }
            self.socket.emit("changesocketid", myUID)
        }
        
        // 연결해제
        socket.on(clientEvent: .disconnect) { data, ack in
            print("SOCKET IS DISCONNECTED", data, ack)
        }
        
        // 이벤트 수신
        socket.on("chat") { dataArray, ack in
            print("SESAC RECEIVED", dataArray, ack)
            let data = dataArray[0] as! NSDictionary
            let id = data["_id"] as! String
            let to = data["to"] as! String
            let from = data["from"] as! String
            let chat = data["chat"] as! String
            let createdAt = data["createdAt"] as! String
            
            print("CHECK >>>\(dataArray)", chat, from, createdAt)
            
            NotificationCenter.default.post(name: NSNotification.Name("getMessage"), object: self, userInfo: ["id": id, "chat": chat, "createdAt": createdAt, "from": from, "to": to])
        }
    }
    
    func establishConnection() {
        socket.connect()
    }
    
    func closeConnection() {
        socket.disconnect()
    }
    
}
