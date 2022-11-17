//
//  ProfileUnregisterTableViewCell.swift
//  SeSAC Service Level Project
//
//  Created by 이명진 on 2022/11/15.
//

import UIKit

final class ProfileUnregisterTableViewCell: BaseTableViewCell {
    
    let unregisterLabel: UILabel = UILabel().then {
        $0.text = "회원탈퇴"
        $0.font = SeSACFont.title4.font
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
    }
    
    override func configureUI() {
        self.contentView.addSubview(unregisterLabel)
    }
    
    override func setConstraints() {
        unregisterLabel.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview().inset(16)
        }
    }
}
