//
//  SearchViewModel.swift
//  SeSAC Service Level Project
//
//  Created by 이명진 on 2022/11/14.
//

import Foundation
import RxSwift
import RxCocoa

final class SearchViewModel {
    
    var requestData = [
        SearchSection(header: "지금 주변에는", items: []),
        SearchSection(header: "내가 하고 싶은", items: [])
    ]
    
    var sectionRelay = BehaviorRelay(value: [SearchSection]())
    var statusRelay = PublishRelay<Int>()
    var fromRecommend: [String] = []
    
    struct Input {
        let searchButtonTap: ControlEvent<Void>
        let celltap: ControlEvent<IndexPath>
    }

    struct Output {
        let searchButtonTap: ControlEvent<Void>
        let celltap: ControlEvent<IndexPath>
    }

    func transform(input: Input) -> Output {
        
        return Output(searchButtonTap: input.searchButtonTap, celltap: input.celltap)
    }
    
    func requestSeSACSearch() {
        APIManager.shared.requestData(MyQueueStatus.self,
                                      router: SeSACRouter.queue(MyQueue(long: UserDefaults.standard.double(forKey: "long"),
                                                                        lat: UserDefaults.standard.double(forKey: "lat"),
                                                                        studylist: studyList()))) { [weak self] response, statusCode in
            guard let statusCode = statusCode,
                  let self = self else { return }
            print(statusCode)
            self.statusRelay.accept(statusCode)
        }
    }
    
    func requestStudy() {
        APIManager.shared.requestData(SearchResult.self,
                                      router: SeSACRouter
            .search(Search(lat: UserDefaults.standard.double(forKey: "lat"),
                           long: UserDefaults.standard.double(forKey: "long")))) { [weak self] response, statusCode in
            guard let self = self else { return }
            
            switch response {
            case .success(let value):
                guard let value = value else { return }
                var stringArr = [String]()
                stringArr.append(contentsOf: value.fromRecommend)
                value.fromQueueDB.forEach { $0.studylist.forEach { stringArr.append($0) } }
                value.fromQueueDBRequested.forEach { $0.studylist.forEach { stringArr.append($0) } }
                self.fromRecommend.append(contentsOf: value.fromRecommend)
                
                let removedArr = self.removeDuplicate(stringArr)
                removedArr.forEach { self.requestData[0].items.append(StudyList(study: $0)) }
                
                self.sectionRelay.accept(self.requestData)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func removeDuplicate(_ array: [String]) -> [String] {
        var removedArray = [String]()
        for i in array {
            if removedArray.contains(i) == false {
                removedArray.append(i)
            }
        }
        return removedArray
    }
    
    func studyList() -> [String] {
        var currentArr: [String] = []
        requestData[1].items.forEach { currentArr.append($0.study) }
        return currentArr.isEmpty ? ["anything"] : currentArr
    }
    
}
