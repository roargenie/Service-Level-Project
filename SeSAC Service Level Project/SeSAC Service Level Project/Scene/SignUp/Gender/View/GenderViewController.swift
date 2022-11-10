//
//  GenderViewController.swift
//  SeSAC Service Level Project
//
//  Created by 이명진 on 2022/11/08.
//

import UIKit
import RxSwift
import RxCocoa


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
        viewModel.gender
            .bind(to: mainView.collectionView.rx.items(cellIdentifier: GenderCollectionViewCell.reuseIdentifier,
                                                       cellType: GenderCollectionViewCell.self)) { index, item, cell in
                cell.imageView.image = item.image
                cell.genderLabel.text = item.gender
            }
            .disposed(by: disposeBag)
        
        mainView.collectionView.rx.itemSelected
            .withUnretained(self)
            .bind { (vc, index) in
                guard let cell = vc.mainView.collectionView.cellForItem(at: index) as? GenderCollectionViewCell else { return }
                let textColor: UIColor = cell.isSelected ? Color.white : Color.gray3
                let bgColor: UIColor = cell.isSelected ? Color.green : Color.gray6
                vc.mainView.nextButton.setupButton(title: "다음",
                                                   titleColor: textColor,
                                                   font: SeSACFont.body3.font,
                                                   backgroundColor: bgColor,
                                                   borderWidth: 0,
                                                   borderColor: .clear)
                cell.isSelected.toggle()
            }
            .disposed(by: disposeBag)
        
    }
//    private func bind() {
//
//        let input = GenderViewModel.Input(celltap: mainView.collectionView.rx.itemSelected,
//                                          tap: mainView.nextButton.rx.tap)
//        let output = viewModel.transform(input: input)
//
//        output.celltap
//            .withUnretained(self)
//            .bind { (vc, value) in
//                let textColor: UIColor = value ? Color.white : Color.gray3
//                let bgColor: UIColor = value ? Color.green : Color.gray6
//                vc.mainView.nextButton.setupButton(title: "다음",
//                                                   titleColor: textColor,
//                                                   font: SeSACFont.body3.font,
//                                                   backgroundColor: bgColor,
//                                                   borderWidth: 0,
//                                                   borderColor: .clear)
//            }
//            .disposed(by: disposeBag)
//
//        output.tap
//            .withUnretained(self)
//            .bind { (vc, _) in
//                vc.pushAuthDetailVC()
//            }
//            .disposed(by: disposeBag)
//
//        mainView.collectionView.rx.itemSelected
//    }

    private func pushAuthDetailVC() {
        let vc = AuthDetailViewController()
        transition(vc, transitionStyle: .push)
    }

    @objc private func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
}
