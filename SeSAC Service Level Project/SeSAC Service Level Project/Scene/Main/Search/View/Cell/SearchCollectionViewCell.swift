//
//  SearchCollectionViewCell.swift
//  SeSAC Service Level Project
//
//  Created by 이명진 on 2022/11/23.
//

import UIKit

final class SearchCollectionViewCell: BaseCollectionViewCell {
    
    let button: TagButton = TagButton(.red)
    
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
    
    func setup(data: String) {
        button.setTitle("    \(data)    ", for: .normal)
    }
}
