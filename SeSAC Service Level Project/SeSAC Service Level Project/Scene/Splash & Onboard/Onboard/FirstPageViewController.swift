//
//  FirstPageViewController.swift
//  SeSAC Service Level Project
//
//  Created by 이명진 on 2022/11/07.
//

import UIKit
import Then

final class FirstPageViewController: UIViewController {
    
    private let onboardTextLabel: UILabel = UILabel().then {
        $0.text = Matrix.firstVCText
        $0.textAlignment = .center
        $0.numberOfLines = 2
        $0.font = SeSACFont.onboard.font
        $0.changeColor(targetString: "위치 기반")
    }
    
    private let onboardImageView: UIImageView = UIImageView().then {
        $0.image = Icon.firstOnboardingImage
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
            make.centerX.equalToSuperview()
        }
        onboardImageView.snp.makeConstraints { make in
            make.top.equalTo(onboardTextLabel.snp.bottom).offset(56)
            make.leading.equalToSuperview().offset(7)
            make.trailing.equalToSuperview().offset(-8)
//            make.bottom.equalToSuperview().offset(-204)
        }
    }
}
