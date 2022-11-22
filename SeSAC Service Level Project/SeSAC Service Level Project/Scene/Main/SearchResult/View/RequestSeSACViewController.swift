//
//  RequestSeSACViewController.swift
//  SeSAC Service Level Project
//
//  Created by 이명진 on 2022/11/22.
//

import UIKit
import RxCocoa
import RxSwift

final class RequestSeSACViewController: BaseViewController {
    
    //MARK: - Properties
    
    private let mainView = RequestSeSACView()
    private let viewModel = SearchResultViewModel()
    
    private var disposeBag = DisposeBag()
    
    //MARK: - LifeCycle
        
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - OverrideMethod
    
    override func configureUI() {
        
    }
    
    override func setConstraints() {
        
    }
    
    //MARK: - CustomMethod
    
    private func bind() {
        
    }
}
