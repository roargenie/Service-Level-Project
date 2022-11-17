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
            mainView.tableView.reloadSections(IndexSet(1...1), with: .fade)
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileImageTableViewCell.reuseIdentifier, for: indexPath) as? ProfileImageTableViewCell else { return UITableViewCell() }
            cell.profileImageView.image = Icon.profileImg
            return cell
        } else if indexPath.section == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileNickNameTableViewCell.reuseIdentifier, for: indexPath) as? ProfileNickNameTableViewCell else { return UITableViewCell() }
            cell.moreButton.addTarget(self, action: #selector(moreButtonTapped), for: .touchUpInside)
            if isSelected == true {
                cell.secondLineView.isHidden = false
                cell.thirdLineView.isHidden = false
                cell.moreButton.setImage(Icon.uparrow, for: .normal)
            } else {
                cell.secondLineView.isHidden = true
                cell.thirdLineView.isHidden = true
                cell.moreButton.setImage(Icon.downarrow, for: .normal)
            }
            return cell
        } else if indexPath.section == 2 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileReviewTableViewCell.reuseIdentifier, for: indexPath) as? ProfileReviewTableViewCell else { return UITableViewCell() }
            
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileUnregisterTableViewCell.reuseIdentifier, for: indexPath) as? ProfileUnregisterTableViewCell else { return UITableViewCell() }
            
            return cell
        }
    }
    
}
