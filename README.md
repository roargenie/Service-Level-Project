# SeSAC Study
<img src="https://user-images.githubusercontent.com/105975078/215261373-7ea832bd-a596-4301-ba1e-74ad7e9839e7.jpeg" width=20%><img src="https://user-images.githubusercontent.com/105975078/215261379-9b63abf9-a18f-4719-9a46-6ef039ea620e.jpeg" width=20%><img src="https://user-images.githubusercontent.com/105975078/215261389-78046b23-49d4-4c91-84e2-e35c6e06658c.jpeg" width=20%><img src="https://user-images.githubusercontent.com/105975078/215261401-6bf2fe85-288e-4eca-8128-abfe7c2b7512.jpeg" width=20%><img src="https://user-images.githubusercontent.com/105975078/215261411-c80c3cce-5dc0-476b-a612-36a8fb33fbf9.jpeg" width=20%>

### 앱 소개
- 개발기간 : 2022.11.07 ~ 2022.12.07(1개월)
- 1인 개발
- 위치 기반 스터디 매칭 서비스
- Figma, Swagger, Confluence, Notion 사용

### 주요 기능
- 휴대폰 번호로 인증 로그인 / 회원탈퇴
- 위치기반 서비스를 이용한 주변 친구 탐색
- 채팅 요청 / 수락
- 1:1 채팅

### 기술 스택
- `MVVM` `RxSwift` `RxDataSource` `Compositional Layout` `CodeBaseUI` `SocketIO` `RealmSwift` `Mapkit` 
`CoreLocation` `FirebaseAuth` `Then` `Snapkit` `Alamofire` `MultiSlider`

### 기술 설명
- `FirebaseAuth`를 이용하여 휴대폰 인증 로그인 구현 및 정규식을 활용한 유효성 검증
- `Compositional Layout`과 `RxDataSource`를 사용하여 자연스러운 애니메이션 효과를 주어 사용자에게 더 나은 경험을 제공
- API가 추가 및 변경이 되더라도 유지보수에 편리하도록 `Alamofire`와 `URLRequestConvertible`을 사용하여 `Router`모듈화
- `Firebase Token Manager`를 따로 관리하여 Token만료시 갱신되도록 효율적인 설계
- `Socket IO`를 사용하여 실시간 1:1 채팅 구현 및 `Realm`을 사용하여 과도한 서버 호출 방지
- `CoreLocation`과 `Mapkit`을 사용하여 주변 스터디 친구를 나타낼 때 `Custom Annotation`으로 이미지 표시
- 효율적인 개발을 위해 재사용 뷰 적극 활용 및 디자인 시스템 도입 `Typo System` `Custom Alert` `Custom Button`등

