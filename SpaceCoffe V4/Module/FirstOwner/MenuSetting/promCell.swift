//
//  promCell.swift
//  SpaceCoffe V4
//
//  Created by Grigoriy Korotaev on 25.06.2023.
//

import UIKit

class promCell: UITableViewCell {
static let reuseId = "promoCell"
    var labelKey = UILabel()
    var labelValue = UILabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        addSubview(labelKey)
        addSubview(labelValue)
        
        createConstraints()
    }

    func createConstraints(){
        labelKey.snp.makeConstraints(){
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().inset(20)
        }
        labelValue.snp.makeConstraints(){
            $0.centerY.equalToSuperview()
            $0.left.equalTo(labelKey.snp.right).offset(50)
        }
    }
    
}
