//
//  BaseView.swift
//  SeSAC Service Level Project
//
//  Created by 이명진 on 2022/11/07.
//

import UIKit


class BaseView: UIView {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        setConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() { }
    func setConstraints() { }
}
