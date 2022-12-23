//
//  ChatView.swift
//  SeSAC Service Level Project
//
//  Created by 이명진 on 2022/12/04.
//

import UIKit

final class ChatView: BaseView {
    
    let tapBackground = UITapGestureRecognizer()
    
    let tableView: UITableView = UITableView(frame: .zero, style: .plain).then {
        $0.register(MyChatTableViewCell.self, forCellReuseIdentifier: MyChatTableViewCell.reuseIdentifier)
        $0.register(YourChatTableViewCell.self, forCellReuseIdentifier: YourChatTableViewCell.reuseIdentifier)
        $0.allowsSelection = false
        $0.separatorStyle = .none
        $0.keyboardDismissMode = .onDrag
        $0.rowHeight = UITableView.automaticDimension
        $0.backgroundColor = Color.green
    }
    
    let chatMoreView: ChatMoreView = ChatMoreView()
    
    private lazy var disableTouchView: UIView = UIView().then {
        $0.backgroundColor = Color.black.withAlphaComponent(0.5)
        $0.isHidden = true
        $0.addGestureRecognizer(tapBackground)
    }
    
    let textView: UITextView = UITextView(frame: CGRect.zero).then {
        $0.textContainerInset = UIEdgeInsets(top: 14, left: 12, bottom: 14, right: 44)
        $0.font = SeSACFont.body3.font
        $0.text = "메세지를 입력해주세요"
        $0.textColor = Color.gray7
        $0.backgroundColor = Color.gray1
        $0.isScrollEnabled = false
        $0.makeCornerStyle(radius: 8)
    }
    
    let sendButton: UIButton = UIButton().then {
        $0.setImage(Icon.sendInactive, for: .normal)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureUI() {
        [tableView, chatMoreView, textView, disableTouchView, sendButton].forEach { self.addSubview($0) }
    }
    
    override func setConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(textView.snp.top)
        }
        chatMoreView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(-72)
            make.directionalHorizontalEdges.equalToSuperview()
        }
        textView.snp.makeConstraints { make in
            make.directionalHorizontalEdges.equalToSuperview().inset(16)
            make.bottom.equalTo(self.keyboardLayoutGuide.snp.top).offset(-16)
            make.height.equalTo(52)
        }
        disableTouchView.snp.makeConstraints { make in
            make.top.equalTo(chatMoreView.snp.bottom)
            make.directionalHorizontalEdges.bottom.equalToSuperview()
        }
        sendButton.snp.makeConstraints { make in
            make.centerY.equalTo(textView.snp.centerY)
            make.trailing.equalTo(textView.snp.trailing).offset(-14)
            make.width.height.equalTo(20)
        }
    }
    
    func setupChatMoreView(_ isSelected: Bool) {
        if isSelected == true {
            UIView.animate(withDuration: 0.2) {
                self.chatMoreView.transform = CGAffineTransform(translationX: 0, y: 72)
                self.disableTouchView.transform = CGAffineTransform(translationX: 0, y: 72)
                self.chatMoreView.alpha = 1
                self.disableTouchView.isHidden = false
            }
        } else {
            UIView.animate(withDuration: 0.2) {
                self.chatMoreView.transform = .identity
                self.disableTouchView.transform = .identity
                self.chatMoreView.alpha = 0
                self.disableTouchView.isHidden = true
            }
        }
    }
    
    func setupSendButton(text: String) {
        if text.isEmpty || textView.textColor == Color.gray7 {
            sendButton.setImage(Icon.sendInactive, for: .normal)
        } else {
            sendButton.setImage(Icon.send, for: .normal)
        }
    }
    
    func setupTextViewDidChange() {
        if textView.numberOfLine() > 3 {
            textView.snp.remakeConstraints { make in
                make.directionalHorizontalEdges.equalToSuperview().inset(16)
                make.bottom.equalTo(self.keyboardLayoutGuide.snp.top).offset(-16)
                make.height.equalTo(90)
            }
            textView.isScrollEnabled = true
        } else {
            textView.snp.remakeConstraints { make in
                make.directionalHorizontalEdges.equalToSuperview().inset(16)
                make.bottom.equalTo(self.keyboardLayoutGuide.snp.top).offset(-16)
                make.height.lessThanOrEqualTo(90)
                make.height.greaterThanOrEqualTo(52)
            }
            textView.isScrollEnabled = false
        }
    }
    
    func setupTextViewDidBeginEditing() {
        if textView.textColor == Color.gray7 {
            textView.text = nil
            textView.textColor = Color.black
        }
        textView.snp.remakeConstraints { make in
            make.directionalHorizontalEdges.equalToSuperview().inset(16)
            make.bottom.equalTo(self.keyboardLayoutGuide.snp.top).offset(-16)
            make.height.greaterThanOrEqualTo(52)
            make.height.lessThanOrEqualTo(90)
        }
    }
    
    func setupTextViewDidEndEditing() {
        if textView.text == "" {
            textView.text = "메세지를 입력해주세요"
            textView.textColor = Color.gray7
        }
        textView.snp.remakeConstraints { make in
            make.directionalHorizontalEdges.equalToSuperview().inset(16)
            make.bottom.equalTo(self.keyboardLayoutGuide.snp.top).offset(-16)
            make.height.equalTo(52)
        }
    }
}
