//
//  UIViewController+.swift
//  SeSAC Service Level Project
//
//  Created by 이명진 on 2022/11/07.
//

import UIKit


extension UIViewController {
    
    @frozen enum TransitionStyle {
        case presentOverFull
        case presentFull
        case present
        case push
    }
    
    func transition<T: UIViewController>(_ viewController: T, transitionStyle: TransitionStyle) {
        
        switch transitionStyle {
        case .presentOverFull:
            viewController.modalPresentationStyle = .overFullScreen
            self.present(viewController, animated: true)
        case .presentFull:
            viewController.modalPresentationStyle = .fullScreen
            viewController.modalTransitionStyle = .crossDissolve
            self.present(viewController, animated: true)
        case .present:
//            viewController.modalPresentationStyle = .pageSheet
            if let sheet = viewController.sheetPresentationController {
                sheet.detents = [.medium()]
                sheet.preferredCornerRadius = 20
                sheet.prefersScrollingExpandsWhenScrolledToEdge = false
            }
            self.present(viewController, animated: true)
        case .push:
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
}
