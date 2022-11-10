//
//  AuthoView.swift
//  SeSAC Service Level Project
//
//  Created by 이명진 on 2022/11/07.
//

import UIKit
import Then

final class AuthView: BaseView {
    
    let descriptionLabel: UILabel = UILabel().then {
        $0.text = "새싹 서비스 이용을 위해\n휴대폰 번호를 입력해 주세요"
        $0.textAlignment = .center
        $0.numberOfLines = 2
        $0.textColor = Color.black
        $0.font = SeSACFont.display1.font
    }
    
    let phoneNumberTextField: SeSACTextField = SeSACTextField().then {
        $0.setPlaceholder(placeholder: "휴대폰 번호(-없이 숫자만 입력)", color: Color.gray3)
        $0.font = SeSACFont.title4.font
        $0.addLeftPadding()
        $0.keyboardType = .numberPad
    }
    
    let authNotificationButton: SeSACButton = SeSACButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureUI() {
        [descriptionLabel, phoneNumberTextField, authNotificationButton].forEach { self.addSubview($0) }
    }
    
    override func setConstraints() {
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(125)
            make.centerX.equalToSuperview()
        }
        phoneNumberTextField.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(65)
            make.directionalHorizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(46)
        }
        authNotificationButton.snp.makeConstraints { make in
            make.top.equalTo(phoneNumberTextField.snp.bottom).offset(72)
            make.directionalHorizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(48)
        }
    }
    
}
