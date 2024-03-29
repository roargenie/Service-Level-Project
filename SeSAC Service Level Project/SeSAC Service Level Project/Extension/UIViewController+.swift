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
        case changeRootVC
        case alert
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
        case .changeRootVC:
            let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
            let sceneDelegate = windowScene?.delegate as? SceneDelegate
            sceneDelegate?.window?.rootViewController = viewController
            sceneDelegate?.window?.makeKeyAndVisible()
        case .alert:
            viewController.modalPresentationStyle = .overCurrentContext
            self.present(viewController, animated: false)
        }
    }
    
    
}

extension Sequence where Element: Hashable {
    func uniqued() -> [Element] {
        var set = Set<Element>()
        return filter { set.insert($0).inserted }
    }
}
