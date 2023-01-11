//
//  ChatViewController.swift
//  SeSAC Service Level Project
//
//  Created by 이명진 on 2022/12/04.
//

import UIKit
import RxCocoa
import RxSwift
import RealmSwift

final class ChatViewController: BaseViewController {
    
    //MARK: - Properties
    
    private let mainView = ChatView()
    private let viewModel = ChatViewModel()
    
    private var disposeBag = DisposeBag()
    
    var chatArr: [Payload] = []
    var otherUserId: String = ""
    
    private var lastChatDate = ChatRepository.shared.fetchLastDateFilter()
    
    //MARK: - LifeCycle
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestMyQueueState()
        bind()
        NotificationCenter.default.addObserver(self, selector: #selector(getMessage(notification:)), name: NSNotification.Name("getMessage"), object: nil)
        print("==========🟢==========", chatArr, lastChatDate, otherUserId)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        SocketIOManager.shared.closeConnection()
    }
    
    deinit {
        print("해제됨")
    }
    
    //MARK: - OverrideMethod
    
    override func configureUI() {
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
    }
    
    override func setNavigation() {
        navigationController?.navigationBar.isHidden = false
        tabBarController?.tabBar.isHidden = true
        let leftBarButtonItem = UIBarButtonItem(image: Icon.arrow, style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem = leftBarButtonItem
        let rightBarButtonItem = UIBarButtonItem(image: Icon.more, style: .plain, target: self, action: #selector(moreButtonTapped))
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    //MARK: - CustomMethod
    
    private func bind() {
        
        mainView.textView.rx.didChange
            .withUnretained(self)
            .bind { vc, _ in
                vc.mainView.setupTextViewDidChange()
            }
            .disposed(by: disposeBag)
        
        mainView.textView.rx.didBeginEditing
            .withUnretained(self)
            .bind { vc, _ in
                vc.mainView.setupTextViewDidBeginEditing()
            }
            .disposed(by: disposeBag)
        
        mainView.textView.rx.didEndEditing
            .withUnretained(self)
            .bind { vc, _ in
                vc.mainView.setupTextViewDidEndEditing()
            }
            .disposed(by: disposeBag)
        
        mainView.textView.rx.text
            .orEmpty
            .withUnretained(self)
            .bind { vc, value in
                vc.mainView.setupSendButton(text: value)
            }
            .disposed(by: disposeBag)
        
        mainView.tapBackground.rx.event
            .withUnretained(self)
            .bind { vc, _ in
                vc.mainView.setupChatMoreView(false)
                vc.navigationItem.rightBarButtonItem?.isSelected.toggle()
            }
            .disposed(by: disposeBag)
        
        mainView.sendButton.rx.tap
            .throttle(.seconds(1), latest: false, scheduler: MainScheduler.asyncInstance)
            .withLatestFrom(mainView.textView.rx.text.orEmpty)
            .withUnretained(self)
            .bind { vc, value in
                if value.count > 0 {
                    vc.postChat(chat: value)
                } else {
                    vc.view.makeToast("한 글자 이상 작성", duration: 1, position: .center)
                }
            }
            .disposed(by: disposeBag)
        
        mainView.chatMoreView.cancelButton.rx.tap
            .withUnretained(self)
            .bind { vc, _ in
                vc.presentAlert()
            }
            .disposed(by: disposeBag)
        
        viewModel.studyDodgeStatus
            .withUnretained(self)
            .bind { vc, value in
                if value == 200 {
                    vc.navigationController?.popToRootViewController(animated: true)
                }
            }
            .disposed(by: disposeBag)
        
    }

    @objc private func backButtonTapped() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc private func moreButtonTapped(_ sender: UIButton) {
        sender.isSelected.toggle()
        mainView.setupChatMoreView(sender.isSelected)
    }
    
    @objc private func getMessage(notification: NSNotification) {
        let id = notification.userInfo!["id"] as! String
        let chat = notification.userInfo!["chat"] as! String
        let createdAt = notification.userInfo!["createdAt"] as! String
        let from = notification.userInfo!["from"] as! String
        let to = notification.userInfo!["to"] as! String
        
        let value = Payload(id: id, to: to, from: from, chat: chat, createdAt: createdAt)
        let savedChat = ChatDataModel(id: id, to: to, from: from, chat: chat, createdAt: createdAt.stringToDate())
        ChatRepository.shared.addChat(item: savedChat)
        
        self.chatArr.append(value)
        print("===============Get=========", chatArr)
        mainView.tableView.reloadData()
        mainView.tableView.scrollToRow(at: IndexPath(row: self.chatArr.count - 1, section: 0), at: .bottom, animated: false)
    }
    
    @objc private func keyboardWillAppear() {
        // 텍스트뷰 터치시에 테이블뷰 scrollToRow가 키보드 노티로밖에 안먹히는데 다른 방법이 있는지 모르겠다. 여러가지 해봤는데 다 안된다.
        if !chatArr.isEmpty {
            mainView.tableView.scrollToRow(at: IndexPath(row: self.chatArr.count - 1, section: 0), at: .bottom, animated: false)
        }
    }
    
    private func presentAlert() {
        let vc = CustomAlertViewController()
        vc.alertType = .studyCancel
        vc.doneButton.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
        transition(vc, transitionStyle: .alert)
    }
    
    @objc private func doneButtonTapped() {
        viewModel.requestStudyDodge(uid: otherUserId)
    }
}

extension ChatViewController {
    
    private func fetchChats(userId: String, lastChatDate: String) {
        chatArr = ChatRepository.shared.fetch(uid: userId)
        APIManager.shared.requestData(Chat.self,
                                      router: SeSACRouter.chat(userId: userId,
                                                               lastChatDate: lastChatDate)) { [weak self] response, statusCode in
            guard let statusCode = statusCode,
                  let self = self else { return }
            print("===============fetchChat", statusCode)
            
            switch response {
            case .success(let value):
                guard let value = value else { return }
                if !value.payload.isEmpty {
                    value.payload.forEach {
                        let chatData = Payload(id: $0.id, to: $0.to, from: $0.from, chat: $0.chat, createdAt: $0.createdAt)
                        let savedRealm = ChatDataModel(id: $0.id, to: $0.to, from: $0.from, chat: $0.chat, createdAt: $0.createdAt.stringToDate())
                        ChatRepository.shared.addChat(item: savedRealm)
                        self.chatArr.append(chatData)
                    }
                }
                // 테이블뷰 리로드
                if !self.chatArr.isEmpty {
                    self.mainView.tableView.reloadData()
                    self.mainView.tableView.scrollToRow(at: IndexPath(row: self.chatArr.count - 1, section: 0), at: .bottom, animated: false)
                }
                print("저장되지 않은 채팅 =================🟢", value)
                SocketIOManager.shared.establishConnection()
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
    }
    
    private func postChat(chat: String) {
        APIManager.shared.requestData(Payload.self,
                                      router: SeSACRouter.postChat(chat: chat,
                                                                   userId: otherUserId)) { [weak self] response, statusCode in
            guard let statusCode = statusCode,
                  let self = self else { return }
            print("=========PostChat", statusCode)
            switch response {
            case .success(let value):
                guard let value = value else { return }
                self.chatArr.append(value)
                let postChat = ChatDataModel(id: value.id, to: value.to, from: value.from, chat: value.chat, createdAt: value.createdAt.stringToDate())
                ChatRepository.shared.addChat(item: postChat)
                self.mainView.tableView.reloadData()
                self.mainView.tableView.scrollToRow(at: IndexPath(row: self.chatArr.count - 1, section: 0), at: .bottom, animated: false)
                self.mainView.textView.text = ""
                print("=============Post============", self.chatArr)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func requestMyQueueState() {
        APIManager.shared.requestData(MyQueueState.self,
                                      router: SeSACRouter.myQueueState) { [weak self] response, statusCode in
            print(response)
            guard let statusCode = statusCode,
                  let self = self else { return }
            print("=============status", statusCode)
            switch response {
            case .success(let value):
                guard let value = value else { return }
                self.otherUserId = value.matchedUid
                self.title = value.matchedNick
                print(value)
            case .failure(let error):
                print(error.rawValue)
                print(error.localizedDescription)
            }
            print("=================마지막 날짜다 임뫄", self.lastChatDate)
            self.fetchChats(userId: self.otherUserId, lastChatDate: self.lastChatDate?.dateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'") ?? "2000-01-01T00:00:00.000Z")
        }
    }
    
}

extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = chatArr[indexPath.row]
        
        if data.from == otherUserId {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: YourChatTableViewCell.reuseIdentifier, for: indexPath) as? YourChatTableViewCell else { return UITableViewCell() }
            cell.setupCell(data: data)
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MyChatTableViewCell.reuseIdentifier, for: indexPath) as? MyChatTableViewCell else { return UITableViewCell() }
            cell.setupCell(data: data)
            return cell
        }
    }
}


