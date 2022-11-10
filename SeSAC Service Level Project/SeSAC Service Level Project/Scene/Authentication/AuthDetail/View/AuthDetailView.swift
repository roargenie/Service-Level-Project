//
//  AuthDetailView.swift
//  SeSAC Service Level Project
//
//  Created by 이명진 on 2022/11/08.
//

import UIKit


final class AuthDetailView: BaseView {
    
    let descriptionLabel: UILabel = UILabel().then {
        $0.text = "인증번호가 문자로 전송되었어요"
        $0.textAlignment = .center
        $0.textColor = Color.black
        $0.font = SeSACFont.display1.font
    }
    
    let timerLabel: UILabel = UILabel().then {
        $0.text = "05:00"
        $0.font = SeSACFont.title3.font
        $0.textColor = Color.green
    }
    
    let authNumberTextField: SeSACTextField = SeSACTextField().then {
        $0.setPlaceholder(placeholder: "인증번호 입력", color: Color.gray3)
        $0.font = SeSACFont.title4.font
        $0.addLeftPadding()
        $0.keyboardType = .numberPad
    }
    
    let startButton: SeSACButton = SeSACButton()
    
    let repeatButon: SeSACButton = SeSACButton().then {
        $0.setupButton(title: "재전송", titleColor: Color.white, font: SeSACFont.body3.font, backgroundColor: Color.green, borderWidth: 0, borderColor: .clear)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureUI() {
        [descriptionLabel, authNumberTextField, timerLabel, startButton, repeatButon].forEach { self.addSubview($0) }
    }
    
    override func setConstraints() {
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(80)
            make.centerX.equalToSuperview()
        }
        timerLabel.snp.makeConstraints { make in
            make.trailing.equalTo(authNumberTextField.snp.trailing).inset(12)
            make.directionalVerticalEdges.equalTo(authNumberTextField.snp.directionalVerticalEdges).inset(12)
        }
        authNumberTextField.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(98)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalTo(repeatButon.snp.leading).offset(-8)
            make.height.equalTo(46)
        }
        repeatButon.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalTo(authNumberTextField.snp.bottom)
            make.width.equalTo(72)
            make.height.equalTo(40)
        }
        startButton.snp.makeConstraints { make in
            make.top.equalTo(authNumberTextField.snp.bottom).offset(72)
            make.directionalHorizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(48)
        }
    }
}
