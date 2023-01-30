//
//  ProfileViewController.swift
//  SeSAC Service Level Project
//
//  Created by 이명진 on 2022/11/14.
//

import UIKit
import RxSwift
import RxCocoa
import FirebaseAuth
import Toast

final class MyProfileSettingViewController: BaseViewController {
    
    // MARK: - Properties
    
    private let mainView = MyProfileSettingView()
    private let viewModel = MyProfileSettingViewModel()
    
    private var disposeBag = DisposeBag()
    
    private var isSelected: Bool = false {
        didSet {
            mainView.tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .fade)
        }
    }
    
    // MARK: - LifeCycle
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        viewModel.requestMyProfile()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    // MARK: - OverrideMethod
    
    override func configureUI() {
        title = "정보 관리"
    }
    
    override func setNavigation() {
        let leftBarButtonItem = UIBarButtonItem(image: Icon.arrow, style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem = leftBarButtonItem
        let rightBarButtonItem = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveButtonTapped))
        navigationItem.rightBarButtonItem = rightBarButtonItem
        navigationItem.rightBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.font: SeSACFont.title3.font], for: .normal)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // MARK: - CustomMethod
    
    private func bind() {
        let input = MyProfileSettingViewModel.Input()
        let output = viewModel.transform(input: input)
        
        viewModel.myProfileSetting
            .observe(on: MainScheduler.instance)
            .bind(to: mainView.tableView.rx.items) { [weak self] (tv, row, item) -> UITableViewCell in
                if row == 0 {
                    guard let cell = tv.dequeueReusableCell(withIdentifier: ProfileNickNameTableViewCell.reuseIdentifier, for: IndexPath.init(row: row, section: 0)) as? ProfileNickNameTableViewCell else { return UITableViewCell() }
                    
                    cell.profileImageView.image = UIImage(named: "sesac_face_\(item.sesac)")
                    cell.firstLineView.nicknameLabel.text = item.nick
                    cell.firstLineView.moreButton.addTarget(self, action: #selector(self?.moreButtonTapped), for: .touchUpInside)
                    cell.thirdLineView.sesacReviewLabel.text = item.comment.isEmpty ? "첫 리뷰를 기다리는 중이에요!" : item.comment.joined(separator: "\n")
                    if self?.isSelected == true {
                        cell.secondLineView.isHidden = false
                        cell.thirdLineView.isHidden = false
                        cell.firstLineView.moreButton.setImage(Icon.uparrow, for: .normal)
                    } else {
                        cell.secondLineView.isHidden = true
                        cell.thirdLineView.isHidden = true
                        cell.firstLineView.moreButton.setImage(Icon.downarrow, for: .normal)
                    }
                    return cell
                } else if row == 1 {
                    guard let cell = tv.dequeueReusableCell(withIdentifier: ProfileReviewTableViewCell.reuseIdentifier, for: IndexPath.init(row: row, section: 0)) as? ProfileReviewTableViewCell else { return UITableViewCell() }
                    cell.ageSlider.value = [CGFloat(item.ageMin), CGFloat(item.ageMax)]
                    cell.studyTextField.text = item.study
                    cell.phoneNumberSearchAllowSwitch.isOn = item.searchable == 1 ? true : false
                    if item.gender == 0 {
                        cell.femaleButton.setupButton(title: "여자",
                                                      titleColor: Color.white,
                                                      font: SeSACFont.body3.font,
                                                      backgroundColor: Color.green,
                                                      borderWidth: 0,
                                                      borderColor: .clear)
                    } else {
                        cell.maleButton.setupButton(title: "남자",
                                                    titleColor: Color.white,
                                                    font: SeSACFont.body3.font,
                                                    backgroundColor: Color.green,
                                                    borderWidth: 0,
                                                    borderColor: .clear)
                    }
                    return cell
                } else {
                    guard let cell = tv.dequeueReusableCell(withIdentifier: ProfileUnregisterTableViewCell.reuseIdentifier, for: IndexPath.init(row: row, section: 0)) as? ProfileUnregisterTableViewCell else { return UITableViewCell() }
                    cell.unregisterButton.rx.tap
                        .bind { _ in
                            self?.presentAlert()
                        }
                        .disposed(by: cell.disposeBag)
                    return cell
                }
            }
            .disposed(by: disposeBag)
          
        viewModel.withdrawResponse
            .withUnretained(self)
            .bind { vc, value in
                if value == 200 {
                    vc.transition(OnboardViewController(), transitionStyle: .changeRootVC)
                }
            }
            .disposed(by: disposeBag)
        
    }
    
    private func presentAlert() {
        let vc = CustomAlertViewController()
        vc.alertType = .withdraw
        vc.doneButton.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
        transition(vc, transitionStyle: .alert)
    }
    
    @objc private func doneButtonTapped() {
        viewModel.requestWithdraw()
    }
    
    @objc private func moreButtonTapped() {
        isSelected = !isSelected
    }
    
    @objc private func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func saveButtonTapped() {
        requestSaveProfile()
    }
    
    private func requestSaveProfile() {
        APIManager.shared.requestData(MyPageStatus.self,
                                      router: SeSACRouter.myPage(MyPage(searchable: 1,
                                                                        ageMin: 20,
                                                                        ageMax: 45,
                                                                        gender: 1,
                                                                        study: "알고리듬"))) { [weak self] response, statusCode in
            
            guard let self = self else { return }
            guard let statusCode = statusCode else { return }
            print(statusCode)
            switch statusCode {
            case 200:
                self.view.makeToast("성공적으로 저장 되었습니다.", duration: 1, position: .center)
//                self.viewModel.requestMyProfile()
            case 401:
//                self.refreshIdToken()
                print(statusCode)
            case 500:
                self.view.makeToast("서버오류. 잠시뒤에 다시 시도해주세요.", duration: 1, position: .center)
            case 501:
                self.view.makeToast("입력해야하는 정보가 모자랍니다. 다시 확인해주세요.", duration: 1, position: .center)
            default:
                break
            }
        }
    }
}

