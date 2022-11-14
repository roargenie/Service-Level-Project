//
//  ProfileNickNameTableViewCell.swift
//  SeSAC Service Level Project
//
//  Created by 이명진 on 2022/11/14.
//

import UIKit

final class ProfileNickNameTableViewCell: BaseTableViewCell {
    
//    let profileCardView: ProfileCardView = ProfileCardView()
    let moreButton: UIButton = UIButton().then {
        $0.setImage(Icon.downarrow, for: .normal)
        $0.backgroundColor = Color.whitegreen
    }
    
    let uiview: UIView = UIView()
    
    let firstLineView: NicknameReusableView = NicknameReusableView()
    
    let secondLineView: SeSACTitleReusableView = SeSACTitleReusableView()
    
    let thirdLineView: SeSACReviewReusableView = SeSACReviewReusableView()
    
    lazy var stackView: UIStackView = UIStackView(arrangedSubviews: [firstLineView, secondLineView, thirdLineView, uiview]).then {
        $0.spacing = 24
        $0.axis = .vertical
        $0.layer.borderWidth = 1
        $0.layer.borderColor = Color.gray2.cgColor
        $0.layer.cornerRadius = 8
        $0.clipsToBounds = true
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    override func configureUI() {
        selectionStyle = .none
        [stackView, moreButton].forEach { self.contentView.addSubview($0) }
    }
    
    override func setConstraints() {
        stackView.snp.makeConstraints { make in
            make.directionalHorizontalEdges.equalToSuperview().inset(16)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        firstLineView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(24)
            make.leading.equalToSuperview().inset(16)
            make.trailing.equalTo(moreButton.snp.leading).offset(-16)
        }
        secondLineView.snp.makeConstraints { make in
            make.directionalHorizontalEdges.equalToSuperview().inset(16)
        }
        thirdLineView.snp.makeConstraints { make in
            make.directionalHorizontalEdges.equalToSuperview().inset(16)
//            make.bottom.equalToSuperview().offset(-16)
        }
        moreButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.trailing.equalToSuperview().inset(32)
            make.width.equalTo(22)
        }
    }
}
