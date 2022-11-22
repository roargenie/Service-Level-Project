//
//  ProfileView.swift
//  SeSAC Service Level Project
//
//  Created by 이명진 on 2022/11/14.
//

import UIKit

final class MyProfileSettingView: BaseView {
    
    let tableView: UITableView = UITableView(frame: .zero, style: .plain).then {
        $0.separatorStyle = .none
        $0.keyboardDismissMode = .onDrag
        $0.register(ProfileNickNameTableViewCell.self, forCellReuseIdentifier: ProfileNickNameTableViewCell.reuseIdentifier)
        $0.register(ProfileReviewTableViewCell.self, forCellReuseIdentifier: ProfileReviewTableViewCell.reuseIdentifier)
        $0.register(ProfileUnregisterTableViewCell.self, forCellReuseIdentifier: ProfileUnregisterTableViewCell.reuseIdentifier)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureUI() {
        self.addSubview(tableView)
    }
    
    override func setConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
}
