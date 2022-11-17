//
//  MyProfileCell.swift
//  SeSAC Service Level Project
//
//  Created by 이명진 on 2022/11/16.
//

import UIKit

final class MyProfileCell: BaseTableViewCell {
    
    let profileImageView: UIImageView = UIImageView().then {
        $0.layer.borderWidth = 1
        $0.layer.borderColor = Color.gray2.cgColor
    }
    
    let myNicknameLabel: UILabel = UILabel().then {
        $0.text = "김새싹"
        $0.font = SeSACFont.title1.font
    }
    
    let nextIndicatorImageView: UIImageView = UIImageView().then {
        $0.image = Icon.moreArrow
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    override func configureUI() {
        selectionStyle = .none
        [profileImageView, myNicknameLabel, nextIndicatorImageView]
            .forEach { self.contentView.addSubview($0) }
    }
    
    override func setConstraints() {
        profileImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(15)
            make.top.bottom.equalToSuperview().inset(20)
            make.width.height.equalTo(50)
        }
        myNicknameLabel.snp.makeConstraints { make in
            make.leading.equalTo(profileImageView.snp.trailing).offset(14)
            make.centerY.equalTo(profileImageView.snp.centerY)
        }
        nextIndicatorImageView.snp.makeConstraints { make in
            make.centerY.equalTo(profileImageView.snp.centerY)
            make.trailing.equalToSuperview().offset(-20)
        }
    }
}
