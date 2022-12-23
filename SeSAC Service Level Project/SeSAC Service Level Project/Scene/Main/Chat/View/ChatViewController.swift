//
//  ChatViewController.swift
//  SeSAC Service Level Project
//
//  Created by 이명진 on 2022/12/04.
//

import UIKit
import RxCocoa
import RxSwift

final class ChatViewController: BaseViewController {
    
    //MARK: - Properties
    
    private var mainView = ChatView()
    private let viewModel = ChatViewModel()
    
    private var disposeBag = DisposeBag()
    
    var chat: [Payload] = []
    var otherUserId: String = ""
    
    //MARK: - LifeCycle

    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestMyQueueState()
//        fetchChats(userId: otherUserId, lastChatDate: "2000-01-01T00:00:00.000Z")
        bind()
        NotificationCenter.default.addObserver(self, selector: #selector(getMessage(notification:)), name: NSNotification.Name("getMessage"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
    }
    
    //MARK: - OverrideMethod
    
    override func configureUI() {
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
    }
    
    override func setConstraints() {
        
    }
    
    override func setNavigation() {
//        title = "누구야"
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
                vc.mainView.tableView.reloadData()
                vc.mainView.tableView.scrollToRow(at: IndexPath(row: vc.chat.count - 1, section: 0), at: .bottom, animated: false)
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
            .withLatestFrom(mainView.textView.rx.text.orEmpty)
            .withUnretained(self)
            .bind { vc, value in
                vc.postChat(chat: value)
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
        
        self.chat.append(value)
        mainView.tableView.reloadData()
        mainView.tableView.scrollToRow(at: IndexPath(row: self.chat.count - 1, section: 0), at: .bottom, animated: false)
    }
}

extension ChatViewController {
    
    private func fetchChats(userId: String, lastChatDate: String) {
        APIManager.shared.requestData(Chat.self,
                                      router: SeSACRouter.chat(userId: userId,
                                                               lastChatDate: lastChatDate)) { [weak self] response, statusCode in
            guard let statusCode = statusCode,
                  let self = self else { return }
            print("===============fetchChat", statusCode)
            switch response {
            case .success(let value):
                guard let value = value else { return }
                self.chat = value.payload
                // 테이블뷰 리로드
                self.mainView.tableView.reloadData()
                self.mainView.tableView.scrollToRow(at: IndexPath(row: self.chat.count - 1, section: 0), at: .bottom, animated: false)
                print(value)
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
                self.chat.append(value)
                self.mainView.tableView.reloadData()
                self.mainView.tableView.scrollToRow(at: IndexPath(row: self.chat.count - 1, section: 0), at: .bottom, animated: false)
                self.mainView.textView.text = ""
                print(value)
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
            self.fetchChats(userId: self.otherUserId, lastChatDate: "2000-01-01T00:00:00.000Z")
        }
    }
    
}

extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chat.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = chat[indexPath.row]
        
        if data.from == otherUserId {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: YourChatTableViewCell.reuseIdentifier, for: indexPath) as? YourChatTableViewCell else { return UITableViewCell() }
            cell.chatLabel.text = data.chat
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MyChatTableViewCell.reuseIdentifier, for: indexPath) as? MyChatTableViewCell else { return UITableViewCell() }
            cell.chatLabel.text = data.chat
            return cell
        }
    }
    
}
