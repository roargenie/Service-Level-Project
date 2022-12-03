//
//  CustomAlertViewController.swift
//  SeSAC Service Level Project
//
//  Created by 이명진 on 2022/12/04.
//

import UIKit

protocol DoneButtonDelegate: AnyObject {
    func doneButtonTapped()
}

final class CustomAlertViewController: BaseViewController {
    
    weak var doneButtonDelegate: DoneButtonDelegate?
    
    var alertType: Alert = .withdraw {
        didSet {
            titleLabel.text = alertType.title
            subtitleLabel.text = alertType.subtitle
        }
    }
        
    private let alertView: UIView = UIView().then {
        $0.backgroundColor = .white
        $0.makeCornerStyle(width: 0, radius: 16)
    }
    
    private let titleLabel: UILabel = UILabel().then {
        $0.font = SeSACFont.body1.font
        $0.textColor = Color.black
        $0.textAlignment = .center
    }
    
    private let subtitleLabel: UILabel = UILabel().then {
        $0.font = SeSACFont.title4.font
        $0.textColor = Color.gray7
        $0.numberOfLines = 0
        $0.textAlignment = .center
    }
    
    private lazy var cancelButton: PlainButton = PlainButton(.cancel, height: .h48).then {
        $0.title = "취소"
        $0.addAction(cancelButtonTapped, for: .touchUpInside)
    }
    
    lazy var doneButton: PlainButton = PlainButton(.fill, height: .h48).then {
        $0.title = "확인"
        $0.addAction(doneButtonTapped, for: .touchUpInside)
    }
    
    private lazy var buttonStackView: UIStackView = UIStackView(arrangedSubviews: [cancelButton, doneButton]).then {
        $0.axis = .horizontal
        $0.spacing = 8
        $0.alignment = .fill
        $0.distribution = .fillEqually
    }
    
    private lazy var cancelButtonTapped = UIAction { _ in
        self.dismiss(animated: false)
    }
    
    private lazy var doneButtonTapped = UIAction { _ in
        self.doneButtonDelegate?.doneButtonTapped()
        self.dismiss(animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = Color.black.withAlphaComponent(0.5)
        print("===================Alert")
//        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseOut) { [weak self] in
//            guard let self = self else { return }
//            self.view.backgroundColor = Color.black.withAlphaComponent(0.5)
//        }
    }
    
    override func configureUI() {
        view.addSubview(alertView)
        [titleLabel, subtitleLabel, buttonStackView].forEach { alertView.addSubview($0) }
//        view.backgroundColor = Color.black.withAlphaComponent(0.5)
    }
    override func setConstraints() {
        
        alertView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.directionalHorizontalEdges.equalToSuperview().inset(16)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.centerX.equalToSuperview()
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }
        
        buttonStackView.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(16)
            make.leading.bottom.trailing.equalToSuperview().inset(16)
        }
    }
}
