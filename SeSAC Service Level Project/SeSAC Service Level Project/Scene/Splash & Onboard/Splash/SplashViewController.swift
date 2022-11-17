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
        presentOnboardingVC()
    }
    
    private func presentOnboardingVC() {
        UIView.animate(withDuration: 2.0) {
            self.mainView.splashLogoImageView.alpha = 1
            self.mainView.splashTextImageView.alpha = 1
        } completion: { [weak self] _ in
            if UserDefaults.standard.bool(forKey: "firstRun") == false {
                let vc = OnboardViewController()
                self?.transition(vc, transitionStyle: .presentFull)
            } else {
//                let vc = UINavigationController(rootViewController: AuthViewController())
//                self?.transition(vc, transitionStyle: .presentFull)
                self?.requestLogin()
            }
            
        }
    }
    
    private func requestLogin() {
        APIManager.shared.requestData(Login.self, router: SeSACRouter.login) { [weak self] response, status in
            
            switch response {
            case .success(let value):
                print(value)
                self?.pushHomeVC()
            case .failure(let error):
                switch error {
                case .firebaseTokenErr:
                    self?.refreshIdToken()
                    self?.pushHomeVC()
                    print(error.rawValue)
                case .notSignUp:
                    print(error.rawValue)
                    self?.presentAuthVC()
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
    
}
