//
//  SplashViewController.swift
//  SeSAC Service Level Project
//
//  Created by 이명진 on 2022/11/07.
//

import UIKit


final class SplashViewController: BaseViewController {
    
    private let mainView = SplashView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        print(UserDefaults.standard.string(forKey: Matrix.IdToken))
        presentOnboardingVC()
    }
    
    private func presentOnboardingVC() {
        UIView.animate(withDuration: 2.0) {
            self.mainView.splashLogoImageView.alpha = 1
            self.mainView.splashTextImageView.alpha = 1
        } completion: { [weak self] _ in
            guard let self = self else { return }
            if UserDefaults.standard.bool(forKey: "firstRun") == false {
                let vc = OnboardViewController()
                self.transition(vc, transitionStyle: .presentFull)
            } else {
                if UserDefaults.standard.string(forKey: Matrix.IdToken) != nil {
                    self.requestLogin()
                } else {
                    self.presentAuthVC()
                }
            }
        }
    }
    
    private func requestLogin() {
        APIManager.shared.requestData(Login.self, router: SeSACRouter.login) { [weak self] response, status in
            
            switch response {
            case .success(let value):
                print(value)
                UserDefaults.standard.set(value?.uid, forKey: Matrix.myUID)
                self?.pushHomeVC()
            case .failure(let error):
                switch error {
                case .firebaseTokenErr:
                    print(error.rawValue)
                case .notSignUp:
                    print(error.rawValue)
                    self?.presentNicknameVC()
                case .serverError:
                    print(error.rawValue)
                case .clientError:
                    print(error.rawValue)
                    self?.presentAuthVC()
                }
                print(error.localizedDescription)
            }
        }
    }
    
    private func pushHomeVC() {
        let vc = TabbarViewController()
        transition(vc, transitionStyle: .changeRootVC)
    }
    
    private func presentAuthVC() {
        let vc = UINavigationController(rootViewController: AuthViewController())
        transition(vc, transitionStyle: .presentFull)
    }
    
    private func presentNicknameVC() {
        let vc = UINavigationController(rootViewController: NicknameViewController())
        transition(vc, transitionStyle: .presentFull)
    }
    
}
