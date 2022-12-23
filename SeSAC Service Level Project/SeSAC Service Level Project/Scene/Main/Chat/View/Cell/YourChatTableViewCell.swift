//
//  YourChatTableViewCell.swift
//  SeSAC Service Level Project
//
//  Created by 이명진 on 2022/12/09.
//

import UIKit

final class YourChatTableViewCell: BaseTableViewCell {
    
    let bubbleView: UIView = UIView().then {
        $0.makeCornerStyle(width: 1, color: Color.gray4.cgColor, radius: 8)
        $0.backgroundColor = .white
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
            make.leading.equalToSuperview().offset(16)
            make.width.lessThanOrEqualTo(264)
        }
        chatLabel.snp.makeConstraints { make in
            make.directionalVerticalEdges.equalToSuperview().inset(10)
            make.directionalHorizontalEdges.equalToSuperview().inset(16)
        }
        timeLabel.snp.makeConstraints { make in
            make.leading.equalTo(bubbleView.snp.trailing).offset(8)
            make.bottom.equalTo(bubbleView.snp.bottom)
        }
    }
}
