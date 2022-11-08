//
//  String+.swift
//  SeSAC Service Level Project
//
//  Created by 이명진 on 2022/11/09.
//

import Foundation


extension String {
    
    func pretty() -> String {
        let _str = self.replacingOccurrences(of: "-", with: "") // 하이픈 모두 빼준다
        let arr = Array(_str)
        
        if arr.count > 3 {
            let prefix = String(format: "%@%@", String(arr[0]), String(arr[1]))
            if prefix == "02" { // 서울지역은 02번호
                
                if let regex = try? NSRegularExpression(pattern: "([0-9]{2})([0-9]{3,4})([0-9]{4})", options: .caseInsensitive) {
                    let modString = regex.stringByReplacingMatches(in: _str, options: [],
                                                                   range: NSRange(_str.startIndex..., in: _str),
                                                                   withTemplate: "$1-$2-$3")
                    return modString
                }
                
            } else if prefix == "15" || prefix == "16" || prefix == "18" { // 썩을 지능망...
                if let regex = try? NSRegularExpression(pattern: "([0-9]{4})([0-9]{4})", options: .caseInsensitive) {
                    let modString = regex.stringByReplacingMatches(in: _str, options: [],
                                                                   range: NSRange(_str.startIndex..., in: _str),
                                                                   withTemplate: "$1-$2")
                    return modString
                }
            } else { // 나머지는 휴대폰번호 (010-xxxx-xxxx, 031-xxx-xxxx, 061-xxxx-xxxx 식이라 상관무)
                if let regex = try? NSRegularExpression(pattern: "([0-9]{3})([0-9]{3,4})([0-9]{4})", options: .caseInsensitive) {
                    let modString = regex.stringByReplacingMatches(in: _str, options: [],
                                                                   range: NSRange(_str.startIndex..., in: _str),
                                                                   withTemplate: "$1-$2-$3")
                    return modString
                }
            }
            
        }
        
        return self
    }
}
