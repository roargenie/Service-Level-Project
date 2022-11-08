//
//  AuthDetailViewController.swift
//  SeSAC Service Level Project
//
//  Created by 이명진 on 2022/11/08.
//

import UIKit
import RxCocoa
import RxSwift


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
                vc.mainView.startButton.setupButton(title: "인증하고 시작하기", titleColor: textColor, font: SeSACFont.body3.font, backgroundColor: bgColor, borderWidth: 0, borderColor: .clear)
            }
            .disposed(by: disposeBag)

        output.tap
            .bind { _ in
                print("클릭됨")
            }
            .disposed(by: disposeBag)
    }
    
    @objc private func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
}
