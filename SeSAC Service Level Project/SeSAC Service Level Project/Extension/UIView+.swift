//
//  UIView+.swift
//  SeSAC Service Level Project
//
//  Created by 이명진 on 2022/12/01.
//

import UIKit

extension UIView {
    
    func makeCornerStyle(width: CGFloat = 0,
                         color: CGColor? = nil,
                         radius: CGFloat = 1) {
        layer.borderWidth = width
        layer.borderColor = color
        layer.cornerRadius = radius
    }
    
}
