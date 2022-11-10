//
//  String+.swift
//  SeSAC Service Level Project
//
//  Created by 이명진 on 2022/11/11.
//

import UIKit


extension Date {
    
    func dateFormat(_ format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter.string(from: self)
    }
    
    func ageValid() -> Bool {
        let calendar = Calendar.current
        let ageValid = calendar.dateComponents([.year], from: self, to: Date.now).year ?? 0
        if ageValid >= 17 {
            return true
        } else {
            return false
        }
    }
}
