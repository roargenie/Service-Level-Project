//
//  EnterHobbyCollectionViewSectionHeader.swift
//  SeSAC Service Level Project
//
//  Created by 이명진 on 2022/11/23.
//

import UIKit

final class SearchCollectionViewSectionHeader: UICollectionReusableView {
    
    static let identifier = "SearchCollectionViewSectionHeader"
    
    let headerLabel: UILabel = UILabel().then {
        $0.font = SeSACFont.title6.font
        $0.textColor = Color.black
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        self.addSubview(headerLabel)
    }
    
    private func setConstraints() {
        headerLabel.snp.makeConstraints { make in
            make.leading.top.bottom.equalToSuperview()
        }
    }
    
}
