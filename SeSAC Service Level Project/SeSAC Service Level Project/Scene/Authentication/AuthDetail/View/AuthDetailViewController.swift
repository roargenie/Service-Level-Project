//
//  AuthDetailViewController.swift
//  SeSAC Service Level Project
//
//  Created by 이명진 on 2022/11/08.
//

import UIKit
import RxCocoa
import RxSwift
import FirebaseAuth
import Alamofire
import Toast

final class AuthDetailViewController: BaseViewController {
    
    // MARK: - Properties
    
    private let mainView = AuthDetailView()
    private let viewModel = AuthDetailViewModel()
    
    private var disposeBag = DisposeBag()
    
    // MARK: - LifeCycle
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    // MARK: - OverrideMethod
    
    override func setNavigation() {
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.tintColor = Color.black
        let leftBarButtonItem = UIBarButtonItem(image: Icon.arrow, style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem = leftBarButtonItem
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // MARK: - CustomMethod
    
    private func bind() {
        
        let input = AuthDetailViewModel.Input(text: mainView.authNumberTextField.rx.text, tap: mainView.startButton.rx.tap)
        let output = viewModel.transform(input: input)
        
        viewModel.statusRelay
            .asSignal()
            .withUnretained(self)
            .emit { (vc, value) in
                if value == 200 {
                    vc.transition(TabbarViewController(), transitionStyle: .changeRootVC)
                } else if value == 406 {
                    vc.transition(NicknameViewController(), transitionStyle: .push)
                }
            }
            .disposed(by: disposeBag)
        
        output.validation
            .withUnretained(self)
            .bind { (vc, value) in
                let textColor: UIColor = value ? Color.white : Color.gray3
                let bgColor: UIColor = value ? Color.green : Color.gray6
                vc.mainView.startButton.setupButton(
                    title: "인증하고 시작하기",
                    titleColor: textColor,
                    font: SeSACFont.body3.font,
                    backgroundColor: bgColor,
                    borderWidth: 0,
                    borderColor: .clear)
            }
            .disposed(by: disposeBag)
        
        output.messageText
            .withUnretained(self)
            .bind { (vc, value) in
                vc.mainView.authNumberTextField.backWards(with: value, 6)
            }
            .disposed(by: disposeBag)
        
        output.tap
            .withUnretained(self)
            .bind { (vc, value) in
                value ? vc.verification() : vc.view.makeToast("인증번호가 올바르지 않습니다", duration: 1, position: .center)
            }
            .disposed(by: disposeBag)
    }
    
    @objc private func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
}

// MARK: - Extension

extension AuthDetailViewController {
    
    private func verification() {
        guard let verificationID = UserDefaults.standard.string(forKey: Matrix.verificationID),
              let verificationCode = mainView.authNumberTextField.text else {
            return
        }
        let credential = PhoneAuthProvider.provider().credential(
            withVerificationID: verificationID,
            verificationCode: verificationCode
        )
        logIn(credential: credential)
    }
    
    private func logIn(credential: PhoneAuthCredential) {
        Auth.auth().signIn(with: credential) { [weak self] authResult, error in
            
            if let error = error {
                print(error.localizedDescription)
                print("LogIn Failed...")
            }
            
            authResult?.user.getIDToken(completion: { idToken, error in
                if let error = error {
                    print(error.localizedDescription)
                    print("LogIn Failed...")
                }
                UserDefaults.standard.set(idToken, forKey: Matrix.IdToken)
            })
            
            print("LogIn Success!!")
            print("\\(authResult!)")
            self?.viewModel.requestLogin()
        }
    }
    
}
