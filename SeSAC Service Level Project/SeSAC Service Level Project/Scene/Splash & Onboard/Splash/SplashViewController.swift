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
        presentOnboardingVC()
    }
    
    private func presentOnboardingVC() {
        UIView.animate(withDuration: 2.0) {
            self.mainView.splashLogoImageView.alpha = 1
            self.mainView.splashTextImageView.alpha = 1
        } completion: { [weak self] _ in
            let vc = OnboardViewController()
            self?.transition(vc, transitionStyle: .presentFull)
        }
    }
    
}