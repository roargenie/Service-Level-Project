//
//  ProfileReviewTableViewCell.swift
//  SeSAC Service Level Project
//
//  Created by 이명진 on 2022/11/14.
//

import UIKit
import MultiSlider

final class ProfileReviewTableViewCell: BaseTableViewCell {
    
    let myGenderLabel: UILabel = UILabel().then {
        $0.text = "내 성별"
        $0.font = SeSACFont.title4.font
    }
    
    let maleButton: SeSACButton = SeSACButton().then {
        $0.setupButton(
            title: "남자",
            titleColor: Color.black,
            font: SeSACFont.body3.font,
            backgroundColor: Color.white,
            borderWidth: 1,
            borderColor: Color.gray4)
    }
    
    let femaleButton: SeSACButton = SeSACButton().then {
        $0.setupButton(
            title: "여자",
            titleColor: Color.black,
            font: SeSACFont.body3.font,
            backgroundColor: Color.white,
            borderWidth: 1,
            borderColor: Color.gray4)
    }
    
    let studyLabel: UILabel = UILabel().then {
        $0.text = "자주 하는 스터디"
        $0.font = SeSACFont.title4.font
    }
    
    let studyTextField: SeSACTextField = SeSACTextField().then {
        $0.setPlaceholder(placeholder: "입력해주세요", color: Color.gray3)
        $0.font = SeSACFont.title4.font
        $0.addLeftPadding()
    }
    
    let phoneNumberSearchAllowLabel: UILabel = UILabel().then {
        $0.text = "내 번호 검색 허용"
        $0.font = SeSACFont.title4.font
    }
    
    let phoneNumberSearchAllowSwitch: UISwitch = UISwitch().then {
        $0.tintColor = Color.green
        $0.thumbTintColor = Color.white
    }
    
    let ageRangeLabel: UILabel = UILabel().then {
        $0.text = "상대방 연령대"
        $0.font = SeSACFont.title4.font
    }
    
    let ageSettingRangeLabel: UILabel = UILabel().then {
        $0.text = "18 - 35"
        $0.font = SeSACFont.title3.font
        $0.textColor = Color.green
    }
    
    let ageSlider: MultiSlider = MultiSlider().then {
        $0.tintColor = Color.green
        $0.thumbImage = Icon.filterControl
        $0.outerTrackColor = Color.gray2
        $0.thumbCount = 2
        $0.minimumValue = 18
        $0.maximumValue = 65
        $0.value = [18.0, 65.0]
        $0.showsThumbImageShadow = true
        $0.trackWidth = 4
        $0.keepsDistanceBetweenThumbs = true
        $0.distanceBetweenThumbs = 12
        $0.orientation = .horizontal
        $0.showsThumbImageShadow = true
        $0.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    override func configureUI() {
        [myGenderLabel, maleButton, femaleButton, studyLabel,
         studyTextField, phoneNumberSearchAllowLabel, phoneNumberSearchAllowSwitch,
         ageRangeLabel, ageSettingRangeLabel, ageSlider].forEach { self.contentView.addSubview($0) }
    }
    
    override func setConstraints() {
        myGenderLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(36)
            make.leading.equalToSuperview().offset(16)
        }
        femaleButton.snp.makeConstraints { make in
            make.centerY.equalTo(myGenderLabel.snp.centerY)
            make.trailing.equalToSuperview().offset(-16)
            make.width.equalTo(56)
            make.height.equalTo(48)
        }
        maleButton.snp.makeConstraints { make in
            make.centerY.equalTo(femaleButton.snp.centerY)
            make.trailing.equalTo(femaleButton.snp.leading).offset(-8)
            make.width.equalTo(56)
            make.height.equalTo(48)
        }
        studyLabel.snp.makeConstraints { make in
            make.top.equalTo(myGenderLabel.snp.bottom).offset(42)
            make.leading.equalTo(myGenderLabel.snp.leading)
        }
        studyTextField.snp.makeConstraints { make in
            make.centerY.equalTo(studyLabel.snp.centerY)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(48)
            make.width.equalTo(self.snp.width).multipliedBy(0.4)
        }
        phoneNumberSearchAllowLabel.snp.makeConstraints { make in
            make.top.equalTo(studyLabel.snp.bottom).offset(42)
            make.leading.equalTo(myGenderLabel.snp.leading)
        }
        phoneNumberSearchAllowSwitch.snp.makeConstraints { make in
            make.centerY.equalTo(phoneNumberSearchAllowLabel.snp.centerY)
            make.trailing.equalToSuperview().offset(-16)
            make.width.equalTo(56)
            make.height.equalTo(28)
        }
        ageRangeLabel.snp.makeConstraints { make in
            make.top.equalTo(phoneNumberSearchAllowLabel.snp.bottom).offset(42)
            make.leading.equalTo(myGenderLabel.snp.leading)
        }
        ageSettingRangeLabel.snp.makeConstraints { make in
            make.centerY.equalTo(ageRangeLabel.snp.centerY)
            make.trailing.equalToSuperview().offset(-16)
        }
        ageSlider.snp.makeConstraints { make in
            make.top.equalTo(ageRangeLabel.snp.bottom).offset(24)
            make.directionalHorizontalEdges.equalToSuperview().inset(28)
            make.height.equalTo(28)
            make.bottom.equalToSuperview().inset(18)
        }
    }
    
    @objc func sliderValueChanged(_ sender: MultiSlider) {
        ageSettingRangeLabel.text = "\(Int(sender.value[0])) - \(Int(sender.value[1]))"
    }
}
