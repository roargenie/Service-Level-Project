//
//  SearchView.swift
//  SeSAC Service Level Project
//
//  Created by 이명진 on 2022/11/14.
//

import UIKit

final class SearchView: BaseView {
    
    lazy var collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout.fixedSpacedFlowLayout()).then {
        $0.keyboardDismissMode = .onDrag
        $0.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: SearchCollectionViewCell.reuseIdentifier)
        $0.register(SearchCollectionViewSectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SearchCollectionViewSectionHeader.identifier)
    }
    
    let searchBar: UISearchBar = UISearchBar(
        frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 70, height: 0)).then {
            $0.placeholder = "띄어쓰기로 복수 입력이 가능해요"
//            $0.setScopeBarButtonTitleTextAttributes([NSAttributedString.Key.foregroundColor: Color.gray6,
//                                                     NSAttributedString.Key.font: SeSACFont.title4.font], for: .normal)
        }
    
    let searchButton: SeSACButton = SeSACButton().then {
        $0.setupButton(title: "새싹 찾기",
                       titleColor: Color.white,
                       font: SeSACFont.body3.font,
                       backgroundColor: Color.green,
                       borderWidth: 1,
                       borderColor: .clear)
//        $0.isEnabled = false
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureUI() {
        [collectionView, searchButton].forEach { self.addSubview($0) }
    }
    
    override func setConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        searchButton.snp.makeConstraints { make in
            make.bottom.equalTo(self.keyboardLayoutGuide.snp.top)
            make.directionalHorizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(48)
        }
    }
    
}

extension UICollectionViewLayout {
    static func fixedSpacedFlowLayout() -> UICollectionViewLayout {
        
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .estimated(150),
            heightDimension: .absolute(32)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(100)
        )
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = NSCollectionLayoutSpacing.fixed(8)
        
        let sectionHeaderPadding: CGFloat = 32
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 8
        section.contentInsets = NSDirectionalEdgeInsets(
            top: 16 + sectionHeaderPadding,
            leading: 16,
            bottom: 8,
            trailing: 16)
        
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(32)),
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .topLeading, absoluteOffset: CGPoint(x: 0, y: sectionHeaderPadding))
        
        section.boundarySupplementaryItems = [header]
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}
