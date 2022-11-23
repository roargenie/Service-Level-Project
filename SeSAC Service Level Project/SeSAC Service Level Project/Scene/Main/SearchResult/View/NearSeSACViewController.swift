//
//  NearSeSACViewController.swift
//  SeSAC Service Level Project
//
//  Created by 이명진 on 2022/11/22.
//

import UIKit
import RxCocoa
import RxSwift

final class NearSeSACViewController: BaseViewController {
    
    //MARK: - Properties
    
    private let mainView = NearSeSACView()
    private let viewModel = SearchResultViewModel()
    
    private var disposeBag = DisposeBag()
    
    private var isSelected: Bool = false {
        didSet {
            mainView.tableView.reloadData()
        }
    }
    
    var dummydata = [1, 2, 3, 4, 5]
    
    //MARK: - LifeCycle
        
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - OverrideMethod
    
    override func configureUI() {
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
    }
    
    override func setConstraints() {
        
    }
    
    //MARK: - CustomMethod
    
    private func bind() {
//        viewModel.nearSeSAC
//            .bind(to: mainView.tableView.rx.items) { (tv, row, item) -> UITableViewCell in
//
//            }
    }
    
    @objc private func moreButtonTapped() {
        isSelected = !isSelected
    }
}

extension NearSeSACViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        mainView.emptyView.isHidden = dummydata.isEmpty ? false : true
        mainView.studyChangeButton.isHidden = dummydata.isEmpty ? false : true
        mainView.refreshButton.isHidden = dummydata.isEmpty ? false : true
        return dummydata.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileNickNameTableViewCell.reuseIdentifier, for: indexPath) as? ProfileNickNameTableViewCell else { return UITableViewCell() }
        cell.firstLineView.moreButton.addTarget(self, action: #selector(moreButtonTapped), for: .touchUpInside)
        if isSelected == true {
            cell.secondLineView.isHidden = false
            cell.thirdLineView.isHidden = false
            cell.firstLineView.moreButton.setImage(Icon.uparrow, for: .normal)
        } else {
            cell.secondLineView.isHidden = true
            cell.thirdLineView.isHidden = true
            cell.firstLineView.moreButton.setImage(Icon.downarrow, for: .normal)
        }
        return cell
    }
    
}
