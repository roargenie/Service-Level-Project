//
//  SeSACReviewReusableView.swift
//  SeSAC Service Level Project
//
//  Created by 이명진 on 2022/11/15.
//

import UIKit

final class SeSACReviewReusableView: BaseView {
    
    let sesacReviewTitleLabel: UILabel = UILabel().then {
        $0.text = "새싹 리뷰"
        $0.textColor = Color.black
        $0.font = SeSACFont.title6.font
    }
    
    let sesacReviewLabel: UILabel = UILabel().then {
        $0.text = "첫 리뷰를 기다리는 중이에요!"
        $0.textColor = Color.gray6
        $0.font = SeSACFont.body3.font
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureUI() {
        [sesacReviewTitleLabel, sesacReviewLabel].forEach { self.addSubview($0) }
    }
    
    override func setConstraints() {
        sesacReviewTitleLabel.snp.makeConstraints { make in
            make.leading.top.equalToSuperview()
        }
        sesacReviewLabel.snp.makeConstraints { make in
            make.top.equalTo(sesacReviewTitleLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview()
            make.bottom.equalToSuperview().inset(16)
        }
    }
}
