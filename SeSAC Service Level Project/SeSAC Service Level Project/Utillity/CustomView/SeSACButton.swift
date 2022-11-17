//
//  CustomButton.swift
//  SeSAC Service Level Project
//
//  Created by 이명진 on 2022/11/08.
//

import UIKit


final class SeSACButton: UIButton {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupButton(title: String,
                     titleColor: UIColor,
                     font: UIFont,
                     backgroundColor: UIColor,
                     borderWidth: CGFloat,
                     borderColor: UIColor,
                     cornerRadius: CGFloat = 8) {
        layer.cornerRadius = cornerRadius
        clipsToBounds = true
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor.cgColor
        let attributedText = NSAttributedString(string: title, attributes: [NSAttributedString.Key.font: font,
                                                                            NSAttributedString.Key.foregroundColor: titleColor
                                                                           ])
        setAttributedTitle(attributedText, for: .normal)
        self.backgroundColor = backgroundColor
    }
    
    func setupButton(title: String,
                     titleColor: UIColor,
                     font: UIFont,
                     backgroundColor: UIColor) {
        let attributedText = NSAttributedString(string: title, attributes: [NSAttributedString.Key.font: font,
                                                                            NSAttributedString.Key.foregroundColor: titleColor
                                                                           ])
        setAttributedTitle(attributedText, for: .normal)
        self.backgroundColor = backgroundColor
    }
}
