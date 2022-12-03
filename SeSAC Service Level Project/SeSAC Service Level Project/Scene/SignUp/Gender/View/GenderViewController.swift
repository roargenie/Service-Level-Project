//
//  GenderViewController.swift
//  SeSAC Service Level Project
//
//  Created by 이명진 on 2022/11/08.
//

import UIKit
import RxSwift
import RxCocoa
import FirebaseAuth
import Toast

final class GenderViewController: BaseViewController {
    
    // MARK: - Properties
    
    private let mainView = GenderView()
    private let viewModel = GenderViewModel()
    
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
        
        let input = GenderViewModel.Input(celltap: mainView.collectionView.rx.itemSelected, tap: mainView.nextButton.rx.tap)
        let output = viewModel.transform(input: input)
        
        viewModel.statusRelay
            .asSignal()
            .withUnretained(self)
            .emit { (vc, value) in
                if value == 200 {
                    vc.transition(TabbarViewController(), transitionStyle: .changeRootVC)
                }
            }
            .disposed(by: disposeBag)
        
        output.gender
            .bind(to: mainView.collectionView.rx.items(
                cellIdentifier: GenderCollectionViewCell.reuseIdentifier,
                cellType: GenderCollectionViewCell.self)) { index, item, cell in
                    cell.imageView.image = item.image
                    cell.genderLabel.text = item.gender
                }
                .disposed(by: disposeBag)
        
        output.celltap
            .withUnretained(self)
            .bind { (vc, index) in
                guard let cell = vc.mainView.collectionView.cellForItem(at: index) as? GenderCollectionViewCell else { return }
                let textColor: UIColor = cell.isSelected ? Color.white : Color.gray3
                let bgColor: UIColor = cell.isSelected ? Color.green : Color.gray6
//                vc.mainView.nextButton.isEnabled = cell.isSelected ? true : false
                vc.mainView.nextButton.setupButton(
                    title: "다음",
                    titleColor: textColor,
                    font: SeSACFont.body3.font,
                    backgroundColor: bgColor,
                    borderWidth: 0,
                    borderColor: .clear)
                cell.isSelected.toggle()
            }
            .disposed(by: disposeBag)
        
        output.tap
            .withUnretained(self)
            .bind { (vc, value) in
                if value.item == 0 {
                    print("남자")
                    UserDefaults.standard.set(1, forKey: Matrix.gender)
                    print(UserDefaults.standard.integer(forKey: Matrix.gender))
                } else {
                    print("여자")
                    UserDefaults.standard.set(0, forKey: Matrix.gender)
                    print(UserDefaults.standard.integer(forKey: Matrix.gender))
                }
                vc.viewModel.requestSignUp()
            }
            .disposed(by: disposeBag)
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}
