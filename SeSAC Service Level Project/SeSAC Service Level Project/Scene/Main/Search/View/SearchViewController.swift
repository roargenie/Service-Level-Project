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


final class SearchViewController: BaseViewController {
    
    // MARK: - Properties
    
    private let mainView = SearchView()
    private let viewModel = SearchViewModel()
    
    private var disposeBag = DisposeBag()
    
    // MARK: - LifeCycle
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = true
        navigationController?.navigationBar.isHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        navigationController?.navigationBar.isHidden = false
    }
    
    // MARK: - OverrideMethod
    
    override func configureUI() {
        mainView.searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
    }
    
    override func setNavigation() {
        let leftBarButtonItem = UIBarButtonItem(image: Icon.arrow, style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem = leftBarButtonItem
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // MARK: - CustomMethod
    
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func searchButtonTapped() {
        let vc = SearchResultViewController()
        transition(vc, transitionStyle: .push)
    }
}
