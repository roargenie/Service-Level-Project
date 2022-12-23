//
//  HomeViewController.swift
//  SeSAC Service Level Project
//
//  Created by 이명진 on 2022/11/14.
//

import UIKit
import RxSwift
import RxCocoa
import FirebaseAuth
import CoreLocation
import MapKit

final class HomeViewController: BaseViewController {
    
    // MARK: - Properties
    
    private let mainView = HomeView()
    private let viewModel = HomeViewModel()
    
    private let locationManager = CLLocationManager()
    
    private var disposeBag = DisposeBag()
    
    private var fromQueueDB: [FromQueueDB] = []
    
    private var centerCoordinate: CLLocationCoordinate2D?
    
    // MARK: - LifeCycle
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        bind()
        setAnnotation()
        viewModel.requestMyQueueState()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        tabBarController?.tabBar.isHidden = false
        viewModel.requestMyQueueState()
    }
    
    // MARK: - OverrideMethod
    
    override func configureUI() {
        locationManager.delegate = self
        mainView.mapView.delegate = self
        checkUserDeviceLocationServiceAuthorization()
        mainView.userCurrentLocationButton.addTarget(self, action: #selector(findMyLocation), for: .touchUpInside)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // MARK: - CustomMethod
    
    private func bind() {
        
        let input = HomeViewModel.Input(searchButtonTap: mainView.searchButton.rx.tap,
                                        wholeGenderButtonTap: mainView.wholeGenderButton.rx.tap,
                                        maleGenderButtonTap: mainView.maleGenderButton.rx.tap,
                                        femaleGenderButtonTap: mainView.femaleGenderButton.rx.tap)
        let output = viewModel.transform(input: input)
        
        viewModel.wholeGenderButton
            .asDriver()
            .drive(onNext: { [weak self] value in
                let textColor = value ? Color.white : Color.black
                let bgColor = value ? Color.green : Color.white
                self?.mainView.wholeGenderButton.setupButton(title: "전체",
                                                             titleColor: textColor,
                                                             font: SeSACFont.title4.font,
                                                             backgroundColor: bgColor)
                
            })
            .disposed(by: disposeBag)
        
        output.wholeGenderButtonTap
            .withUnretained(self)
            .bind { (vc, _) in
                vc.viewModel.wholeGenderButton.accept(true)
                vc.viewModel.maleGenderButton.accept(false)
                vc.viewModel.femaleGenderButton.accept(false)
            }
            .disposed(by: disposeBag)
        
        viewModel.maleGenderButton
            .asDriver()
            .drive(onNext: { [weak self] value in
                let textColor = value ? Color.white : Color.black
                let bgColor = value ? Color.green : Color.white
                self?.mainView.maleGenderButton.setupButton(title: "남자",
                                                             titleColor: textColor,
                                                             font: SeSACFont.title4.font,
                                                             backgroundColor: bgColor)
                
            })
            .disposed(by: disposeBag)
        
        output.maleGenderButtonTap
            .withUnretained(self)
            .bind { (vc, _) in
                vc.viewModel.wholeGenderButton.accept(false)
                vc.viewModel.maleGenderButton.accept(true)
                vc.viewModel.femaleGenderButton.accept(false)
            }
            .disposed(by: disposeBag)
        
        viewModel.femaleGenderButton
            .asDriver()
            .drive(onNext: { [weak self] value in
                let textColor = value ? Color.white : Color.black
                let bgColor = value ? Color.green : Color.white
                self?.mainView.femaleGenderButton.setupButton(title: "여자",
                                                             titleColor: textColor,
                                                             font: SeSACFont.title4.font,
                                                             backgroundColor: bgColor)
                
            })
            .disposed(by: disposeBag)
        
        output.femaleGenderButtonTap
            .withUnretained(self)
            .bind { (vc, _) in
                vc.viewModel.wholeGenderButton.accept(false)
                vc.viewModel.maleGenderButton.accept(false)
                vc.viewModel.femaleGenderButton.accept(true)
            }
            .disposed(by: disposeBag)
        
        output.searchButtonTap
            .withLatestFrom(viewModel.searchButtonState)
            .withUnretained(self)
            .bind { (vc, value) in
                if value == 0 {
                    vc.transition(SearchResultViewController(), transitionStyle: .push)
                } else if value == 1 {
                    vc.transition(ChatViewController(), transitionStyle: .push)
                } else if value == 201 {
                    vc.transition(SearchViewController(), transitionStyle: .push)
                }
            }
            .disposed(by: disposeBag)
        
        viewModel.searchButtonState
            .withUnretained(self)
            .bind { vc, value in
                if value == 0 {
                    vc.mainView.searchButton.setImage(Icon.searchMatching, for: .normal)
                } else if value == 1 {
                    vc.mainView.searchButton.setImage(Icon.searchMatched, for: .normal)
                } else if value == 201 {
                    vc.mainView.searchButton.setImage(Icon.searchDefault, for: .normal)
                }
            }
            .disposed(by: disposeBag)
        
    }
    
    private func setAnnotation() {
        let center = CLLocationCoordinate2D(latitude: 37.517819364682694, longitude: 126.88647317074734)
        centerCoordinate = center
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        mainView.mapView.setRegion(region, animated: true)
        let annotation = MKPointAnnotation()
        annotation.coordinate = center
        annotation.title = "새싹 영등포 캠퍼스"
        mainView.mapView.addAnnotation(annotation)
        requestSearch(center: center)
    }
    
    private func setCustomAnnotation(_ fromQueueDB: [FromQueueDB]) {
        fromQueueDB.forEach { data in
            let center = CLLocationCoordinate2D(latitude: data.lat, longitude: data.long)
            let annotation = CustomAnnotation(sesacImage: data.sesac,
                                              coordinate: center)
            mainView.mapView.addAnnotation(annotation)
        }
    }
    
    private func requestSearch(center: CLLocationCoordinate2D) {
        APIManager.shared.requestData(SearchResult.self,
                                      router: SeSACRouter
            .search(Search(lat: center.latitude,
                           long: center.longitude))) { [weak self] response, statusCode in
            guard let self = self else { return }
            print(statusCode)
            switch response {
            case .success(let value):
                guard let value = value else { return }
//                self.fromQueueDB.append(contentsOf: value.fromQueueDB)
                self.setCustomAnnotation(value.fromQueueDB)
                self.setCustomAnnotation(value.fromQueueDBRequested)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    @objc private func findMyLocation() {
        guard locationManager.location != nil else {
            checkUserDeviceLocationServiceAuthorization()
            return
        }
        guard let coordinate = locationManager.location?.coordinate else { return }
        let center = CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        mainView.mapView.setRegion(region, animated: true)
//        mainView.mapView.showsUserLocation = true
        mainView.mapView.setUserTrackingMode(.follow, animated: true)
    }
    
}

extension HomeViewController {
    private func checkUserDeviceLocationServiceAuthorization() {
        let authorizationStatus: CLAuthorizationStatus
        
        if #available(iOS 14.0, *) {
            authorizationStatus = locationManager.authorizationStatus
        } else {
            authorizationStatus = CLLocationManager.authorizationStatus()
        }
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            if CLLocationManager.locationServicesEnabled() {
                self.checkUserCurrentLocationAuthorization(authorizationStatus)
            } else {
                print("위치서비스가 꺼져 있어 위치권한 요청을 할 수 없습니다.")
            }
        }
    }
    
    private func checkUserCurrentLocationAuthorization(_ authorizationStatus: CLAuthorizationStatus) {
        switch authorizationStatus {
        case .notDetermined:
            print("NOT DETERMINED")
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        case .restricted, .denied:
            print("DENIED, 아이폰 설정 유도")
            showRequestLocationServiceAlert()
        case .authorizedWhenInUse:
            print("WHEN IN USE, 앱을 사용하는 동안 허용")
            locationManager.startUpdatingLocation()
        default:
            print("DEFAULT")
        }
    }
    
    private func showRequestLocationServiceAlert() {
        let requestLocationServiceAlert = UIAlertController(title: "위치정보 이용", message: "위치 서비스를 사용할 수 없습니다. 기기의 '설정 > 개인정보 보호'에서 위치 서비스를 활성화 해주세요.", preferredStyle: .alert)
        let goSetting = UIAlertAction(title: "설정으로 이동", style: .destructive) { _ in
            if let appSetting = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(appSetting)
            }
        }
        let cancel = UIAlertAction(title: "취소", style: .default)
        requestLocationServiceAlert.addAction(cancel)
        requestLocationServiceAlert.addAction(goSetting)
        
        present(requestLocationServiceAlert, animated: true, completion: nil)
    }
}

extension HomeViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let center = locations.last?.coordinate as? CLLocationCoordinate2D {
            //print(center.latitude, center.longitude)
            // 서버통신 해야할듯?
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(#function, error)
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print(#function)
        checkUserDeviceLocationServiceAuthorization()
    }
}

extension HomeViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let center = mainView.mapView.centerCoordinate
        centerCoordinate = center
        UserDefaults.standard.set(center.longitude, forKey: "long")
        UserDefaults.standard.set(center.latitude, forKey: "lat")
//        print(center.latitude, center.longitude)
        // 여기서도 서버통신 해야할듯?
        requestSearch(center: center)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? CustomAnnotation else {
            return nil
        }
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: CustomAnnotationView.identifier)
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: CustomAnnotationView.identifier)
            annotationView?.canShowCallout = false
            annotationView?.contentMode = .scaleAspectFit
        } else {
            annotationView?.annotation = annotation
        }
        
        let sesacImage: UIImage!
        let size = CGSize(width: 85, height: 85)
        UIGraphicsBeginImageContext(size)
        
        switch annotation.sesacImage {
        case 0:
            sesacImage = Icon.sesacface0
        case 1:
            sesacImage = Icon.sesacface1
        case 2:
            sesacImage = Icon.sesacface2
        case 3:
            sesacImage = Icon.sesacface3
        case 4:
            sesacImage = Icon.sesacface4
        default:
            sesacImage = Icon.sesacface0
        }
        
        sesacImage.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        annotationView?.image = resizedImage
        
        return annotationView
    }
}
