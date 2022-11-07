//
//  UILabel+.swift
//  SeSAC Service Level Project
//
//  Created by 이명진 on 2022/11/08.
//

import UIKit

extension UILabel {
    func changeColor(targetString: String) {
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: Color.green
        ]
//        let fontSize = self.font.pointSize
//        let font = UIFont.boldSystemFont(ofSize: fontSize)
        let fullText = self.text ?? ""
        let range = (fullText as NSString).range(of: targetString)
        let attributedString = NSMutableAttributedString(string: fullText)
        attributedString.addAttributes(attributes, range: range)
        self.attributedText = attributedString
    }
}
