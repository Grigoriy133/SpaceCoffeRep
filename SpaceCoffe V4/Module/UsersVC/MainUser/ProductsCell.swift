//
//  CollectionViewCellProducts.swift
//  SpaceCoffe V3
//
//  Created by Grigoriy Korotaev on 01.06.2023.
//

import UIKit

class CollectionViewCellProducts: UICollectionViewCell {
    static var reuseId: String = "Products"
     
    var prodImageView = UIImageView()
    var priceLabel = UILabel()
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        createConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews(){
        self.clipsToBounds = true
        addSubview(prodImageView)
        addSubview(priceLabel)
        priceLabel.textColor = .white
        priceLabel.backgroundColor = .red
        priceLabel.font = .systemFont(ofSize: 12)
        layer.cornerRadius = 10
        layer.borderWidth = 1.5
        layer.borderColor = lightGreenColor.cgColor
    }
    
    func createConstraints(){
        prodImageView.contentMode = .scaleAspectFill
        prodImageView.snp.makeConstraints(){
            $0.top.bottom.left.right.equalToSuperview()
        }
        priceLabel.snp.makeConstraints(){
            $0.right.equalToSuperview().inset(4)
            $0.top.equalToSuperview().inset(15)
            $0.width.equalToSuperview().multipliedBy(0.35)
        }
    }
}
