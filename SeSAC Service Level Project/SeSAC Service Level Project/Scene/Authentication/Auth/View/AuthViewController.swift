//
//  AuthViewController.swift
//  SeSAC Service Level Project
//
//  Created by 이명진 on 2022/11/07.
//

import UIKit
import RxSwift
import RxCocoa


final class AuthViewController: BaseViewController {
    
    // MARK: - Properties
    
    private let mainView = AuthView()
    private let viewModel = AuthViewModel()
    
    private var disposeBag = DisposeBag()
    
    // MARK: - LifeCycle
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }

//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        self.navigationController?.isNavigationBarHidden = true
//    }
    
    // MARK: - OverrideMethod
    
//    override func setNavigation() {
//        self.navigationController?.isNavigationBarHidden = true
//    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // MARK: - CustomMethod
    
    private func bind() {
        
        let input = AuthViewModel.Input(text: mainView.phoneNumberTextField.rx.text, tap: mainView.authNotificationButton.rx.tap)
        let output = viewModel.transform(input: input)
        
        output.validation
            .withUnretained(self)
            .bind { (vc, value) in
                let textColor: UIColor = value ? Color.white : Color.gray3
                let bgColor: UIColor = value ? Color.green : Color.gray6
                vc.mainView.authNotificationButton.setupButton(title: "인증 문자 받기", titleColor: textColor, font: SeSACFont.body3.font, backgroundColor: bgColor, borderWidth: 0, borderColor: .clear)
            }
            .disposed(by: disposeBag)
        
        output.tap
            .withUnretained(self)
            .bind { (vc, _) in
                vc.pushAuthDetailVC()
            }
            .disposed(by: disposeBag)
    }
    
    private func pushAuthDetailVC() {
        let vc = AuthDetailViewController()
        transition(vc, transitionStyle: .push)
    }
    
}
