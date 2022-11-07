//
//  ThirdPageViewController.swift
//  SeSAC Service Level Project
//
//  Created by 이명진 on 2022/11/07.
//

import UIKit
import Then


final class ThirdPageViewController: UIViewController {
    
    private let onboardTextLabel: UILabel = UILabel().then {
        $0.text = Text.thirdVCText
        $0.textAlignment = .center
        $0.font = .systemFont(ofSize: 24)
    }
    
    private let onboardImageView: UIImageView = UIImageView().then {
        $0.image = UIImage(named: "onboarding_img3")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setConstraints()
//        view.backgroundColor = .green
    }
    
    func configureUI() {
        [onboardTextLabel, onboardImageView].forEach { view.addSubview($0) }
    }
    
    func setConstraints() {
        onboardTextLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(91)
            make.leading.trailing.equalToSuperview().inset(85)
//            make.bottom.equalToSuperview().offset(-620)
//            make.height.equalTo(76)
        }
        onboardImageView.snp.makeConstraints { make in
            make.top.equalTo(onboardTextLabel.snp.bottom).offset(75)
            make.leading.equalToSuperview().offset(7)
            make.trailing.equalToSuperview().offset(-8)
//            make.bottom.equalToSuperview().offset(-204)
        }
    }
}