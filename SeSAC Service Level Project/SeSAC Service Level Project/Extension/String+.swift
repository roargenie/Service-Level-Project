//
//  String+.swift
//  SeSAC Service Level Project
//
//  Created by 이명진 on 2022/12/24.
//

import Foundation

extension String {
    
    func stringToDate() -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        formatter.locale = Locale(identifier: "ko_kr")
        return formatter.date(from: self) ?? formatter.date(from: "2000-01-01T00:00:00.000Z")!
    }
    
}
