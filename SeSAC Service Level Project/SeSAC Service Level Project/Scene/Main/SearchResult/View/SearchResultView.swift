//
//  SearchResultView.swift
//  SeSAC Service Level Project
//
//  Created by 이명진 on 2022/11/21.
//

import UIKit

final class SearchResultView: BaseView {
    
    private lazy var containerView: UIView = UIView().then {
        $0.backgroundColor = .clear
        $0.addSubview(segmentControl)
        $0.addSubview(backgroundUnderLineView)
        $0.addSubview(selectUnderLineView)
    }
    
    lazy var pageViewController = UIPageViewController(
        transitionStyle: .scroll,
        navigationOrientation: .horizontal)
    
    let segmentControl: UISegmentedControl = UISegmentedControl().then {
        $0.selectedSegmentTintColor = .clear
        $0.setBackgroundImage(UIImage(), for: .normal, barMetrics: .default)
        $0.setDividerImage(UIImage(), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
        $0.insertSegment(withTitle: "주변 새싹", at: 0, animated: true)
        $0.insertSegment(withTitle: "받은 요청", at: 1, animated: true)
        $0.selectedSegmentIndex = 0
        
        $0.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: Color.gray6,
            NSAttributedString.Key.font: SeSACFont.title4.font
        ], for: .normal)
        
        $0.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: Color.green,
            NSAttributedString.Key.font: SeSACFont.title3.font
        ], for: .selected)
        
    }
    
    lazy var selectUnderLineView: UIView = UIView().then {
        $0.backgroundColor = Color.green
    }
    
    private lazy var backgroundUnderLineView: UIView = UIView().then {
        $0.backgroundColor = Color.gray2
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureUI() {
        [containerView, pageViewController.view]
            .forEach { self.addSubview($0) }
    }
    
    override func setConstraints() {
        containerView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(self.safeAreaLayoutGuide)
            make.height.equalTo(44)
        }
        segmentControl.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        selectUnderLineView.snp.makeConstraints { make in
            make.leading.bottom.equalToSuperview()
            make.width.equalTo(self.snp.width).multipliedBy(0.5)
            make.height.equalTo(2)
        }
        backgroundUnderLineView.snp.makeConstraints { make in
            make.directionalHorizontalEdges.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
        pageViewController.view.snp.makeConstraints { make in
            make.top.equalTo(segmentControl.snp.bottom)
            make.bottom.directionalHorizontalEdges.equalToSuperview()
        }
        
    }
    
}
