//
//  BasketCellTableViewCell.swift
//  SpaceCoffe V4
//
//  Created by Grigoriy Korotaev on 10.06.2023.
//

import UIKit
import SnapKit

class ProductStoryCell: UITableViewCell {

    var productImage = UIImageView()
    var nameLabel = UILabel()
    var priceLabel = UILabel()
    var capacityLabel = UILabel()
    
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
    }
    func configurateViews(){
        productImage.contentMode = .scaleAspectFill
        
        priceLabel.textColor = .gray
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
    }
    
}
