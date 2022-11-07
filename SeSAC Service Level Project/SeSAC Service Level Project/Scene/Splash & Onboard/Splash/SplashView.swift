//
//  SplashView.swift
//  SeSAC Service Level Project
//
//  Created by 이명진 on 2022/11/07.
//

import UIKit
import Then
import SnapKit

final class SplashView: BaseView {
    
    let splashLogoImageView: UIImageView = UIImageView().then {
        $0.image = Icon.splashLogo
        $0.alpha = 0
    }
    
    let splashTextImageView: UIImageView = UIImageView().then {
        $0.image = Icon.splashText
        $0.alpha = 0
        $0.contentMode = .scaleAspectFit
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureUI() {
        [splashLogoImageView, splashTextImageView].forEach { self.addSubview($0) }
    }
    
    override func setConstraints() {
        splashLogoImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(219)
            make.leading.equalToSuperview().offset(78)
            make.trailing.equalToSuperview().offset(-79)
            make.bottom.equalToSuperview().offset(-333.44)
        }
        splashTextImageView.snp.makeConstraints { make in
            make.top.equalTo(splashLogoImageView.snp.bottom).offset(35.44)
            make.leading.equalToSuperview().offset(41)
            make.trailing.equalToSuperview().offset(-42)
            make.bottom.equalToSuperview().offset(-197)
        }
    }
    
}
