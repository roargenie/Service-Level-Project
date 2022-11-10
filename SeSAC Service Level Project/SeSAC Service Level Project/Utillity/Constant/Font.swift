//
//  Font.swift
//  SeSAC Service Level Project
//
//  Created by 이명진 on 2022/11/07.
//

import UIKit


struct Font {
    let font: UIFont.SeSACFontType
    let size: CGFloat
    let lineHeight: CGFloat
}

@frozen enum SeSACFont {
    case onboard
    case display1
    case title1
    case title2
    case title3
    case title4
    case title5
    case title6
    case body1
    case body2
    case body3
    case body4
    case caption
    
    private var fontStyle: Font {
        switch self {
        case .onboard:
            return Font(font: .medium, size: 24, lineHeight: 38.4)
        case .display1:
            return Font(font: .regular, size: 20, lineHeight: 32)
        case .title1:
            return Font(font: .medium, size: 16, lineHeight: 25.6)
        case .title2:
            return Font(font: .regular, size: 16, lineHeight: 25.6)
        case .title3:
            return Font(font: .medium, size: 14, lineHeight: 22.4)
        case .title4:
            return Font(font: .regular, size: 14, lineHeight: 22.4)
        case .title5:
            return Font(font: .medium, size: 12, lineHeight: 18)
        case .title6:
            return Font(font: .regular, size: 12, lineHeight: 18)
        case .body1:
            return Font(font: .medium, size: 16, lineHeight: 29.6)
        case .body2:
            return Font(font: .regular, size: 16, lineHeight: 29.6)
        case .body3:
            return Font(font: .regular, size: 14, lineHeight: 23.8)
        case .body4:
            return Font(font: .regular, size: 12, lineHeight: 21.6)
        case .caption:
            return Font(font: .regular, size: 10, lineHeight: 16)
        }
    }
}

extension SeSACFont {
    var font: UIFont {
        guard let font = UIFont(name: fontStyle.font.name, size: fontStyle.size) else {
            return UIFont()
        }
        return font
    }
}
