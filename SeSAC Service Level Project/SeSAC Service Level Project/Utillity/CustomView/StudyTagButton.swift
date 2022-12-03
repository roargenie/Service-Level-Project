//
//  StudyTagButton.swift
//  SeSAC Service Level Project
//
//  Created by 이명진 on 2022/12/01.
//

import UIKit


final class StudyTagButton: UIButton {
    
    enum TagButtonType {
        case red
        case gray
        case green
        
        fileprivate var borderColor: UIColor {
            switch self {
            case .red:
                return Color.error
            case .gray:
                return Color.gray4
            case .green:
                return Color.green
            }
        }
        
        fileprivate var textColor: UIColor {
            switch self {
            case .red:
                return Color.error
            case .gray:
                return Color.black
            case .green:
                return Color.green
            }
        }
    }
    
    var type: TagButtonType = .red {
        didSet {
            configureUI(type: type)
            configureLayout(type: type)
        }
    }
    
    var title: String? {
        didSet {
//            setTitle(title, for: .normal)
            let attributedText = NSAttributedString(string: title ?? "",
                                                    attributes: [NSAttributedString.Key.font: SeSACFont.title4.font,
                                                                 NSAttributedString.Key.foregroundColor: type.textColor
                                                                ])
            setAttributedTitle(attributedText, for: .normal)
        }
    }
        
    init(_ type: TagButtonType) {
        super.init(frame: .zero)
        configureUI(type: type)
        configureLayout(type: type)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI(type: TagButtonType) {
//        titleLabel?.font = SeSACFont.title4.font
//        setTitleColor(type.textColor, for: .normal)
//        setTitleColor(Color.gray4, for: .highlighted)
        backgroundColor = .white
        
        makeCornerStyle(width: 1, color: type.borderColor.cgColor, radius: 8)
    }
    
    private func configureLayout(type: TagButtonType = .green) {
//        snp.makeConstraints { make in
//            make.height.equalTo(32)
//        }
        
        var configuration = PlainButton.Configuration.plain()
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 16, bottom: 5, trailing: 16)
        self.configuration = configuration
        
        if type == .green {
            var configuration = PlainButton.Configuration.plain()
            configuration.image = Icon.xmark
            configuration.imagePlacement = .trailing
            configuration.imagePadding = 4
            configuration.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 16, bottom: 5, trailing: 16)
            self.configuration = configuration
        }
    }
}
