//
//  ChatViewController.swift
//  SeSAC Service Level Project
//
//  Created by 이명진 on 2022/12/04.
//

import UIKit
import RxCocoa
import RxSwift

final class ChatViewController: BaseViewController {
    
    //MARK: - Properties
    
    private var mainView = ChatView()
    private let viewModel = ChatViewModel()
    
    private var disposeBag = DisposeBag()
    
    //MARK: - LifeCycle

    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    //MARK: - OverrideMethod
    
    override func configureUI() {
        
    }
    
    override func setConstraints() {
       
    }
    
    override func setNavigation() {
        title = "누구야"
        let leftBarButtonItem = UIBarButtonItem(image: Icon.arrow, style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem = leftBarButtonItem
        let rightBarButtonItem = UIBarButtonItem(image: Icon.more, style: .plain, target: self, action: #selector(moreButtonTapped))
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    //MARK: - CustomMethod
    
    private func bind() {
        
        mainView.textView.rx.didChange
            .withUnretained(self)
            .bind { vc, _ in
                vc.mainView.setupTextViewDidChange()
            }
            .disposed(by: disposeBag)
        
        mainView.textView.rx.didBeginEditing
            .withUnretained(self)
            .bind { vc, _ in
                vc.mainView.setupTextViewDidBeginEditing()
            }
            .disposed(by: disposeBag)
        
        mainView.textView.rx.didEndEditing
            .withUnretained(self)
            .bind { vc, _ in
                vc.mainView.setupTextViewDidEndEditing()
            }
            .disposed(by: disposeBag)
        
        mainView.textView.rx.text
            .orEmpty
            .withUnretained(self)
            .bind { vc, value in
                vc.mainView.setupSendButton(text: value)
            }
            .disposed(by: disposeBag)
        
        mainView.tapBackground.rx.event
            .withUnretained(self)
            .bind { vc, _ in
                vc.mainView.setupChatMoreView(false)
                vc.navigationItem.rightBarButtonItem?.isSelected.toggle()
            }
            .disposed(by: disposeBag)
    }

    @objc private func backButtonTapped() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc private func moreButtonTapped(_ sender: UIButton) {
        sender.isSelected.toggle()
        mainView.setupChatMoreView(sender.isSelected)
    }
}
