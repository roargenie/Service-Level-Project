//
//  ChatView.swift
//  SeSAC Service Level Project
//
//  Created by 이명진 on 2022/12/04.
//

import UIKit

final class ChatView: BaseView {
    
    let tableView: UITableView = UITableView(frame: .zero, style: .plain).then {
        $0.register(ChatTableViewCell.self, forCellReuseIdentifier: ChatTableViewCell.reuseIdentifier)
        $0.separatorStyle = .none
        $0.keyboardDismissMode = .onDrag
        $0.backgroundColor = Color.green
    }
    
    let textView: UITextView = UITextView(frame: CGRect.zero).then {
        
//        $0.contentInset = UIEdgeInsets(top: 14, left: 12, bottom: 14, right: 44)
        $0.textContainerInset = UIEdgeInsets(top: 14, left: 12, bottom: 14, right: 44)
        $0.font = SeSACFont.body3.font
        $0.textColor = Color.black
        $0.backgroundColor = Color.gray1
        $0.isScrollEnabled = false
//        $0.sizeToFit()
        $0.makeCornerStyle(radius: 8)
        $0.text = "김루희 방구뿡뿡뿡"
    }
    
    let sendButton: UIButton = UIButton().then {
        $0.setImage(Icon.sendInactive, for: .normal)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureUI() {
        [tableView, textView, sendButton].forEach { self.addSubview($0) }
    }
    
    override func setConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(textView.snp.top)
        }
        textView.snp.makeConstraints { make in
            make.directionalHorizontalEdges.equalToSuperview().inset(16)
            make.bottom.equalTo(self.keyboardLayoutGuide.snp.top).offset(-16)
            make.height.equalTo(52)
        }
        sendButton.snp.makeConstraints { make in
            make.centerY.equalTo(textView.snp.centerY)
            make.trailing.equalTo(textView.snp.trailing).offset(-14)
            make.width.height.equalTo(20)
        }
    }
}
