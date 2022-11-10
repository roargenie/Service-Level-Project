//
//  BirthView.swift
//  SeSAC Service Level Project
//
//  Created by 이명진 on 2022/11/08.
//

import UIKit


final class BirthView: BaseView {
    
    let descriptionLabel: UILabel = UILabel().then {
        $0.text = "생년월일을 알려주세요"
        $0.textAlignment = .center
        $0.numberOfLines = 2
        $0.textColor = Color.black
        $0.font = SeSACFont.display1.font
    }
    
    lazy var yearTextField: SeSACTextField = SeSACTextField().then {
        $0.setPlaceholder(placeholder: "1990", color: Color.gray3)
        $0.font = SeSACFont.title4.font
        $0.addLeftPadding()
        $0.inputView = datePicker
    }
    
    lazy var monthTextField: SeSACTextField = SeSACTextField().then {
        $0.setPlaceholder(placeholder: "1", color: Color.gray3)
        $0.font = SeSACFont.title4.font
        $0.addLeftPadding()
        $0.inputView = datePicker
    }
    
    lazy var dayTextField: SeSACTextField = SeSACTextField().then {
        $0.setPlaceholder(placeholder: "1", color: Color.gray3)
        $0.font = SeSACFont.title4.font
        $0.addLeftPadding()
        $0.inputView = datePicker
    }
    
    let yearLabel: UILabel = UILabel().then {
        $0.text = "년"
        $0.textColor = Color.black
        $0.font = SeSACFont.title2.font
        $0.textAlignment = .center
    }
    
    let monthLabel: UILabel = UILabel().then {
        $0.text = "월"
        $0.textColor = Color.black
        $0.font = SeSACFont.title2.font
        $0.textAlignment = .center
    }
    
    let dayLabel: UILabel = UILabel().then {
        $0.text = "일"
        $0.textColor = Color.black
        $0.font = SeSACFont.title2.font
        $0.textAlignment = .center
    }
    
    let datePicker: UIDatePicker = UIDatePicker().then {
        $0.locale = Locale(identifier: "ko-KR")
        $0.datePickerMode = .date
        $0.preferredDatePickerStyle = .wheels
    }
    
    let nextButton: SeSACButton = SeSACButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureUI() {
        [descriptionLabel, yearTextField, monthTextField, dayTextField, yearLabel, monthLabel, dayLabel, nextButton]
            .forEach { self.addSubview($0) }
    }
    
    override func setConstraints() {
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(97)
            make.centerX.equalToSuperview()
        }
        yearTextField.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(81)
            make.leading.equalToSuperview().offset(16)
            make.height.equalTo(46)
            make.width.equalTo(80)
        }
        monthTextField.snp.makeConstraints { make in
            make.leading.equalTo(yearTextField.snp.trailing).offset(42)
            make.height.equalTo(46)
            make.width.equalTo(80)
            make.bottom.equalTo(yearTextField.snp.bottom)
        }
        dayTextField.snp.makeConstraints { make in
            make.leading.equalTo(monthTextField.snp.trailing).offset(42)
            make.height.equalTo(46)
            make.width.equalTo(80)
            make.bottom.equalTo(monthTextField.snp.bottom)
        }
        yearLabel.snp.makeConstraints { make in
            make.leading.equalTo(yearTextField.snp.trailing).offset(4)
            make.trailing.equalTo(monthTextField.snp.leading).offset(-23)
            make.centerY.equalTo(yearTextField.snp.centerY)
        }
        monthLabel.snp.makeConstraints { make in
            make.leading.equalTo(monthTextField.snp.trailing).offset(4)
            make.trailing.equalTo(dayTextField.snp.leading).offset(-23)
            make.centerY.equalTo(yearTextField.snp.centerY)
        }
        dayLabel.snp.makeConstraints { make in
            make.leading.equalTo(dayTextField.snp.trailing).offset(4)
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalTo(yearTextField.snp.centerY)
        }
//        datePicker.snp.makeConstraints { make in
//            make.leading.trailing.bottom.equalToSuperview()
//            make.top.equalTo(nextButton.snp.bottom).offset(130)
//        }
        nextButton.snp.makeConstraints { make in
            make.top.equalTo(yearTextField.snp.bottom).offset(72)
            make.directionalHorizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(48)
        }
    }
    
}
