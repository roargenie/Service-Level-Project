//
//  BirthViewController.swift
//  SeSAC Service Level Project
//
//  Created by 이명진 on 2022/11/08.
//

import UIKit
import RxSwift
import RxCocoa


final class BirthViewController: BaseViewController {
    
    // MARK: - Properties
    
    private let mainView = BirthView()
    private let viewModel = BirthViewModel()
    
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
        
        let input = BirthViewModel.Input(
            date: mainView.datePicker.rx.date,
            tap: mainView.nextButton.rx.tap)
        let output = viewModel.transform(input: input)
        
        output.datePickerChange
            .withUnretained(self)
            .bind { (vc, value) in
                vc.mainView.yearTextField.text = value.dateFormat("yyyy")
                vc.mainView.monthTextField.text = value.dateFormat("MM")
                vc.mainView.dayTextField.text = value.dateFormat("dd")
                let titleColor: UIColor = value.ageValid() ? Color.white : Color.gray3
                let bgColor: UIColor = value.ageValid() ? Color.green : Color.gray6
                vc.mainView.nextButton.setupButton(
                    title: "다음",
                    titleColor: titleColor,
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
        
    }
    
    private func pushAuthDetailVC() {
        let vc = EmailViewController()
        UserDefaults.standard.set(mainView.datePicker.date.dateFormat("YYYY-MM-dd'T'HH:mm:ss.sssZ"), forKey: Matrix.birth)
        print(UserDefaults.standard.string(forKey: Matrix.birth))
        transition(vc, transitionStyle: .push)
    }
    
    @objc private func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
}
