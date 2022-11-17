//
//  MySettingView.swift
//  SeSAC Service Level Project
//
//  Created by 이명진 on 2022/11/15.
//

import UIKit

final class MySettingView: BaseView {
    
    let tableView: UITableView = UITableView(frame: .zero, style: .plain).then {
        $0.separatorStyle = .singleLine
        $0.register(MyProfileCell.self, forCellReuseIdentifier: MyProfileCell.reuseIdentifier)
        $0.register(MySettingCell.self, forCellReuseIdentifier: MySettingCell.reuseIdentifier)
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
