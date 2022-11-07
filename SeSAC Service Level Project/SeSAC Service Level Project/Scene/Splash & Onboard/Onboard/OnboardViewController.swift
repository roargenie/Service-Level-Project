//
//  OnboardViewController.swift
//  SeSAC Service Level Project
//
//  Created by 이명진 on 2022/11/07.
//

import UIKit


final class OnboardViewController: BaseViewController {
    
    private let mainView = OnboardView()
    
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    
}
