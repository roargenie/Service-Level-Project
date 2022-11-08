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
        view.view.addSubview(pageControl)
        return view
    }()
    
    private let pageControl: UIPageControl = {
        let view = UIPageControl()
        view.backgroundColor = .green
        view.numberOfPages = 3
//        view.currentPage = 0
        view.pageIndicatorTintColor = Color.gray5
        view.currentPageIndicatorTintColor = Color.black
        return view
    }()
    
    private let startButton: SeSACButton = {
        let view = SeSACButton()
        view.setupButton(title: "시작하기", titleColor: Color.white, font: SeSACFont.body3.font, backgroundColor: Color.green, borderWidth: 0, borderColor: .clear)
        let userDefaults = UserDefaults.standard
        userDefaults.set(true, forKey: "firstRun")
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
    }
    
    // MARK: - CustomMethod
    
    private func configureUI() {
        view.backgroundColor = .white
        self.navigationController?.isNavigationBarHidden = true
//        addChild(pageViewController)
        [pageViewController.view, startButton].forEach { view.addSubview($0) }
        startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
    }
    
    private func setConstraints() {
        pageViewController.view.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(startButton.snp.top)
        }
        pageControl.snp.makeConstraints { make in
            make.bottom.equalTo(startButton.snp.top).offset(-42)
            make.height.equalTo(8)
            make.width.equalTo(48)
            make.centerX.equalToSuperview()
        }
        startButton.snp.makeConstraints { make in
            make.directionalHorizontalEdges.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().offset(-50)
            make.height.equalTo(48)
        }
//        pageViewController.didMove(toParent: self)
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
    
    // MARK: - ObjcMethod
    
    @objc private func startButtonTapped() {
        let vc = UINavigationController(rootViewController: AuthViewController())
        transition(vc, transitionStyle: .presentFull)
    }
    
}

// MARK: - Extension

extension OnboardViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        // 현재 페이지뷰 컨트롤러에 보이는 뷰컨의 인덱스 가져오기
        guard let viewControllerIndex = pageViewControllerList.firstIndex(of: viewController) else { return nil }
        let previousIndex = viewControllerIndex - 1
        return previousIndex < 0 ? nil : pageViewControllerList[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pageViewControllerList.firstIndex(of: viewController) else { return nil }
        let nextIndex = viewControllerIndex + 1
        return nextIndex >= pageViewControllerList.count ? nil : pageViewControllerList[nextIndex]
    }
    
//    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
//        return 0
//    }
//
//    func presentationCount(for pageViewController: UIPageViewController) -> Int {
//        return 3
//    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
//        guard
//            let first = pageViewController.viewControllers?.first,
//            let index = pageViewControllerList.firstIndex(of: first) else {
//            print(index)
//            return
//        }
//        print(#function)
        if let viewControllers = pageViewController.viewControllers {
            if let viewControllerIndex = pageViewControllerList.firstIndex(of: viewControllers[0]) {
                pageControl.currentPage = viewControllerIndex
                print(viewControllerIndex)
            }
        }
//        pageControl.currentPage = 0
    }
    
}
