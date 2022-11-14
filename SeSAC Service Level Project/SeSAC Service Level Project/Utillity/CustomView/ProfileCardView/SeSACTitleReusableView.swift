//
//  SeSACTitleReusableVIew.swift
//  SeSAC Service Level Project
//
//  Created by 이명진 on 2022/11/15.
//

import UIKit

final class SeSACTitleReusableView: BaseView {
    
    let sesacTitleLabel: UILabel = UILabel().then {
        $0.text = "새싹 타이틀"
        $0.font = SeSACFont.title6.font
        $0.textColor = Color.black
    }
    
    let mannerButton: SeSACButton = SeSACButton().then {
        $0.setupButton(
            title: "좋은 매너",
            titleColor: Color.black,
            font: SeSACFont.title4.font,
            backgroundColor: Color.white,
            borderWidth: 1,
            borderColor: Color.gray4)
    }
    
    let timeAppointmentButton: SeSACButton = SeSACButton().then {
        $0.setupButton(
            title: "정확한 시간 약속",
            titleColor: Color.black,
            font: SeSACFont.title4.font,
            backgroundColor: Color.white,
            borderWidth: 1,
            borderColor: Color.gray4)
    }
    
    lazy var firstLineStackView: UIStackView = UIStackView(arrangedSubviews: [mannerButton,
                                                                              timeAppointmentButton]).then {
        $0.axis = .horizontal
        $0.spacing = 8
        $0.distribution = .fillEqually
    }
    
    let speedResponseButton: SeSACButton = SeSACButton().then {
        $0.setupButton(
            title: "빠른 응답",
            titleColor: Color.black,
            font: SeSACFont.title4.font,
            backgroundColor: Color.white,
            borderWidth: 1,
            borderColor: Color.gray4)
    }
    
    let kindButton: SeSACButton = SeSACButton().then {
        $0.setupButton(
            title: "친절한 성격",
            titleColor: Color.black,
            font: SeSACFont.title4.font,
            backgroundColor: Color.white,
            borderWidth: 1,
            borderColor: Color.gray4)
    }
    
    lazy var secondLineStackView: UIStackView = UIStackView(arrangedSubviews: [speedResponseButton,
                                                                               kindButton]).then {
        $0.axis = .horizontal
        $0.spacing = 8
        $0.distribution = .fillEqually
    }
    
    let goodAbilityButton: SeSACButton = SeSACButton().then {
        $0.setupButton(
            title: "능숙한 실력",
            titleColor: Color.black,
            font: SeSACFont.title4.font,
            backgroundColor: Color.white,
            borderWidth: 1,
            borderColor: Color.gray4)
    }
    
    let goodTimeButton: SeSACButton = SeSACButton().then {
        $0.setupButton(
            title: "좋은 매너",
            titleColor: Color.black,
            font: SeSACFont.title4.font,
            backgroundColor: Color.white,
            borderWidth: 1,
            borderColor: Color.gray4)
    }
    
    lazy var thirdLineStackView: UIStackView = UIStackView(arrangedSubviews: [goodAbilityButton,
                                                                              goodTimeButton]).then {
        $0.axis = .horizontal
        $0.spacing = 8
        $0.distribution = .fillEqually
    }
    
    lazy var wholeStackView: UIStackView = UIStackView(arrangedSubviews: [firstLineStackView,
                                                                          secondLineStackView,
                                                                          thirdLineStackView]).then {
        $0.axis = .vertical
        $0.spacing = 8
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureUI() {
        [sesacTitleLabel, wholeStackView].forEach { self.addSubview($0) }
    }
    
    override func setConstraints() {
        sesacTitleLabel.snp.makeConstraints { make in
            make.leading.top.equalToSuperview()
        }
        wholeStackView.snp.makeConstraints { make in
            make.top.equalTo(sesacTitleLabel.snp.bottom).offset(16)
            make.leading.trailing.bottom.equalToSuperview()
        }
        firstLineStackView.snp.makeConstraints { make in
            make.height.equalTo(32)
        }
        secondLineStackView.snp.makeConstraints { make in
            make.height.equalTo(32)
        }
        thirdLineStackView.snp.makeConstraints { make in
            make.height.equalTo(32)
        }
        
    }
    
}
