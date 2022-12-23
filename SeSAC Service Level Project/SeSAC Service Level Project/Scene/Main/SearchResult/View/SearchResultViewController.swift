//
//  SearchResultViewController.swift
//  SeSAC Service Level Project
//
//  Created by 이명진 on 2022/11/21.
//

import UIKit
import RxCocoa
import RxSwift
import CoreLocation

final class SearchResultViewController: BaseViewController {
    
    //MARK: - Properties

    private let mainView = SearchResultView()
    private let viewModel = SearchResultViewModel()
    
    private var disposeBag = DisposeBag()
    
    private let nearSeSACViewController = NearSeSACViewController()
    private let requestSeSACViewController = RequestSeSACViewController()
    
    var centerCoordinate: CLLocationCoordinate2D?
    
    var pageViewControllerList: [UIViewController] {
            [nearSeSACViewController, requestSeSACViewController]
        }
    
    lazy var currentPage: Int = 0 {
        didSet {
            let direction: UIPageViewController.NavigationDirection = oldValue <= self.currentPage ? .forward : .reverse
            self.mainView.pageViewController.setViewControllers([pageViewControllerList[self.currentPage]],
                                                       direction: direction,
                                                       animated: true)
        }
    }
    
    //MARK: - LifeCycle
    
    override func loadView() {
        view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    //MARK: - OverrideMethod
    
    override func setNavigation() {
        title = "새싹 찾기"
        let leftBarButtonItem = UIBarButtonItem(image: Icon.arrow, style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem = leftBarButtonItem
        let rightBarButtonItem = UIBarButtonItem(title: "찾기중단", style: .plain, target: self, action: #selector(stopSearchButtonTapped))
        navigationItem.rightBarButtonItem = rightBarButtonItem
        navigationItem.rightBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.font: SeSACFont.title3.font], for: .normal)
    }
    
    override func configureUI() {
        navigationController?.navigationBar.isHidden = false
        tabBarController?.tabBar.isHidden = true
        mainView.segmentControl.addTarget(self, action: #selector(changePage), for: .valueChanged)
        addChild(mainView.pageViewController)
        changePage(mainView.segmentControl)
    }
    
    override func setConstraints() {
        
    }
    
    //MARK: - CustomMethod
    
    private func bind() {
        
        
        
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func stopSearchButtonTapped() {
        APIManager.shared.requestData(Int.self,
                                      router: SeSACRouter.queueStop) { [weak self] response, statusCode in
            guard let statusCode = statusCode,
                  let self = self else { return }
            
            switch statusCode {
            case 200:
                print(statusCode)
                self.navigationController?.popToRootViewController(animated: true)
            case 201:
                self.view.makeToast("스터디를 함께하기로 하신 약속이 있어요!", duration: 1, position: .center)
            default:
                break
            }
        }
    }
    
    deinit {
        print("해제 됨")
    }
    
    @objc private func changeUnderLinePosition() {
        let segmentIndex = CGFloat(mainView.segmentControl.selectedSegmentIndex)
        let segmentWidth = mainView.segmentControl.frame.width / CGFloat(mainView.segmentControl.numberOfSegments)
        let leadingDistance = segmentWidth * segmentIndex
        UIView.animate(withDuration: 0.2, animations: { [weak self] in
            self?.mainView.selectUnderLineView.transform = CGAffineTransform(translationX: leadingDistance, y: 0)
        })
    }
    
    @objc private func changePage(_ sender: UISegmentedControl) {
        currentPage = sender.selectedSegmentIndex
        changeUnderLinePosition()
    }
}
