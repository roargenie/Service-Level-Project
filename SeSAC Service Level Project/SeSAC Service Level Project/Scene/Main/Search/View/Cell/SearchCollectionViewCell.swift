//
//  SearchCollectionViewCell.swift
//  SeSAC Service Level Project
//
//  Created by 이명진 on 2022/11/23.
//

import UIKit

final class SearchCollectionViewCell: BaseCollectionViewCell {
    
    let searchLabel: UILabel = UILabel().then {
        $0.font = SeSACFont.title4.font
    }
    
    let button: SeSACButton = SeSACButton().then {
        var config = SeSACButton.Configuration.plain()
        config.contentInsets = NSDirectionalEdgeInsets.init(top: 10, leading: 10, bottom: 10, trailing: 10)
        $0.configuration = config
        $0.layer.cornerRadius = 8
        $0.clipsToBounds = true
        $0.layer.borderColor = Color.error.cgColor
        $0.layer.borderWidth = 1
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureUI() {
        self.addSubview(button)
    }
    
    override func setConstraints() {
        button.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
