//
//  BaseViewController.swift
//  SeSAC Service Level Project
//
//  Created by 이명진 on 2022/11/07.
//

import UIKit


class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setConstraints()
        view.backgroundColor = .white
    }
    
    func configureUI() { }
    func setConstraints() { }
    
}
