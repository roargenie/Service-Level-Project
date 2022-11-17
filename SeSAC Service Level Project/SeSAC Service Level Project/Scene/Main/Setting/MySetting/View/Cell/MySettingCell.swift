//
//  MySettingCell.swift
//  SeSAC Service Level Project
//
//  Created by 이명진 on 2022/11/16.
//

import UIKit

final class MySettingCell: BaseTableViewCell {
    
    let settingImageView: UIImageView = UIImageView()
    
    let settingLabel: UILabel = UILabel().then {
        $0.font = SeSACFont.title2.font
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    override func configureUI() {
        selectionStyle = .none
        [settingImageView, settingLabel]
            .forEach { self.contentView.addSubview($0) }
    }
    
    override func setConstraints() {
        settingImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(15)
            make.top.bottom.equalToSuperview().inset(20)
            make.width.height.equalTo(25)
        }
        settingLabel.snp.makeConstraints { make in
            make.leading.equalTo(settingImageView.snp.trailing).offset(14)
            make.centerY.equalTo(settingImageView.snp.centerY)
        }
    }
}
