//
//  HomeView.swift
//  SeSAC Service Level Project
//
//  Created by 이명진 on 2022/11/14.
//

import UIKit
import MapKit

final class HomeView: BaseView {
    
    let mapView: MKMapView = MKMapView().then {
        $0.register(CustomAnnotationView.self, forAnnotationViewWithReuseIdentifier: CustomAnnotationView.identifier)
    }
    
    let wholeGenderButton: SeSACButton = SeSACButton().then {
        $0.setupButton(title: "전체",
                       titleColor: Color.black,
                       font: SeSACFont.title3.font,
                       backgroundColor: Color.white)
        $0.layer.cornerRadius = 8
        $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        $0.layer.masksToBounds = true
    }
    
    let maleGenderButton: SeSACButton = SeSACButton().then {
        $0.setupButton(title: "남자",
                       titleColor: Color.black,
                       font: SeSACFont.title3.font,
                       backgroundColor: Color.white)
    }
    
    let femaleGenderButton: SeSACButton = SeSACButton().then {
        $0.setupButton(title: "여자",
                       titleColor: Color.black,
                       font: SeSACFont.title3.font,
                       backgroundColor: Color.white)
        $0.layer.cornerRadius = 8
        $0.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        $0.layer.masksToBounds = true
    }
    
    lazy var genderSelectStackView: UIStackView = UIStackView(
        arrangedSubviews: [wholeGenderButton, maleGenderButton, femaleGenderButton]).then {
            $0.axis = .vertical
            $0.distribution = .fillEqually
            $0.layer.shadowOffset = CGSize(width: 3, height: 3)
            $0.layer.shadowOpacity = 0.25
            $0.layer.masksToBounds = false
    }
    
    let userCurrentLocationButton: UIButton = UIButton().then {
        $0.setImage(Icon.place, for: .normal)
        $0.backgroundColor = Color.white
        $0.layer.cornerRadius = 8
        $0.clipsToBounds = true
        $0.layer.shadowOffset = CGSize(width: 3, height: 3)
        $0.layer.shadowOpacity = 0.25
        $0.layer.masksToBounds = false
    }
    
    let searchButton: UIButton = UIButton().then {
        $0.setImage(Icon.searchDefault, for: .normal)
        $0.layer.shadowOffset = CGSize(width: 3, height: 3)
        $0.layer.shadowOpacity = 0.25
        $0.layer.masksToBounds = false
    }
    
    let currentCenterPinImageView: UIImageView = UIImageView().then {
        $0.image = Icon.mapMarker
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureUI() {
        [mapView, genderSelectStackView, userCurrentLocationButton, searchButton, currentCenterPinImageView].forEach { self.addSubview($0) }
    }
    
    override func setConstraints() {
        mapView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        genderSelectStackView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(8)
            make.leading.equalToSuperview().offset(16)
            make.width.equalTo(48)
            make.height.equalTo(144)
        }
        userCurrentLocationButton.snp.makeConstraints { make in
            make.top.equalTo(genderSelectStackView.snp.bottom).offset(16)
            make.leading.equalTo(genderSelectStackView.snp.leading)
            make.width.height.equalTo(48)
        }
        searchButton.snp.makeConstraints { make in
            make.bottom.trailing.equalTo(self.safeAreaLayoutGuide).inset(16)
            make.width.height.equalTo(64)
        }
        currentCenterPinImageView.snp.makeConstraints { make in
            make.center.equalTo(mapView.snp.center)
            make.width.height.equalTo(48)
        }
    }
    
}
