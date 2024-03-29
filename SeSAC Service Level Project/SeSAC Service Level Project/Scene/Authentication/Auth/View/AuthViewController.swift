//
//  AuthViewController.swift
//  SeSAC Service Level Project
//
//  Created by 이명진 on 2022/11/07.
//

import UIKit
import RxSwift
import RxCocoa
import FirebaseAuth
import Toast

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
    
    // MARK: - OverrideMethod
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // MARK: - CustomMethod
    
    private func bind() {
        
        let input = AuthViewModel.Input(text: mainView.phoneNumberTextField.rx.text, tap: mainView.authNotificationButton.rx.tap)
        let output = viewModel.transform(input: input)
        
        viewModel.authValidation
            .withUnretained(self)
            .bind { (vc, value) in
                vc.mainView.phoneNumberTextField.text = value
            }
            .disposed(by: disposeBag)
        
        output.validation
            .withUnretained(self)
            .bind { (vc, value) in
                let textColor: UIColor = value ? Color.white : Color.gray3
                let bgColor: UIColor = value ? Color.green : Color.gray6
                vc.mainView.authNotificationButton.setupButton(
                    title: "인증 문자 받기",
                    titleColor: textColor,
                    font: SeSACFont.body3.font,
                    backgroundColor: bgColor,
                    borderWidth: 0,
                    borderColor: .clear)
            }
            .disposed(by: disposeBag)
        
        output.phoneNumberText
            .withUnretained(self)
            .bind { (vc, value) in
                vc.viewModel.addHyphen(text: value)
                vc.mainView.phoneNumberTextField.backWards(with: value, 13)
            }
            .disposed(by: disposeBag)
        
        output.tap
            .withUnretained(self)
            .bind { (vc, value) in
                value ? vc.authMessage(vc.viewModel.removeHyphen(text: vc.mainView.phoneNumberTextField.text ?? "")) : vc.view.makeToast("휴대폰 번호 형식이 올바르지 않습니다.", duration: 1, position: .center)
            }
            .disposed(by: disposeBag)
    }
    
}


// MARK: - Extension

extension AuthViewController {
    
    private func pushAuthDetailVC() {
        let vc = AuthDetailViewController()
        UserDefaults.standard.set("+82\(viewModel.removeHyphen(text: mainView.phoneNumberTextField.text!))", forKey: Matrix.phoneNumber)
        transition(vc, transitionStyle: .push)
    }
    
    private func authMessage(_ phoneNumber: String) {
        PhoneAuthProvider.provider()
            .verifyPhoneNumber("+82 \(phoneNumber)", uiDelegate: nil) { [weak self] (verificationID, error) in
                if let id = verificationID {
                    UserDefaults.standard.set("\(id)", forKey: Matrix.verificationID)
                }
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                self?.pushAuthDetailVC()
            }
    }
}
