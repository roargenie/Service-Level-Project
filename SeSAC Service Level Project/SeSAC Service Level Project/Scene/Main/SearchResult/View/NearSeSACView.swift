//
//  NearSeSACView.swift
//  SeSAC Service Level Project
//
//  Created by 이명진 on 2022/11/22.
//

import UIKit

final class NearSeSACView: BaseView {
    
    let tableView: UITableView = UITableView(frame: .zero, style: .plain).then {
        $0.separatorStyle = .none
        $0.register(ProfileNickNameTableViewCell.self, forCellReuseIdentifier: ProfileNickNameTableViewCell.reuseIdentifier)
    }
    
    let studyChangeButton: SeSACButton = SeSACButton().then {
        $0.setupButton(title: "스터디 변경하기",
                       titleColor: Color.white,
                       font: SeSACFont.body3.font,
                       backgroundColor: Color.green,
                       borderWidth: 0,
                       borderColor: .clear)
    }
    
    let refreshButton: SeSACButton = SeSACButton().then {
        $0.setImage(Icon.refresh, for: .normal)
        $0.layer.cornerRadius = 8
        $0.clipsToBounds = true
        $0.layer.borderColor = Color.green.cgColor
        $0.layer.borderWidth = 1
    }
    
    lazy var emptyView: UIView = UIView().then {
        $0.addSubview(emptyImageView)
        $0.addSubview(firstEmptyLabel)
        $0.addSubview(secondEmptyLabel)
    }
    
    let emptyImageView: UIImageView = UIImageView().then {
        $0.image = Icon.img
    }
    
    let firstEmptyLabel: UILabel = UILabel().then {
        $0.text = "아쉽게도 주변에 새싹이 없어요ㅠ"
        $0.font = SeSACFont.display1.font
        $0.textAlignment = .center
    }
    
    let secondEmptyLabel: UILabel = UILabel().then {
        $0.text = "스터디를 변경하거나 조금만 더 기다려 주세요!"
        $0.textColor = Color.gray7
        $0.font = SeSACFont.title4.font
        $0.textAlignment = .center
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureUI() {
        [tableView, studyChangeButton, refreshButton, emptyView]
            .forEach { self.addSubview($0) }
    }
    
    override func setConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        studyChangeButton.snp.makeConstraints { make in
            make.height.equalTo(48)
            make.bottom.equalTo(self.safeAreaLayoutGuide).offset(-16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalTo(refreshButton.snp.leading).offset(-8)
        }
        refreshButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalTo(studyChangeButton.snp.centerY)
            make.width.height.equalTo(48)
        }
        emptyView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().multipliedBy(0.8)
            make.width.equalTo(self.snp.width).multipliedBy(0.8)
            make.height.equalTo(self.snp.height).multipliedBy(0.4)
        }
        emptyImageView.snp.makeConstraints { make in
            make.top.equalTo(emptyView.snp.top).offset(40)
            make.centerX.equalTo(emptyView.snp.centerX)
        }
        firstEmptyLabel.snp.makeConstraints { make in
            make.top.equalTo(emptyImageView.snp.bottom).offset(44)
            make.centerX.equalTo(emptyImageView.snp.centerX)
        }
        secondEmptyLabel.snp.makeConstraints { make in
            make.top.equalTo(firstEmptyLabel.snp.bottom).offset(8)
            make.centerX.equalTo(emptyImageView.snp.centerX)
        }
    }
}
