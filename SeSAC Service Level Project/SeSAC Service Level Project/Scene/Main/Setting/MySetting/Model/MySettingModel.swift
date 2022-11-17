//
//  MySettingModel.swift
//  SeSAC Service Level Project
//
//  Created by 이명진 on 2022/11/15.
//

import UIKit

struct MySettingModel {
    let profileImage: UIImage?
    let text: String
}

struct MySettingModelData {
    let data: [MySettingModel] = [
        MySettingModel(profileImage: Icon.sesacface, text: "김새싹"),
        MySettingModel(profileImage: Icon.notice, text: "공지사항"),
        MySettingModel(profileImage: Icon.faq, text: "자주 묻는 질문"),
        MySettingModel(profileImage: Icon.qna, text: "1:1 문의"),
        MySettingModel(profileImage: Icon.settingAlarm, text: "알림 설정"),
        MySettingModel(profileImage: Icon.permit, text: "이용 약관")
    ]
}

enum Setting: Int, CaseIterable {
    case notice, faq, qna, settingAlarm, permit
    
    var image: [UIImage?] {
        return [Icon.notice,
                Icon.faq,
                Icon.qna,
                Icon.settingAlarm,
                Icon.permit]
    }
    
    var text: [String] {
        return ["공지사항", "자주 묻는 질문", "1:1 문의", "알림 설정", "이용 약관"]
    }
}

