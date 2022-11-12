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

        output.validation
            .withUnretained(self)
            .bind { (vc, value) in
                let textColor: UIColor = value ? Color.white : Color.gray3
                let bgColor: UIColor = value ? Color.green : Color.gray6
                vc.mainView.startButton.setupButton(title: "인증하고 시작하기",
                                                    titleColor: textColor,
                                                    font: SeSACFont.body3.font,
                                                    backgroundColor: bgColor,
                                                    borderWidth: 0,
                                                    borderColor: .clear)
            }
            .disposed(by: disposeBag)
        
        mainView.authNumberTextField.rx.text
            .orEmpty
            .withUnretained(self)
            .bind { (vc, value) in
                vc.mainView.authNumberTextField.backWards(with: value, 6)
            }
            .disposed(by: disposeBag)
        
        output.tap
            .withUnretained(self)
            .bind { (vc, _) in
                vc.verification()
                vc.requestLogin()
            }
            .disposed(by: disposeBag)
        
    }
    
    private func requestLogin() {
        APIManager.shared.requestData(Login.self, router: SeSACRouter.login) { [weak self] result in
            switch result {
            case .success(let value):
                print(value)
            case .failure(let error):
                switch error {
                case .firebaseTokenErr:
                    print(error.rawValue)
                case .notSignUp:
                    print(error.rawValue)
                    self?.pushNicknameVC()
                case .serverError:
                    print(error.rawValue)
                case .clientError:
                    print(error.rawValue)
                }
                print(error.localizedDescription)
            }
        }
    }
    
    private func pushNicknameVC() {
        let vc = NicknameViewController()
        transition(vc, transitionStyle: .push)
    }
    
    @objc private func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
}

// MARK: - Extension

extension AuthDetailViewController {
    
    private func verification() {
        guard let verificationID = UserDefaults.standard.string(forKey: "verificationID"),
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
        Auth.auth().signIn(with: credential) { authResult, error in
            
            if let error = error {
                print(error.localizedDescription)
                print("LogIn Failed...")
            }
            
            authResult?.user.getIDToken(completion: { token, error in
                if let error = error {
                    print(error.localizedDescription)
                    print("LogIn Failed...")
                }
                UserDefaults.standard.set(token, forKey: Text.firebaseToken)
            })
            print("LogIn Success!!")
            print("\\(authResult!)")
        }
    }
    
}
