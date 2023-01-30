//
//  ProfileUnregisterTableViewCell.swift
//  SeSAC Service Level Project
//
//  Created by 이명진 on 2022/11/15.
//

import UIKit
import RxSwift

final class ProfileUnregisterTableViewCell: BaseTableViewCell {
    
//    let unregisterLabel: UILabel = UILabel().then {
//        $0.text = "회원탈퇴"
//        $0.font = SeSACFont.title4.font
//    }
    var disposeBag = DisposeBag()
    
    let unregisterButton: UIButton = UIButton().then {
        $0.setTitleColor(.black, for: .normal)
        $0.setTitle("회원탈퇴", for: .normal)
        $0.titleLabel?.font = SeSACFont.title4.font
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    override func configureUI() {
        self.contentView.addSubview(unregisterButton)
    }
    
    override func setConstraints() {
        unregisterButton.snp.makeConstraints { make in
            make.top.leading.bottom.trailing.equalToSuperview().inset(16)
        }
    }
}
