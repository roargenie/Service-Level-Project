//
//  Alert.swift
//  SeSAC Service Level Project
//
//  Created by 이명진 on 2022/12/04.
//

import Foundation


@frozen enum Alert {
    case withdraw
    case studyRequest
    case studyAccept
    case studyCancel
    
    var title: String {
        switch self {
        case .withdraw:
            return "정말 탈퇴하시겠습니까?"
        case .studyRequest:
            return "스터디를 요청할게요!"
        case .studyAccept:
            return "스터디를 수락할까요?"
        case .studyCancel:
            return "스터디를 취소하겠습니까?"
        }
    }
    
    var subtitle: String {
        switch self {
        case .withdraw:
            return "탈퇴하시면 새싹 스터디를 이용할 수 없어요ㅠ"
        case .studyRequest:
            return "상대방이 요청을 수락하면\n채팅창에서 대화를 나눌 수 있어요"
        case .studyAccept:
            return "요청을 수락하면 채팅창에서 대화를 나눌 수 있어요"
        case .studyCancel:
            return "스터디를 취소하시면 패널티가 부과됩니다"
        }
    }
}
