//
//  advCell.swift
//  SpaceCoffe V4
//
//  Created by Grigoriy Korotaev on 25.06.2023.
//

import UIKit
import SnapKit

class advCell: UITableViewCell {
    
    let advImageView = UIImageView()
    let labelNumber = UILabel()
    static let reuseId = "advCell"

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        setupView()
        createConstraints()
    }
    
    func setupView(){
        addSubview(advImageView)
        addSubview(labelNumber)
        
        advImageView.contentMode = .scaleAspectFit
        labelNumber.font = .systemFont(ofSize: 15)
        labelNumber.textAlignment = .right
    }
    func createConstraints(){
        advImageView.snp.makeConstraints(){
            $0.left.top.bottom.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.5)
        }
        labelNumber.snp.makeConstraints(){
            $0.centerX.equalToSuperview()
            $0.left.equalTo(advImageView.snp.right).offset(10)
            $0.right.equalToSuperview().inset(50)
            $0.height.equalTo(advImageView)
        }
    }

}
