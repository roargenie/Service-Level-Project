//
//  EmailViewController.swift
//  SeSAC Service Level Project
//
//  Created by 이명진 on 2022/11/08.
//

import UIKit
import RxSwift
import RxCocoa
import Toast

final class EmailViewController: BaseViewController {
    
    // MARK: - Properties
    
    private let mainView = EmailView()
    private let viewModel = EmailViewModel()
    
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
        let leftBarButtonItem = UIBarButtonItem(image: Icon.arrow, style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem = leftBarButtonItem
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // MARK: - CustomMethod
    
    private func bind() {

        let input = EmailViewModel.Input(text: mainView.emailTextField.rx.text, tap: mainView.nextButton.rx.tap)
        let output = viewModel.transform(input: input)

        output.validation
            .withUnretained(self)
            .bind { (vc, value) in
                let textColor: UIColor = value ? Color.white : Color.gray3
                let bgColor: UIColor = value ? Color.green : Color.gray6
                vc.mainView.nextButton.setupButton(
                    title: "다음",
                    titleColor: textColor,
                    font: SeSACFont.body3.font,
                    backgroundColor: bgColor,
                    borderWidth: 0,
                    borderColor: .clear)
            }
            .disposed(by: disposeBag)

        output.tap
            .withUnretained(self)
            .bind { (vc, value) in
                value ? vc.pushGenderVC() : vc.view.makeToast("올바르지 않은 이메일 형식입니다", duration: 1, position: .center)
            }
            .disposed(by: disposeBag)
    }

    private func pushGenderVC() {
        let vc = GenderViewController()
        UserDefaults.standard.set(mainView.emailTextField.text, forKey: Matrix.email)
        print(UserDefaults.standard.string(forKey: Matrix.email))
        transition(vc, transitionStyle: .push)
    }
    
    @objc private func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
}
