//
//  NicknameStackView.swift
//  SeSAC Service Level Project
//
//  Created by 이명진 on 2022/11/15.
//

import UIKit

final class ProfileCardView: UIStackView {
    
    let firstLineView: NicknameReusableView = NicknameReusableView()
    
    let secondLineView: SeSACTitleReusableView = SeSACTitleReusableView()
    
    let thirdLineView: SeSACReviewReusableView = SeSACReviewReusableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        spacing = 24
        axis = .vertical
        configureUI()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        [firstLineView, secondLineView, thirdLineView].forEach { self.addSubview($0) }
    }
    
    func setConstraints() {
        firstLineView.snp.makeConstraints { make in
            make.leading.top.trailing.equalToSuperview().inset(16)
        }
        secondLineView.snp.makeConstraints { make in
            make.directionalHorizontalEdges.equalToSuperview().inset(16)
        }
        thirdLineView.snp.makeConstraints { make in
            make.directionalHorizontalEdges.equalToSuperview().inset(16)
        }
    }
    
}
