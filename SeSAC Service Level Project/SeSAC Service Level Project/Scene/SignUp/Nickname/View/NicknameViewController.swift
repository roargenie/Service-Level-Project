//
//  SignUpViewController.swift
//  SeSAC Service Level Project
//
//  Created by 이명진 on 2022/11/07.
//

import UIKit
import RxSwift
import RxCocoa


final class NicknameViewController: BaseViewController {
    
    // MARK: - Properties
    
    private let mainView = NicknameView()
    private let viewModel = NicknameViewModel()
    
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
        navigationController?.navigationBar.tintColor = Color.black
        let leftBarButtonItem = UIBarButtonItem(image: Icon.arrow, style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem = leftBarButtonItem
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // MARK: - CustomMethod
    
    private func bind() {
        
        let input = NicknameViewModel.Input(text: mainView.nickNameTextField.rx.text, tap: mainView.nextButton.rx.tap)
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
            .bind { (vc, _) in
                vc.pushAuthDetailVC()
            }
            .disposed(by: disposeBag)
        
        output.nicknameText
            .withUnretained(self)
            .bind { (vc, value) in
                vc.mainView.nickNameTextField.backWards(with: value, 10)
            }
            .disposed(by: disposeBag)
        
    }
    
    private func pushAuthDetailVC() {
        let vc = BirthViewController()
        UserDefaults.standard.set(mainView.nickNameTextField.text, forKey: Matrix.nickname)
        print(UserDefaults.standard.string(forKey: Matrix.nickname))
        transition(vc, transitionStyle: .push)
    }
    
    @objc private func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
}
