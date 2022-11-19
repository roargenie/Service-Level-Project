//
//  SearchView.swift
//  SeSAC Service Level Project
//
//  Created by 이명진 on 2022/11/14.
//

import UIKit

final class SearchView: BaseView {
    
    lazy var collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: setLayout())
    
    let searchBar: UISearchBar = UISearchBar()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    private func setLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection in
            
            let spacing = CGFloat(4)
            
            let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(.zero),
                                                  heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .fractionalWidth(0.5))
            
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 2)
            group.interItemSpacing = .fixed(spacing)
            
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = spacing
            section.contentInsets = NSDirectionalEdgeInsets(top: spacing,
                                                            leading: spacing,
                                                            bottom: spacing,
                                                            trailing: spacing)
            return section
        }
            
        return layout
    }
}
