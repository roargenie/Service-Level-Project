//
//  ChatTableViewCell.swift
//  SeSAC Service Level Project
//
//  Created by 이명진 on 2022/12/04.
//

import UIKit

final class MyChatTableViewCell: BaseTableViewCell {
    
    let bubbleView: UIView = UIView().then {
        $0.makeCornerStyle(width: 0, radius: 8)
        $0.backgroundColor = Color.whitegreen
    }
    
    let chatLabel: UILabel = UILabel().then {
        $0.numberOfLines = 0
        $0.font = SeSACFont.body3.font
        $0.textColor = Color.black
    }
    
    let timeLabel: UILabel = UILabel().then {
        $0.text = "12:00"
        $0.font = SeSACFont.title6.font
        $0.textColor = Color.gray6
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
    }
    
    override func configureUI() {
        [bubbleView, timeLabel].forEach { self.addSubview($0) }
        bubbleView.addSubview(chatLabel)
    }
    
    override func setConstraints() {
        bubbleView.snp.makeConstraints { make in
            make.directionalVerticalEdges.equalToSuperview().inset(12)
            make.trailing.equalToSuperview().offset(-16)
            make.width.lessThanOrEqualTo(264)
        }
        chatLabel.snp.makeConstraints { make in
            make.directionalVerticalEdges.equalToSuperview().inset(10)
            make.directionalHorizontalEdges.equalToSuperview().inset(16)
        }
        timeLabel.snp.makeConstraints { make in
            make.trailing.equalTo(bubbleView.snp.leading).offset(-8)
            make.bottom.equalTo(bubbleView.snp.bottom)
        }
    }
    
    func setupCell(data: Payload) {
        chatLabel.text = data.chat
        setTimeLabel(time: data.createdAt)
    }
    
    func setTimeLabel(time: String) {
        let date = time.stringToDate()
        let calculatedDate = Calendar.current.date(byAdding: .hour, value: 9, to: date) ?? date
        
        let chattingDate = Calendar.current.dateComponents([.year, .month, .day], from: calculatedDate)
        let todayDate = Calendar.current.dateComponents([.year, .month, .day], from: Date())
        
        if (chattingDate.year == todayDate.year) && (chattingDate.month == todayDate.month) && (chattingDate.day == todayDate.day) {
            timeLabel.text = calculatedDate.todayChat()
        } else {
            timeLabel.text = calculatedDate.notTodayChat()
        }
    }
}
