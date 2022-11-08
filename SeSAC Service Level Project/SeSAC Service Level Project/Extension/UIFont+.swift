//
//  UIFont+.swift
//  SeSAC Service Level Project
//
//  Created by 이명진 on 2022/11/08.
//

import UIKit

extension UIFont {
    @frozen enum SeSACFontType: String {
        case medium = "NotoSansKR-Medium"
        case regular = "NotoSansKR-Regular"
        
        var name: String {
            return self.rawValue
        }
    }
}
