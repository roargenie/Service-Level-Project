//
//  SignUpView.swift
//  SeSAC Service Level Project
//
//  Created by 이명진 on 2022/11/07.
//

import UIKit


final class NicknameView: BaseView {
    
    let descriptionLabel: UILabel = UILabel().then {
        $0.text = "닉네임을 입력해 주세요"
        $0.textAlignment = .center
        $0.numberOfLines = 2
        $0.textColor = Color.black
        $0.font = SeSACFont.display1.font
    }
    
    let nickNameTextField: SeSACTextField = SeSACTextField().then {
        $0.setPlaceholder(placeholder: "10자 이내로 입력", color: Color.gray3)
        $0.font = SeSACFont.title4.font
        $0.addLeftPadding()
    }
    
    let nextButton: SeSACButton = SeSACButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureUI() {
        [descriptionLabel, nickNameTextField, nextButton].forEach { self.addSubview($0) }
    }
    
    override func setConstraints() {
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(97)
            make.centerX.equalToSuperview()
        }
        nickNameTextField.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(81)
            make.directionalHorizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(46)
        }
        nextButton.snp.makeConstraints { make in
            make.top.equalTo(nickNameTextField.snp.bottom).offset(72)
            make.directionalHorizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(48)
        }
    }
    
}
