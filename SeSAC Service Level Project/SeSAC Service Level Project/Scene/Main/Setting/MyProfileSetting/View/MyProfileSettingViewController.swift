//
//  ProfileViewController.swift
//  SeSAC Service Level Project
//
//  Created by 이명진 on 2022/11/14.
//

import UIKit
import RxSwift
import RxCocoa
import FirebaseAuth

final class MyProfileSettingViewController: BaseViewController {
    
    // MARK: - Properties
    
    private let mainView = MyProfileSettingView()
    private let viewModel = MyProfileSettingViewModel()
    
    private var disposeBag = DisposeBag()
    
    private var isSelected: Bool = false {
        didSet {
            mainView.tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .fade)
        }
    }
    
    // MARK: - LifeCycle
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    // MARK: - OverrideMethod
    
    override func configureUI() {
        title = "정보 관리"
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
    }
    
    override func setNavigation() {
        let leftBarButtonItem = UIBarButtonItem(image: Icon.arrow, style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem = leftBarButtonItem
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // MARK: - CustomMethod
    
    private func bind() {
        
        
        
    }
    
    @objc private func moreButtonTapped() {
        isSelected = !isSelected
    }
    
    @objc private func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension MyProfileSettingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
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
        } else if indexPath.row == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileReviewTableViewCell.reuseIdentifier, for: indexPath) as? ProfileReviewTableViewCell else { return UITableViewCell() }
            
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileUnregisterTableViewCell.reuseIdentifier, for: indexPath) as? ProfileUnregisterTableViewCell else { return UITableViewCell() }
            
            return cell
        }
    }
    
}
