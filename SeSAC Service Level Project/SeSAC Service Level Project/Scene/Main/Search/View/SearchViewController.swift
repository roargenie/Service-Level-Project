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
import CoreLocation

final class SearchViewController: BaseViewController {
    
    // MARK: - Properties
    
    private let mainView = SearchView()
    private let viewModel = SearchViewModel()
    
    private var disposeBag = DisposeBag()
    
    var centerCoordinate: CLLocationCoordinate2D?
    
    private var fromRecommend: [String] = []
    
    private var myStudy: [String] = []
    
    private var rxDataSource: RxCollectionViewSectionedAnimatedDataSource<SearchSection>!
    
    private var requestData = [
        SearchSection(header: "지금 주변에는", items: []),
        SearchSection(header: "내가 하고 싶은", items: [])
    ]
    
    private var sectionRelay = BehaviorRelay(value: [SearchSection]())
    
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
        if let coordinate = centerCoordinate {
            requestStudy(center: coordinate)
        }
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
        mainView.searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        mainView.searchBar.delegate = self
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
        
        let input = SearchViewModel.Input(celltap: mainView.collectionView.rx.itemSelected)
        let output = viewModel.transform(input: input)
        
        sectionRelay
            .asDriver()
            .drive(mainView.collectionView.rx.items(dataSource: rxDataSource))
            .disposed(by: disposeBag)
        
        mainView.searchBar.rx.searchButtonClicked
            .withLatestFrom(mainView.searchBar.rx.text.orEmpty)
            .distinctUntilChanged()
            .withUnretained(self)
            .bind { vc, value in
                //                print("===================================", value)
                vc.requestData[1].items.append(contentsOf: ["\(value) X"])
                print(vc.requestData[1].items)
                vc.sectionRelay.accept(vc.requestData)
            }
            .disposed(by: disposeBag)
        
        output.celltap
            .distinctUntilChanged()
            .withUnretained(self)
            .bind { (vc, index) in
                vc.requestData[1].items.append("\(vc.requestData[0].items[index.item]) X")
                print(index.item)
                vc.sectionRelay.accept(vc.requestData)
            }
            .disposed(by: disposeBag)
    }
    
    private func configureDatsSource() {
        rxDataSource = RxCollectionViewSectionedAnimatedDataSource<SearchSection>(configureCell: { (datasource, collectionView, indexPath, item) in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCollectionViewCell.reuseIdentifier, for: indexPath) as? SearchCollectionViewCell else { return UICollectionViewCell() }
            //            guard let self = self else { return }
            switch indexPath.section {
            case 0:
                if indexPath.item > self.fromRecommend.count - 1 {
                    cell.button.setupButton(title: "\(item)",
                                            titleColor: Color.black,
                                            font: SeSACFont.title4.font,
                                            backgroundColor: Color.white,
                                            borderWidth: 1,
                                            borderColor: Color.gray4)
                    
                } else {
                    cell.button.setupButton(title: "\(item)",
                                            titleColor: Color.error,
                                            font: SeSACFont.title4.font,
                                            backgroundColor: Color.white,
                                            borderWidth: 1,
                                            borderColor: Color.error)
                }
            case 1:
                cell.button.setupButton(title: "\(item)",
                                        titleColor: Color.green,
                                        font: SeSACFont.title4.font,
                                        backgroundColor: Color.white,
                                        borderWidth: 1,
                                        borderColor: Color.green)
            default:
                break
            }
            cell.button.isEnabled = false
            return cell
        }, configureSupplementaryView: { (dataSource, collectionView, kind, indexPath) in
            print("Kind: \\(kind)")
            
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
    
    private func requestStudy(center: CLLocationCoordinate2D) {
        APIManager.shared.requestData(SearchResult.self,
                                      router: SeSACRouter
            .search(Search(lat: center.latitude,
                           long: center.longitude))) { [weak self] response, statusCode in
            guard let self = self else { return }
            if statusCode == 401 {
                self.refreshIdToken()
            }
            print(statusCode)
            switch response {
            case .success(let value):
                guard let value = value else { return }
                // 각각의 배열이 합쳐졌을때 중복을 제거해야 할 것 같은데.. 서버통신할때 걸러서 받을 순 없을것 같고.. rxDataSource에 넣을때 바로 걸러서 넣는것도 실패
                var stringArr = [String]()
                self.requestData[0].items.append(contentsOf: value.fromRecommend)
                value.fromQueueDB.forEach { stringArr.append(contentsOf: $0.studylist) }
                value.fromQueueDBRequested.forEach { stringArr.append(contentsOf: $0.studylist) }
                // 이렇게까지 해야하나???????????
                self.requestData[0].items.append(contentsOf: self.removeDuplicate(stringArr))
                self.fromRecommend.append(contentsOf: value.fromRecommend)
                print("=============🟢=============", self.requestData[0].items)
                self.sectionRelay.accept(self.requestData)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func removeDuplicate (_ array: [String]) -> [String] {
        var removedArray = [String]()
        for i in array {
            if removedArray.contains(i) == false {
                removedArray.append(i)
            }
        }
        return removedArray
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func searchButtonTapped() {
        let vc = SearchResultViewController()
        transition(vc, transitionStyle: .push)
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

extension SearchViewController: UISearchBarDelegate {
    
}
