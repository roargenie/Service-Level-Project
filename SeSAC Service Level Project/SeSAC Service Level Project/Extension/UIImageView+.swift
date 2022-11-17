//
//  UIImageView+.swift
//  SeSAC Service Level Project
//
//  Created by 이명진 on 2022/11/07.
//

import UIKit


extension UIImageView {
    
    func makeRoundedCorners(_ radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
        //self.layer.masksToBounds = true
    }

    func makeToCircle() {
        self.makeRoundedCorners(self.frame.width / 2)
        self.clipsToBounds = true
    }
}
