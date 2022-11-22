//
//  ProfileNickNameTableViewCell.swift
//  SeSAC Service Level Project
//
//  Created by 이명진 on 2022/11/14.
//

import UIKit

final class ProfileNickNameTableViewCell: BaseTableViewCell {
    
    let profileImageView: UIImageView = UIImageView().then {
        $0.image = Icon.profileImg
        $0.makeRoundedCorners(8)
    }
    
    lazy var stackView: UIStackView = UIStackView(arrangedSubviews: [firstLineView,
                                                                     secondLineView,
                                                                     thirdLineView]).then {
        $0.spacing = 24
        $0.axis = .vertical
        $0.layer.borderWidth = 1
        $0.layer.borderColor = Color.gray2.cgColor
        $0.layer.cornerRadius = 8
        $0.clipsToBounds = true
    }
    
    let firstLineView: NicknameReusableView = NicknameReusableView()
    
    let secondLineView: SeSACTitleReusableView = SeSACTitleReusableView()
    
    let thirdLineView: SeSACReviewReusableView = SeSACReviewReusableView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    override func configureUI() {
        selectionStyle = .none
        [profileImageView, stackView].forEach { self.contentView.addSubview($0) }
        thirdLineView.sesacReviewLabel.text = "aasdfsf\nsfasfdasf\nasfasdfasdf\nsafsfdasfasdf\nasdfasfasdfsadf\nasdfasfasdf"
    }
    
    override func setConstraints() {
        profileImageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview().inset(16)
        }
        stackView.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom)
            make.directionalHorizontalEdges.equalToSuperview().inset(16)
            make.bottom.equalToSuperview()
        }
    }
}
