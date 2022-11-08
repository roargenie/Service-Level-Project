//
//  SeSACTextFIeld.swift
//  SeSAC Service Level Project
//
//  Created by 이명진 on 2022/11/08.
//

import UIKit

final class SeSACTextField: UITextField {
    
    lazy var placeholderColor: UIColor = Color.gray3
    lazy var placeholderString: String = ""
    
    private lazy var underLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        addSubview(underLineView)
        self.addTarget(self, action: #selector(editingDidBegin), for: .editingDidBegin)
        self.addTarget(self, action: #selector(editingDidEnd), for: .editingDidEnd)
    }
    
    func setConstraints() {
        underLineView.snp.makeConstraints { make in
            make.top.equalTo(self.snp.bottom)
            make.directionalHorizontalEdges.equalToSuperview()
            make.height.equalTo(1)
        }
    }
    
    func setPlaceholder(placeholder: String, color: UIColor) {
        placeholderString = placeholder
        placeholderColor = color
        setPlaceholder()
        underLineView.backgroundColor = Color.gray3
    }
    
    func setPlaceholder() {
        self.attributedPlaceholder = NSAttributedString(string: placeholderString,
                                                        attributes: [NSAttributedString.Key.foregroundColor: Color.gray7])
    }
}

extension SeSACTextField {
    @objc private func editingDidBegin() {
        setPlaceholder()
        underLineView.backgroundColor = Color.focus
    }
    
    @objc private func editingDidEnd() {
        underLineView.backgroundColor = Color.gray3
    }
    
    func addLeftPadding() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = ViewMode.always
    }
}
