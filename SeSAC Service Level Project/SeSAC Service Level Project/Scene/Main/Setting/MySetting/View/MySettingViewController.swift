//
//  MySettingViewController.swift
//  SeSAC Service Level Project
//
//  Created by 이명진 on 2022/11/15.
//

import UIKit
import RxSwift
import RxCocoa

final class MySettingViewController: BaseViewController {
    
    // MARK: - Properties
    
    private let mainView = MySettingView()
    private let viewModel = MySettingViewModel()
    
    private var disposeBag = DisposeBag()
    
    private var myProfileData = MySettingModelData()
    
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
        tabBarController?.tabBar.isHidden = false
    }
    
    
    // MARK: - OverrideMethod
    
    override func configureUI() {
        title = "내정보"
    }
    
    override func setNavigation() {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // MARK: - CustomMethod
    
    private func bind() {
        
        let input = MySettingViewModel.Input(celltap: mainView.tableView.rx.itemSelected)
        let output = viewModel.transform(input: input)
        
        viewModel.mySetting
            .bind(to: mainView.tableView.rx.items) { (tv, row, item) -> UITableViewCell in
                if row == 0 {
                    guard let cell = tv.dequeueReusableCell(withIdentifier: MyProfileCell.reuseIdentifier, for: IndexPath.init(row: 0, section: 0)) as? MyProfileCell else { return UITableViewCell() }
                    DispatchQueue.main.async {
                        cell.profileImageView.makeToCircle()
                    }
                    cell.profileImageView.image = item.profileImage
                    cell.myNicknameLabel.text = item.text
                    return cell
                } else {
                    guard let cell = tv.dequeueReusableCell(withIdentifier: MySettingCell.reuseIdentifier, for: IndexPath.init(row: 0, section: 0)) as? MySettingCell else { return UITableViewCell() }
                    cell.settingImageView.image = item.profileImage
                    cell.settingLabel.text = item.text
                    return cell
                }
            }
            .disposed(by: disposeBag)
        
        output.celltap
            .withUnretained(self)
            .bind { (vc, indexPath) in
                if indexPath.row == 0 {
                    vc.pushMyProfileVC()
                }
            }
            .disposed(by: disposeBag)
        
    }
    
    private func pushMyProfileVC() {
        let vc = MyProfileSettingViewController()
        transition(vc, transitionStyle: .push)
    }
    
}
