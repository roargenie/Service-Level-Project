//
//  ImageTableViewCell.swift
//  SeSAC Service Level Project
//
//  Created by 이명진 on 2022/11/14.
//

import UIKit

final class ProfileImageTableViewCell: BaseTableViewCell {
    
    let profileImageView: UIImageView = UIImageView().then {
        $0.image = Icon.profileImg
        $0.makeRoundedCorners(8)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    override func configureUI() {
        selectionStyle = .none
        self.contentView.addSubview(profileImageView)
    }
    
    override func setConstraints() {
        profileImageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview()
        }
    }
}
