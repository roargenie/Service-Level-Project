//
//  NearSeSACViewController.swift
//  SeSAC Service Level Project
//
//  Created by 이명진 on 2022/11/22.
//

import UIKit
import RxCocoa
import RxSwift
import CoreLocation

final class NearSeSACViewController: BaseViewController {
    
    //MARK: - Properties
    
    private let mainView = NearSeSACView()
    private let viewModel = SearchResultViewModel()
    
    private var disposeBag = DisposeBag()
    
    private var isSelected: [Bool] = []
    
    private var uid: String = ""
    
    //MARK: - LifeCycle
        
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.requestNearSeSAC()
        bind()
    }
    
    //MARK: - OverrideMethod
    
    
    //MARK: - CustomMethod
    
    private func bind() {
        
        viewModel.nearSeSAC
            .withUnretained(self)
            .bind { vc, value in
                vc.mainView.setupEmptyStateView(value: value)
                vc.isSelected = Array<Bool>(repeating: false, count: value.count)
            }
            .disposed(by: disposeBag)
        
        viewModel.nearSeSAC
            .asDriver()
            .drive(mainView.tableView.rx.items) { [weak self] (tv, row, item) -> UITableViewCell in
                guard let cell = tv.dequeueReusableCell(withIdentifier: ProfileNickNameTableViewCell.reuseIdentifier, for: IndexPath.init(row: row, section: 0)) as? ProfileNickNameTableViewCell else { return UITableViewCell() }
                cell.firstLineView.moreButton.addTarget(self, action: #selector(self?.moreButtonTapped), for: .touchUpInside)
                cell.firstLineView.moreButton.tag = row
                cell.setupCellData(data: item, buttonType: .request)
                cell.requestButton.rx.tap
                    .bind { _ in
                        self?.presentAlert()
                        self?.uid = item.uid
                        print(item.uid)
                    }
                    .disposed(by: cell.disposeBag)
                if self?.isSelected[row] == true {
                    cell.setupExpendedCell(hidden: false, image: Icon.uparrow)
                } else {
                    cell.setupExpendedCell(hidden: true, image: Icon.downarrow)
                }
                return cell
            }
            .disposed(by: disposeBag)
        
        viewModel.requestStatus
            .withUnretained(self)
            .bind { vc, value in
                if value == 200 {
                    vc.view.makeToast("스터디 요청을 보냈습니다", duration: 1, position: .center)
                } else if value == 201 {
                    vc.view.makeToast("", duration: 1, position: .center)
                } else if value == 202 {
                    vc.view.makeToast("상대방이 스터디 찾기를 그만두었습니다", duration: 1, position: .center)
                }
            }
            .disposed(by: disposeBag)
        
    }
    
    private func presentAlert() {
        let vc = CustomAlertViewController()
        vc.alertType = .studyRequest
        vc.doneButton.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
        transition(vc, transitionStyle: .alert)
    }
    
    @objc private func moreButtonTapped(_ sender: UIButton) {
        isSelected[sender.tag] = !isSelected[sender.tag]
        mainView.tableView.reloadData()
    }
    
    @objc private func doneButtonTapped() {
        viewModel.requestStudyRequest(uid)
    }
}

