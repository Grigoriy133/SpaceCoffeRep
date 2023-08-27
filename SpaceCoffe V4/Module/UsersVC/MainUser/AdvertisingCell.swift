//
//  CollectionViewCellAdvertising.swift
//  SpaceCoffe V3
//
//  Created by Grigoriy Korotaev on 30.05.2023.
//

import UIKit
import SnapKit

class CollectionViewCellAdvertising: UICollectionViewCell {
    static var reuseId: String = "Advertising"
     
    var advImageView = UIImageView()
    var huy = ""
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.clipsToBounds = true
        addSubview(advImageView)
        layer.cornerRadius = 10
        layer.borderWidth = 1.5
        layer.borderColor = lightGreenColor.cgColor
        createConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createConstraints(){
        advImageView.contentMode = .scaleAspectFill
        advImageView.snp.makeConstraints(){
            $0.top.bottom.left.right.equalToSuperview()
        }
    }
}
