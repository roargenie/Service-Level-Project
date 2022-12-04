//
//  ChatViewController.swift
//  SeSAC Service Level Project
//
//  Created by 이명진 on 2022/12/04.
//

import UIKit

final class ChatViewController: BaseViewController {
    
    //MARK: - Properties
    
    private var mainView = ChatView()
    private let viewModel = ChatViewModel()
    
    //MARK: - LifeCycle

    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    //MARK: - OverrideMethod
    
    override func configureUI() {
        mainView.textView.delegate = self
    }
    
    override func setConstraints() {
       
    }
    
    override func setNavigation() {
        title = "누구냐"
        let leftBarButtonItem = UIBarButtonItem(image: Icon.arrow, style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem = leftBarButtonItem
        let rightBarButtonItem = UIBarButtonItem(image: Icon.more, style: .plain, target: self, action: #selector(moreButtonTapped))
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    //MARK: - CustomMethod
    
    private func bind() {
        
        
    }

    @objc private func backButtonTapped() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc private func moreButtonTapped() {
        
    }
}

extension ChatViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        if textView.numberOfLine() > 3 {
            mainView.textView.snp.remakeConstraints { make in
                make.directionalHorizontalEdges.equalToSuperview().inset(16)
                make.bottom.equalTo(self.view.keyboardLayoutGuide.snp.top).offset(-16)
                make.height.equalTo(90)
            }
            textView.isScrollEnabled = true
        } else {
            mainView.textView.snp.remakeConstraints { make in
                make.directionalHorizontalEdges.equalToSuperview().inset(16)
                make.bottom.equalTo(self.view.keyboardLayoutGuide.snp.top).offset(-16)
                make.height.lessThanOrEqualTo(90)
                make.height.greaterThanOrEqualTo(52)
            }
            textView.isScrollEnabled = false
        }
    }
}
