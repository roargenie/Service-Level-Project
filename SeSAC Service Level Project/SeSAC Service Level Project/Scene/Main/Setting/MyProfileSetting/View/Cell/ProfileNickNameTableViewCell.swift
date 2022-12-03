//
//  ProfileNickNameTableViewCell.swift
//  SeSAC Service Level Project
//
//  Created by 이명진 on 2022/11/14.
//

import UIKit
import RxSwift

final class ProfileNickNameTableViewCell: BaseTableViewCell {
    
    var disposeBag = DisposeBag()
    
    let profileBackGroundImageView: UIImageView = UIImageView().then {
        $0.image = Icon.profileImg
        $0.makeRoundedCorners(8)
    }
    
    let profileImageView: UIImageView = UIImageView()
    
    let requestButton: RequestButton = RequestButton()
    
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    override func configureUI() {
        selectionStyle = .none
        [profileBackGroundImageView, profileImageView, requestButton,  stackView].forEach { self.contentView.addSubview($0) }
    }
    
    override func setConstraints() {
        profileBackGroundImageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview().inset(16)
        }
        profileImageView.snp.makeConstraints { make in
            make.bottom.equalTo(profileBackGroundImageView.snp.bottom)
            make.centerX.equalTo(profileBackGroundImageView.snp.centerX)
        }
        requestButton.snp.makeConstraints { make in
            make.top.equalTo(profileBackGroundImageView.snp.top).offset(12)
            make.trailing.equalTo(profileBackGroundImageView.snp.trailing).offset(-12)
            make.width.equalTo(80)
        }
        stackView.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom)
            make.directionalHorizontalEdges.equalToSuperview().inset(16)
            make.bottom.equalToSuperview()
        }
    }
    
    func setupCellData(data: FromQueueDB, buttonType: RequestButton.RequestButtonType) {
        requestButton.type = buttonType
        firstLineView.nicknameLabel.text = data.nick
        profileImageView.image = UIImage(named: "sesac_face_\(data.sesac)")
        thirdLineView.sesacReviewLabel.text = data.reviews.isEmpty ? "첫 리뷰를 기다리는 중이에요!" : data.reviews.joined()
    }
    
    func setupExpendedCell(hidden: Bool, image: UIImage?) {
        secondLineView.isHidden = hidden
        thirdLineView.isHidden = hidden
        firstLineView.moreButton.setImage(image, for: .normal)
    }
}
