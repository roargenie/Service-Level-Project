//
//  Cell+.swift
//  SeSAC Service Level Project
//
//  Created by 이명진 on 2022/11/09.
//

import UIKit

extension UITableViewCell: ReusableViewProtocol {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UICollectionViewCell: ReusableViewProtocol {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
