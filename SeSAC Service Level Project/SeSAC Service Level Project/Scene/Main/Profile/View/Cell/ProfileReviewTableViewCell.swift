//
//  ProfileReviewTableViewCell.swift
//  SeSAC Service Level Project
//
//  Created by 이명진 on 2022/11/14.
//

import UIKit

final class ProfileReviewTableViewCell: BaseTableViewCell {
    
    let myGenderLabel: UILabel = UILabel().then {
        $0.text = "내 성별"
        $0.font = SeSACFont.title4.font
    }
    
    let maleButton: SeSACButton = SeSACButton().then {
        $0.setupButton(
            title: "남자",
            titleColor: Color.white,
            font: SeSACFont.body3.font,
            backgroundColor: Color.green,
            borderWidth: 0,
            borderColor: .clear)
    }
    
    let femaleButton: SeSACButton = SeSACButton().then {
        $0.setupButton(
            title: "여자",
            titleColor: Color.black,
            font: SeSACFont.body3.font,
            backgroundColor: Color.white,
            borderWidth: 1,
            borderColor: Color.gray4)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    override func configureUI() {
        
    }
    
    override func setConstraints() {
        
    }
}
