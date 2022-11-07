//
//  SecondPageViewController.swift
//  SeSAC Service Level Project
//
//  Created by 이명진 on 2022/11/07.
//

import UIKit
import Then


final class SecondPageViewController: UIViewController {
    
    private let onboardTextLabel: UILabel = UILabel().then {
        $0.text = Text.secondVCText
        $0.textAlignment = .center
        $0.numberOfLines = 2
        $0.font = .systemFont(ofSize: 24)
        $0.changeColor(targetString: "스터디를 원하는 친구")
    }
    
    private let onboardImageView: UIImageView = UIImageView().then {
        $0.image = UIImage(named: "onboarding_img2")
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
            make.top.equalTo(view.safeAreaLayoutGuide).offset(72)
            make.leading.trailing.equalToSuperview().inset(74)
//            make.bottom.equalToSuperview().offset(-620)
//            make.height.equalTo(76)
        }
        onboardImageView.snp.makeConstraints { make in
            make.top.equalTo(onboardTextLabel.snp.bottom).offset(56)
            make.leading.equalToSuperview().offset(7)
            make.trailing.equalToSuperview().offset(-8)
//            make.bottom.equalToSuperview().offset(-204)
        }
    }
}
