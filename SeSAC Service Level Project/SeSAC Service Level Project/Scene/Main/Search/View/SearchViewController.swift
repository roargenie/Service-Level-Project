//
//  SearchViewController.swift
//  SeSAC Service Level Project
//
//  Created by 이명진 on 2022/11/14.
//

import UIKit
import RxSwift
import RxCocoa
import FirebaseAuth
import RxDataSources
import Differentiator
import Toast

final class SearchViewController: BaseViewController {
    
    // MARK: - Properties
    
    private let mainView = SearchView()
    private let viewModel = SearchViewModel()
    
    private var disposeBag = DisposeBag()
    
    private var myStudy: [String] = []
    
    private var rxDataSource: RxCollectionViewSectionedAnimatedDataSource<SearchSection>!
    
    // MARK: - LifeCycle
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = true
        navigationController?.navigationBar.isHidden = false
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: mainView.searchBar)
        configureDatsSource()
        bind()
        viewModel.requestStudy()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        navigationController?.navigationBar.isHidden = false
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    
    // MARK: - OverrideMethod
    
    override func configureUI() {
        
    }
    
    override func setNavigation() {
        let leftBarButtonItem = UIBarButtonItem(image: Icon.arrow, style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem = leftBarButtonItem
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: mainView.searchBar)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // MARK: - CustomMethod
    
    private func bind() {
        
        let input = SearchViewModel.Input(searchButtonTap: mainView.searchButton.rx.tap, celltap: mainView.collectionView.rx.itemSelected)
        let output = viewModel.transform(input: input)
        
        viewModel.sectionRelay
            .asDriver()
            .drive(mainView.collectionView.rx.items(dataSource: rxDataSource))
            .disposed(by: disposeBag)
        
        mainView.searchBar.rx.searchButtonClicked
            .withLatestFrom(mainView.searchBar.rx.text.orEmpty)
            .distinctUntilChanged()
            .withUnretained(self)
            .bind { vc, value in
                var strArr: [String] = []
                strArr.append(contentsOf: value.components(separatedBy: " "))
                let removedArr = vc.viewModel.removeDuplicate(strArr)
                removedArr.forEach {
                    if $0.count > 8 {
                        vc.view.makeToast("1~8글자까지 작성 가능 합니다", duration: 1, position: .center)
                    } else {
                        var currentArr: [String] = []
                        vc.viewModel.requestData[1].items.forEach { currentArr.append($0.study) }
                        print(currentArr)
                        if currentArr.contains($0) {
                            vc.view.makeToast("이미 추가된 목록이 있어요", duration: 1, position: .center)
                        } else {
                            if vc.viewModel.requestData[1].items.count < 8 {
                                vc.viewModel.requestData[1].items.append(contentsOf: [StudyList(study: $0)])
                                print(vc.viewModel.requestData[1].items)
                                vc.viewModel.sectionRelay.accept(vc.viewModel.requestData)
                            } else {
                                vc.view.makeToast("8개 이상 추가할 수 없습니다", duration: 1, position: .center)
                            }
                        }
                    }
                }
            }
            .disposed(by: disposeBag)
        
        viewModel.statusRelay
            .asSignal()
            .withUnretained(self)
            .emit { (vc, value) in
                if value == 200 {
                    vc.transition(SearchResultViewController(), transitionStyle: .push)
                } else if value == 201 {
                    vc.view.makeToast("신고가 누적되어 이용하실 수 없습니다", duration: 1, position: .center)
                } else if value == 203 {
                    vc.view.makeToast("스터디 취소 패널티로, 1분동안 이용하실 수 없습니다", duration: 1, position: .center)
                } else if value == 204 {
                    vc.view.makeToast("스터디 취소 패널티로, 2분동안 이용하실 수 없습니다", duration: 1, position: .center)
                } else if value == 205 {
                    vc.view.makeToast("스터디 취소 패널티로, 3분동안 이용하실 수 없습니다", duration: 1, position: .center)
                }
            }
            .disposed(by: disposeBag)
        
        output.searchButtonTap
            .withUnretained(self)
            .bind { (vc, _) in
//                vc.viewModel.requestSeSACSearch()
                vc.transition(ChatViewController(), transitionStyle: .push)
            }
            .disposed(by: disposeBag)
        
        output.celltap
            .withUnretained(self)
            .bind { (vc, index) in
                if index.section == 0 {
                    if vc.viewModel.requestData[1].items.count < 8 {
                        var currentArr: [String] = []
                        vc.viewModel.requestData[1].items.forEach { currentArr.append($0.study) }
                        if currentArr.contains(vc.viewModel.requestData[0].items[index.item].study) {
                            vc.view.makeToast("이미 추가된 목록이 있어요", duration: 1, position: .center)
                        } else {
                            vc.viewModel.requestData[1].items.append(contentsOf: [StudyList(study: vc.viewModel.requestData[0].items[index.item].study)])
                            print(index.item)
                        }
                    } else {
                        vc.view.makeToast("8개 이상 추가할 수 없습니다", duration: 1, position: .center)
                    }
                } else {
                    vc.viewModel.requestData[1].items.remove(at: index.item)
                    print(vc.viewModel.requestData[1].items.count)
                }
                vc.viewModel.sectionRelay.accept(vc.viewModel.requestData)
            }
            .disposed(by: disposeBag)
    }
    
    private func configureDatsSource() {
        rxDataSource = RxCollectionViewSectionedAnimatedDataSource<SearchSection>(configureCell: { (datasource, collectionView, indexPath, item) in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCollectionViewCell.reuseIdentifier, for: indexPath) as? SearchCollectionViewCell else { return UICollectionViewCell() }
            cell.setup(data: item.study)
            switch indexPath.section {
            case 0:
                if indexPath.item > self.viewModel.fromRecommend.count - 1 {
                    cell.button.type = .gray
                } else {
                    cell.button.type = .red
                }
            case 1:
                cell.button.type = .green
            default:
                break
            }
            cell.button.isEnabled = false
            return cell
        }, configureSupplementaryView: { (dataSource, collectionView, kind, indexPath) in
            
            switch kind {
            case UICollectionView.elementKindSectionHeader:
                guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SearchCollectionViewSectionHeader.identifier, for: indexPath) as? SearchCollectionViewSectionHeader else {
                    return UICollectionReusableView() }
                header.headerLabel.text = dataSource[indexPath.section].header
                return header
            default:
                assert(false, "Unexpected element kind")
            }
        })
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func keyboardWillAppear() {
        mainView.searchButton.snp.remakeConstraints { make in
            make.directionalHorizontalEdges.equalToSuperview()
            make.height.equalTo(48)
            make.bottom.equalTo(view.keyboardLayoutGuide.snp.top)
        }
        mainView.searchButton.layer.cornerRadius = 0
    }
    
    @objc func keyboardWillDisappear() {
        mainView.searchButton.snp.remakeConstraints { make in
            make.directionalHorizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(48)
            make.bottom.equalTo(view.keyboardLayoutGuide.snp.top)
        }
        mainView.searchButton.layer.cornerRadius = 8
    }
}
