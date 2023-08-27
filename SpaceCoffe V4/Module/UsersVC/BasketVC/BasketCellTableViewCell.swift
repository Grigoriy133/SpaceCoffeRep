//
//  BasketCellTableViewCell.swift
//  SpaceCoffe V4
//
//  Created by Grigoriy Korotaev on 10.06.2023.
//

import UIKit
import SnapKit

class BasketCellTableViewCell: UITableViewCell {

    var productImage = UIImageView()
    var nameLabel = UILabel()
    var priceLabel = UILabel()
    var capacityLabel = UILabel()
    var buttonPlus = UIButton()
    var buttonMinus = UIButton()
    
    var buttonMinusFunc:(()->())?
    var buttonPlusFunc:(()->())?
    
    static let reuseId = "basketCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        setupViews()
        configurateViews()
        createConstraints()
    }
    
//MARK: - UIView
    
    func setupViews(){
        addSubview(productImage)
        addSubview(nameLabel)
        addSubview(priceLabel)
        addSubview(capacityLabel)
        addSubview(buttonPlus)
        addSubview(buttonMinus)
    }
    func configurateViews(){
        productImage.contentMode = .scaleAspectFill
        
        priceLabel.textColor = .gray
        
        buttonPlus.setImage(UIImage(systemName: "plus.rectangle"), for: .normal)
        buttonPlus.addTarget(self, action: #selector(plus), for: .touchUpInside)
        
        buttonMinus.setImage(UIImage(systemName: "minus.rectangle"), for: .normal)
        buttonMinus.addTarget(self, action: #selector(minus), for: .touchUpInside)
    }
    func createConstraints(){
        productImage.snp.makeConstraints(){
            $0.left.equalToSuperview()
            $0.top.bottom.equalToSuperview()
            $0.width.equalTo(80)
        }
        nameLabel.snp.makeConstraints(){
            $0.left.equalTo(productImage.snp.right).offset(10)
            $0.top.equalToSuperview().inset(15)
        }
        priceLabel.snp.makeConstraints(){
            $0.left.equalTo(nameLabel)
            $0.bottom.equalToSuperview().inset(15)
        }
        capacityLabel.snp.makeConstraints(){
            $0.left.equalTo(nameLabel.snp.right).offset(10)
            $0.top.equalToSuperview().inset(15)
        }
        buttonPlus.snp.makeConstraints(){
            $0.height.equalToSuperview()
            $0.right.equalToSuperview().inset(8)
        }
        buttonMinus.snp.makeConstraints(){
            $0.right.equalTo(buttonPlus.snp.left).inset(-30)
            $0.height.equalToSuperview()
        }
    }
    
}

//MARK: - ButtonFunc

extension BasketCellTableViewCell {
    
    @objc func plus(){
        buttonPlusFunc?()
    }
    
    @objc func minus(){
        buttonMinusFunc?()
    }
}
