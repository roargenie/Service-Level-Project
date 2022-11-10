//
//  GenderView.swift
//  SeSAC Service Level Project
//
//  Created by 이명진 on 2022/11/08.
//

import UIKit


final class GenderView: BaseView {
    
    let collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout()).then {
        $0.register(GenderCollectionViewCell.self, forCellWithReuseIdentifier: GenderCollectionViewCell.reuseIdentifier)
    }
    
    let descriptionLabel: UILabel = UILabel().then {
        $0.text = "성별을 선택해 주세요"
        $0.textAlignment = .center
        $0.numberOfLines = 2
        $0.textColor = Color.black
        $0.font = SeSACFont.display1.font
    }
    
    let subDescriptionLabel: UILabel = UILabel().then {
        $0.text = "새싹 찾기 기능을 이용하기 위해서 필요해요!"
        $0.textAlignment = .center
        $0.numberOfLines = 2
        $0.textColor = Color.gray7
        $0.font = SeSACFont.title2.font
    }
    
    let nextButton: SeSACButton = SeSACButton().then {
        $0.setupButton(title: "다음",
                       titleColor: Color.gray3,
                       font: SeSACFont.body3.font,
                       backgroundColor: Color.gray6,
                       borderWidth: 0,
                       borderColor: .clear)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureUI() {
        [collectionView, descriptionLabel, subDescriptionLabel, nextButton].forEach { self.addSubview($0) }
    }
    
    override func setConstraints() {
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(80)
            make.centerX.equalToSuperview()
        }
        subDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(subDescriptionLabel.snp.bottom).offset(32)
            make.directionalHorizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(120)
        }
        nextButton.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(32)
            make.directionalHorizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(48)
        }
    }
    
    static func collectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let deviceWidth: CGFloat = UIScreen.main.bounds.width
        let itemSize: CGFloat = (deviceWidth - 44) / 2
//        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 12
        layout.itemSize = CGSize(width: itemSize, height: 120)
//        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        layout.scrollDirection = .horizontal
        return layout
    }
    
}
