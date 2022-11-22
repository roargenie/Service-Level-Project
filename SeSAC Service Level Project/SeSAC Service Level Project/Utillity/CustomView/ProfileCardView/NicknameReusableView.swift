//
//  NicknameReusableVIew.swift
//  SeSAC Service Level Project
//
//  Created by 이명진 on 2022/11/15.
//

import UIKit

final class NicknameReusableView: BaseView {
    
    let nicknameLabel: UILabel = UILabel().then {
        $0.text = "김새싹"
        $0.textColor = Color.black
        $0.font = SeSACFont.title1.font
    }
    
    let moreButton: UIButton = UIButton().then {
        $0.setImage(Icon.downarrow, for: .normal)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureUI() {
        [nicknameLabel, moreButton].forEach { self.addSubview($0) }
    }
    
    override func setConstraints() {
        nicknameLabel.snp.makeConstraints { make in
            make.leading.top.bottom.equalToSuperview().inset(16)
        }
        moreButton.snp.makeConstraints { make in
            make.centerY.equalTo(nicknameLabel.snp.centerY)
            make.trailing.equalToSuperview()
            make.width.height.equalTo(48)
        }
    }
    
}
