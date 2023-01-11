//
//  RequestButton.swift
//  SeSAC Service Level Project
//
//  Created by 이명진 on 2022/12/03.
//

import UIKit

final class RequestButton: UIButton {
    
    enum RequestButtonType {
        case request
        case accept
        
        fileprivate var backgroundColor: UIColor {
            switch self {
            case .request:
                return Color.error
            case .accept:
                return Color.success
            }
        }
        
        fileprivate var title: String {
            switch self {
            case .request:
                return "요청하기"
            case .accept:
                return "수락하기"
            }
        }
    }
    
    var type: RequestButtonType = .request {
        didSet {
            configureUI(type: type)
        }
    }
    
    init() {
        super.init(frame: .zero)
//        configureUI(type: .accept)
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI(type: RequestButtonType) {
        setTitle(type.title, for: .normal)
        titleLabel?.font = SeSACFont.title3.font
        setTitleColor(.white, for: .normal)
//        setTitleColor(Color.gray4, for: .highlighted)
        backgroundColor = type.backgroundColor
        makeCornerStyle(width: 0, radius: 8)
    }
    
    private func configureLayout() {
        snp.makeConstraints { make in
            make.height.equalTo(40)
        }
    }
}
