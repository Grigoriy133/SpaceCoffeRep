//
//  OrdersHistoryCell.swift
//  SpaceCoffe V4
//
//  Created by Grigoriy Korotaev on 16.06.2023.

import UIKit
import SnapKit

class OrdersHistoryCell: UITableViewCell {

    var productImage = UIImageView()
    var numberLabel = UILabel()
    var priceLabel = UILabel()
    var dateLabel = UILabel()

    static let reuseId = "OrdersHistoryCell"
    
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
        addSubview(numberLabel)
        addSubview(priceLabel)
        addSubview(dateLabel)
    }
    func configurateViews(){
        productImage.image = UIImage(systemName: "bag.circle")
        productImage.contentMode = .scaleAspectFit
        
        dateLabel.font = .systemFont(ofSize: 12)
        priceLabel.font = .systemFont(ofSize: 12)
        numberLabel.font = .systemFont(ofSize: 12)

        priceLabel.textColor = .gray
    }
    func createConstraints(){
        productImage.snp.makeConstraints(){
            $0.left.top.bottom.equalToSuperview().inset(10)
            $0.width.equalToSuperview().multipliedBy(0.08)
        }
        
        dateLabel.snp.makeConstraints(){
            $0.left.equalTo(productImage.snp.right).offset(10)
            $0.top.equalToSuperview().inset(5)
        }
        numberLabel.snp.makeConstraints(){
            $0.left.equalTo(productImage.snp.right).offset(10)
            $0.bottom.equalToSuperview().inset(5)
        }
        priceLabel.snp.makeConstraints(){
            $0.right.equalToSuperview().inset(15)
            $0.centerY.equalToSuperview()
        }
    }
    
}
