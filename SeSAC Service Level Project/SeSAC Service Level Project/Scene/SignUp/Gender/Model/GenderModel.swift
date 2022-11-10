//
//  GenderModel.swift
//  SeSAC Service Level Project
//
//  Created by 이명진 on 2022/11/10.
//

import UIKit

struct Gender {
    let image: UIImage?
    let gender: String
}

struct GenderData {
    var genderList: [Gender] = [
        Gender(image: Icon.man!, gender: "남자"),
        Gender(image: Icon.woman!, gender: "여자")
    ]
}
