//
//  OnboardViewController.swift
//  SeSAC Service Level Project
//
//  Created by 이명진 on 2022/11/07.
//

import UIKit

final class OnboardViewController: UIViewController {
    
    // MARK: - Properties
    
    private lazy var pageViewController: UIPageViewController = {
        let view = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        return view
    }()
    
    private let startButton: SeSACButton = {
        let view = SeSACButton()
        view.setupButton(title: "시작하기", titleColor: Color.white, font: SeSACFont.body3.font, backgroundColor: Color.green, borderWidth: 0, borderColor: .clear)
        return view
    }()
    
    private var pageViewControllerList: [UIViewController] = []
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setConstraints()
        createPageViewController()
        configurePageViewController()
        setupPageControl()
    }
    
    // MARK: - CustomMethod
    
    private func configureUI() {
        view.backgroundColor = .white
        self.navigationController?.isNavigationBarHidden = true
        [pageViewController.view, startButton].forEach { view.addSubview($0) }
        startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
    }
    
    private func setConstraints() {
        pageViewController.view.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(startButton.snp.top).offset(-42)
        }
        startButton.snp.makeConstraints { make in
            make.directionalHorizontalEdges.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().offset(-50)
            make.height.equalTo(48)
        }
    }
    
    private func createPageViewController() {
        let vc1 = FirstPageViewController()
        let vc2 = SecondPageViewController()
        let vc3 = ThirdPageViewController()
        pageViewControllerList = [vc1, vc2, vc3]
    }
    
    private func configurePageViewController() {
        pageViewController.delegate = self
        pageViewController.dataSource = self
        guard let first = pageViewControllerList.first else { return }
        pageViewController.setViewControllers([first], direction: .forward, animated: true)
    }
    
    private func setupPageControl() {
        let appear = UIPageControl.appearance()
        appear.numberOfPages = pageViewControllerList.count
        appear.pageIndicatorTintColor = Color.gray5
        appear.currentPageIndicatorTintColor = Color.black
    }
    
    // MARK: - ObjcMethod
    
    @objc private func startButtonTapped() {
        let userDefaults = UserDefaults.standard
        userDefaults.set(true, forKey: "firstRun")
        let vc = UINavigationController(rootViewController: AuthViewController())
        transition(vc, transitionStyle: .presentFull)
    }
    
}

// MARK: - Extension

extension OnboardViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pageViewControllerList.firstIndex(of: viewController) else { return nil }
        let previousIndex = viewControllerIndex - 1
        return previousIndex < 0 ? nil : pageViewControllerList[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pageViewControllerList.firstIndex(of: viewController) else { return nil }
        let nextIndex = viewControllerIndex + 1
        return nextIndex >= pageViewControllerList.count ? nil : pageViewControllerList[nextIndex]
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return pageViewControllerList.count
    }

    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        guard let first = pageViewController.viewControllers?.first,
              let index = pageViewControllerList.firstIndex(of: first) else { return 0 }
        return index
    }
    
}
