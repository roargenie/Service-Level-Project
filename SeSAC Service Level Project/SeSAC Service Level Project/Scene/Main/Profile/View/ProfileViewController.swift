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


final class ProfileViewController: BaseViewController {
    
    // MARK: - Properties
    
    private let mainView = ProfileView()
    private let viewModel = ProfileViewModel()
    
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
    
    override func configureUI() {
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
    }
    
    override func setNavigation() {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // MARK: - CustomMethod
    
    private func bind() {
        
    }
    
    @objc private func moreButtonTapped(_ sender: UIButton) {
        print("버튼 클릭")
        sender.isSelected = !sender.isSelected
        print(sender.isSelected)
        mainView.tableView.reloadSections(IndexSet(1...1), with: .fade)
    }
    
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
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
            if cell.moreButton.isSelected == true {
                cell.secondLineView.isHidden = true
                cell.thirdLineView.isHidden = true
            } else {
                cell.secondLineView.isHidden = false
                cell.thirdLineView.isHidden = false
            }
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileReviewTableViewCell.reuseIdentifier, for: indexPath) as? ProfileReviewTableViewCell else { return UITableViewCell() }
            
            return cell
        }
    }
    
}

