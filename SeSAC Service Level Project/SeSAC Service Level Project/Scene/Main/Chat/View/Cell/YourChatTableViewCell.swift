//
//  YourChatTableViewCell.swift
//  SeSAC Service Level Project
//
//  Created by 이명진 on 2022/12/09.
//

import UIKit

final class YourChatTableViewCell: BaseTableViewCell {
    
    let chatLabel: UILabel = UILabel().then {
        $0.numberOfLines = 0
        $0.font = SeSACFont.body3.font
        $0.textColor = Color.black
    }
    
    let timeLabel: UILabel = UILabel().then {
        $0.font = SeSACFont.title6.font
        $0.textColor = Color.gray6
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
    }
    
    override func configureUI() {
        
    }
    
    override func setConstraints() {
        
    }
}
