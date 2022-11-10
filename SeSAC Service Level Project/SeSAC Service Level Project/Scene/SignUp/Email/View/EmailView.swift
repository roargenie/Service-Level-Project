//
//  EmailView.swift
//  SeSAC Service Level Project
//
//  Created by 이명진 on 2022/11/08.
//

import UIKit


final class EmailView: BaseView {
    
    let descriptionLabel: UILabel = UILabel().then {
        $0.text = "이메일을 입력해 주세요"
        $0.textAlignment = .center
        $0.textColor = Color.black
        $0.font = SeSACFont.display1.font
    }
    
    let subDescriptionLabel: UILabel = UILabel().then {
        $0.text = "휴대폰 번호 변경 시 인증을 위해 사용해요"
        $0.textAlignment = .center
        $0.textColor = Color.gray7
        $0.font = SeSACFont.title2.font
    }
    
    let emailTextField: SeSACTextField = SeSACTextField().then {
        $0.setPlaceholder(placeholder: "SeSAC@email.com", color: Color.gray3)
        $0.font = SeSACFont.title4.font
        $0.addLeftPadding()
        $0.keyboardType = .emailAddress
        $0.becomeFirstResponder()
    }
    
    let nextButton: SeSACButton = SeSACButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureUI() {
        [descriptionLabel, subDescriptionLabel, emailTextField, nextButton].forEach { self.addSubview($0) }
    }
    
    override func setConstraints() {
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(80)
            make.centerX.equalToSuperview()
        }
        subDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(subDescriptionLabel.snp.bottom).offset(64)
            make.directionalHorizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(46)
        }
        nextButton.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(72)
            make.directionalHorizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(48)
        }
    }
    
}

