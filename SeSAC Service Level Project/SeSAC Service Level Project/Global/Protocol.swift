//
//  Protocol.swift
//  SeSAC Service Level Project
//
//  Created by 이명진 on 2022/11/09.
//

import Foundation

protocol CommonViewModel {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}

protocol ReusableViewProtocol: AnyObject {
    static var reuseIdentifier: String { get }
}
