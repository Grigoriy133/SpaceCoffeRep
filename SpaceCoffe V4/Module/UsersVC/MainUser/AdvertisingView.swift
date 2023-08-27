//
//  ProductsViewController.swift
//  SpaceCoffe V4
//
//  Created by Grigoriy Korotaev on 06.06.2023.
//

import UIKit
import SnapKit

class AdvertisingView : UIView {

    var y1 = CGFloat(0)
    var x2 = CGFloat(0)
    var y2 = CGFloat(0)
    var w1 = CGFloat(0)
    var h1 = CGFloat(0)

    var currentCondition = ConditionView.close
    var animator = UIViewPropertyAnimator()
    
    var closeButton = UIButton()
    var advertisingImageView = UIImageView()
    var termsLabel = UILabel()
    
    init() {
        super.init(frame: .zero)
        calculateFrame()
        setupView()
        createMainView()
        configurateSubviews()
        createConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(){
        addSubview(closeButton)
        addSubview(advertisingImageView)
        addSubview(termsLabel)
    }
    
    func createMainView(){
        frame = CGRect(x: x2 , y: y1, width: w1 , height: h1)
        layer.cornerRadius = 15
        backgroundColor = secondBlackColor
    }
    func configurateSubviews(){
        closeButton.layer.cornerRadius = 10
        closeButton.backgroundColor = buttonsGreenColor
        closeButton.setTitle("Ясно", for: .normal)
    
        termsLabel.text = ""
        termsLabel.textColor = .white
        termsLabel.textAlignment = .center
        termsLabel.numberOfLines = 0

        advertisingImageView.layer.masksToBounds = true
        advertisingImageView.layer.cornerRadius = 10
        advertisingImageView.contentMode = .scaleAspectFit
    }
    func calculateFrame(){
         x2 = UIScreen.main.bounds.width / 2 - (UIScreen.main.bounds.width * 0.92) / 2
         y1 = -1000
         y2 = 0
         w1 = UIScreen.main.bounds.width * 0.92
         h1 = UIScreen.main.bounds.height * 0.8
    }
    func createConstraints(){
        closeButton.snp.makeConstraints(){
            $0.bottom.equalToSuperview().inset(20)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.9)
            $0.height.equalToSuperview().multipliedBy(0.1)
        }
        termsLabel.snp.makeConstraints(){
            $0.bottom.equalTo(closeButton.snp.top).offset(-30)
            $0.width.equalTo(closeButton)
            $0.centerX.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.4)
        }
        advertisingImageView.snp.makeConstraints(){
            $0.top.equalToSuperview().inset(30)
            $0.left.right.equalTo(closeButton)
            $0.bottom.equalTo(termsLabel.snp.top).offset(-30)
        }

    }
    
}