### 트러블 슈팅
[개발일지 보러가기](https://military-dugout-02f.notion.site/Service-Level-Project-6071732e2d3a42ed921e9d1661c510d5)
- 스터디 검색뷰 왼쪽 정렬 레이아웃 이슈
  - 글자수에 따라 셀의 너비가 유동적으로 변동되게 하는 방법에서 많은 고민을 하였는데, 셀에 버튼을 넣고 Compositional Layout을 잡을때 estimated 사이즈를 주어 해결.
  ```swift
    static func fixedSpacedFlowLayout() -> UICollectionViewLayout {
        
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .estimated(100),
            heightDimension: .absolute(32)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(150)
        )
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = NSCollectionLayoutSpacing.fixed(8)
        
        let sectionHeaderPadding: CGFloat = 32
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 8
        section.contentInsets = NSDirectionalEdgeInsets(
            top: 16 + sectionHeaderPadding,
            leading: 16,
            bottom: 8,
            trailing: 16)
        
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(32)),
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .topLeading, absoluteOffset: CGPoint(x: 0, y: sectionHeaderPadding))
        
        section.boundarySupplementaryItems = [header]
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
  ```
- 스터디 검색뷰 중복값 이슈
  - AnimatedDataSource를 쓸때 Hashable한 부분에서 문제가 생겨서 계속 런타임 에러가 발생. (Diffable과 동일) RxDataSource 섹션 모델을 만들때 IdentifiableType과 Equatable을 채택하여 데이터 각자의 고유의 identity를 가지도록 하여 문제 해결.
  ```swift
  struct StudyList: Hashable {
      let study: String
    
      init(study: String) {
         self.study = study
     }
  }

  extension StudyList: IdentifiableType, Equatable {
     var identity: String {
         return UUID().uuidString
     }
  }
  ```
- 새싹 찾기뷰 셀 재사용 이슈
  - 더 보기 뷰를 펼칠때 셀 재사용 문제가 생겨서 원하는 셀이 열리고 닫히지 않는 문제가 발생.
생성되는 셀 갯수만큼 배열에 Bool값을 넣어서 각각의 셀이 true, false 상태를 가질 수 있도록 하여 문제 해결.

  ```swift
  viewModel.nearSeSAC
      .withUnretained(self)
      .bind { vc, value in
          vc.mainView.setupEmptyStateView(value: value)
          vc.isSelected = Array<Bool>(repeating: false, count: value.count)
      }
      .disposed(by: disposeBag)

  viewModel.nearSeSAC
      .asDriver()
      .drive(mainView.tableView.rx.items) { [weak self] (tv, row, item) -> UITableViewCell in
          guard let cell = tv.dequeueReusableCell(withIdentifier: ProfileNickNameTableViewCell.reuseIdentifier, for: IndexPath.init(row: row, section: 0)) as? ProfileNickNameTableViewCell else { return UITableViewCell() }
          cell.firstLineView.moreButton.addTarget(self, action: #selector(self?.moreButtonTapped), for: .touchUpInside)
          cell.firstLineView.moreButton.tag = row
          cell.setupCellData(data: item, buttonType: .request)
          cell.requestButton.rx.tap
              .bind { _ in
                  self?.presentAlert()
                  self?.uid = item.uid
                  print(item.uid)
              }
              .disposed(by: cell.disposeBag)
          if self?.isSelected[row] == true {
              cell.setupExpendedCell(hidden: false, image: Icon.uparrow)
          } else {
              cell.setupExpendedCell(hidden: true, image: Icon.downarrow)
          }
          return cell
      }
      .disposed(by: disposeBag)
  ```
- 채팅UI 이슈
  - 채팅 입력 TextView 세줄 제한시 TextView가 현재 몇 줄 인지 계산하여 높이를 제한하였는데,
글자를 지우면서 TableView와의 레이아웃이 깨지는 현상이 발생.
lessThan, greaterThan을 모두 설정하여 문제 해결.

  ```swift
  func setupTextViewDidChange() {
      if textView.numberOfLine() > 3 {
          textView.snp.remakeConstraints { make in
              make.directionalHorizontalEdges.equalToSuperview().inset(16)
              make.bottom.equalTo(self.keyboardLayoutGuide.snp.top).offset(-16)
              make.height.equalTo(90)
          }
          textView.isScrollEnabled = true
      } else {
          textView.snp.remakeConstraints { make in
              make.directionalHorizontalEdges.equalToSuperview().inset(16)
              make.bottom.equalTo(self.keyboardLayoutGuide.snp.top).offset(-16)
              make.height.lessThanOrEqualTo(90)
              make.height.greaterThanOrEqualTo(52)
          }
          textView.isScrollEnabled = false
      }
  }
  ```

### 회고
- 잘한 점
  - Rx와 MVVM이 익숙하지 않은 상태로 큰 프로젝트에 적용시키면서 하느라 처음에는 조금 고생을 많이 했지만, 많은 시행착오 끝에 나름 View와 ViewModel을 분리하게 되었다.
  - 뷰를 만드는것에 대한 스트레스가 굉장히 컸는데, 이번에 여러가지 어려워 보이는 뷰들을 만들어 보면서 이제 뷰를 만드는것에 대한 걱정들이 많이 해소되었다.
  - 여러 작은 옵션적인 기능들은 제외하고 큰 기능들에 초점을 두고 새로운 기술들을 많이 적용시켜 보려고 했고, 결과적으로 의도에 맞게 새로운 기술들을 많이 배우게 되었다.
  
- 잘못한 점
  - 코드를 모두 이해하면서 짜려고 하는 습관때문에 동작 구조들을 이해하는데에 시간을 너무 많이 쏟았고, 결과적으로 시간이 부족해서 코드적인 고민을 많이 해보지 못했다.
  - 이번에 Commit을 습관화 하고, issue를 통해 Github를 관리해 보려고 했지만 실패했다.
  - 채팅 구현에서 Realm과 Socket, Server등 동작 구조가 이해가 되지 않아서 너무 많은 시간을 버렸다. 그냥 해보면서 몸으로 터득했으면 훨씬 시간을 절약할 수 있었을 것 같다.



















