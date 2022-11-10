//
//  GenderCollectionViewCell.swift
//  SeSAC Service Level Project
//
//  Created by 이명진 on 2022/11/09.
//

import UIKit
import Then

final class GenderCollectionViewCell: BaseCollectionViewCell {
    
    override var isSelected: Bool {
        didSet {
            backgroundColor = isSelected ? Color.whitegreen : Color.white
            layer.borderWidth = isSelected ? 0 : 1
        }
    }
    
    let imageView: UIImageView = UIImageView()
    
    let genderLabel: UILabel = UILabel().then {
        $0.font = SeSACFont.title2.font
        $0.textColor = Color.black
        $0.textAlignment = .center
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 8
        clipsToBounds = true
        layer.borderColor = Color.gray3.cgColor
        layer.borderWidth = 1
        backgroundColor = Color.white
    }
    
    override func configureUI() {
        [imageView, genderLabel].forEach { self.addSubview($0) }
    }
    
    override func setConstraints() {
        imageView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(14)
            make.width.height.equalTo(64)
            make.centerX.equalTo(self.snp.centerX)
        }
        genderLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(2)
            make.centerX.equalTo(imageView.snp.centerX)
        }
    }
    
}
