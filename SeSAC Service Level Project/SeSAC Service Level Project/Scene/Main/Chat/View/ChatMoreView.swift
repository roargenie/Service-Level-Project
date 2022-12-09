//
//  ChatMoreView.swift
//  SeSAC Service Level Project
//
//  Created by 이명진 on 2022/12/09.
//

import UIKit

final class ChatMoreView: BaseView {
    
    private lazy var stackView = UIStackView(arrangedSubviews: [reportButton, cancelButton, reviewButton]).then {
        $0.axis = .horizontal
        $0.distribution = .equalCentering
        $0.alignment = .fill
    }
    
    let reportButton: UIButton = UIButton().then {
        $0.backgroundColor = .white
        $0.setTitle("새싹 신고", for: .normal)
        $0.setTitleColor(Color.black, for: .normal)
        $0.titleLabel?.font = SeSACFont.title3.font
        var configuration = UIButton.Configuration.plain()
        configuration.titleAlignment = .center
        configuration.image = Icon.siren
        configuration.imagePlacement = .top
        configuration.imagePadding = 4
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 11, leading: 0, bottom: 11, trailing: 0)
        $0.configuration = configuration
    }
    let cancelButton: UIButton = UIButton().then {
        $0.backgroundColor = .white
        $0.setTitle("스터디 취소", for: .normal)
        $0.setTitleColor(Color.black, for: .normal)
        $0.titleLabel?.font = SeSACFont.title3.font
        var configuration = UIButton.Configuration.plain()
        configuration.titleAlignment = .center
        configuration.image = Icon.cancelMatch
        configuration.imagePlacement = .top
        configuration.imagePadding = 4
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 11, leading: 0, bottom: 11, trailing: 0)
        $0.configuration = configuration
    }
    
    let reviewButton: UIButton = UIButton().then {
        $0.backgroundColor = .white
        $0.setTitle("리뷰 등록", for: .normal)
        $0.setTitleColor(Color.black, for: .normal)
        $0.titleLabel?.font = SeSACFont.title3.font
        var configuration = UIButton.Configuration.plain()
        configuration.titleAlignment = .center
        configuration.image = Icon.write
        configuration.imagePlacement = .top
        configuration.imagePadding = 4
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 11, leading: 0, bottom: 11, trailing: 0)
        $0.configuration = configuration
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
    }
    
    override func configureUI() {
        addSubview(stackView)
    }
    override func setConstraints() {
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        reportButton.snp.makeConstraints { make in
            make.height.equalTo(72)
            make.width.equalTo(UIScreen.main.bounds.width / 3)
        }
        cancelButton.snp.makeConstraints { make in
            make.height.equalTo(72)
            make.width.equalTo(UIScreen.main.bounds.width / 3)
        }
        reviewButton.snp.makeConstraints { make in
            make.height.equalTo(72)
            make.width.equalTo(UIScreen.main.bounds.width / 3)
        }
    }
}
