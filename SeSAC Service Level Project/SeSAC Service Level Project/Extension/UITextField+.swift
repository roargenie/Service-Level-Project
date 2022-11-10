//
//  String+.swift
//  SeSAC Service Level Project
//
//  Created by 이명진 on 2022/11/09.
//

import UIKit


extension UITextField {
    
    func backWards(with textString: String, _ maximumCount: Int) {
        if textString.count > maximumCount {
            self.deleteBackward()
        }
    }
}
