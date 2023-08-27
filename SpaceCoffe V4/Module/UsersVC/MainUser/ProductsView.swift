//
//  ProductsViewController.swift
//  SpaceCoffe V4
//
//  Created by Grigoriy Korotaev on 06.06.2023.
//

import UIKit
import SnapKit

class ProductsView : UIView {

    var y1 = CGFloat(0)
    var x2 = CGFloat(0)
    var y2 = CGFloat(0)
    var w1 = CGFloat(0)
    var h1 = CGFloat(0)
    var w2 = CGFloat(0)
    var h2 = CGFloat(0)
    var currentCondition = ConditionView.close
    var animator = UIViewPropertyAnimator()
    
    var closeButton = UIButton()
    var enterButton = UIButton()
    var segmentCapacity = UISegmentedControl()
    var priceLabel = UILabel()
    var sizeLabel = UILabel()
    var imageViewProduct = UIImageView()
   
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
        addSubview(enterButton)
        addSubview(segmentCapacity)
        addSubview(priceLabel)
        addSubview(imageViewProduct)
        imageViewProduct.addSubview(sizeLabel)
    }
    
    func createMainView(){
        frame = CGRect(x: x2 , y: y1, width: w2 , height: h2)
        layer.cornerRadius = 15
        backgroundColor = secondBlackColor
    }
    func configurateSubviews(){
        closeButton.layer.cornerRadius = 10
        closeButton.backgroundColor = buttonsGreenColor
        closeButton.setTitle("Отмена", for: .normal)
        
        enterButton.layer.cornerRadius = 10
        enterButton.backgroundColor = buttonsGreenColor
        enterButton.setTitle("В корзину", for: .normal)
        
        segmentCapacity.insertSegment(withTitle: "", at: 0, animated: true)
        segmentCapacity.insertSegment(withTitle: "", at: 1, animated: true)
        segmentCapacity.selectedSegmentIndex = 1
        segmentCapacity.layer.cornerRadius = 10
        segmentCapacity.backgroundColor = buttonsGreenColor
        
        priceLabel.text = ""
        priceLabel.layer.masksToBounds = true
        priceLabel.layer.cornerRadius = 10
        priceLabel.textColor = .black
        priceLabel.textAlignment = .center
        priceLabel.backgroundColor = buttonsGreenColor
        
        sizeLabel.textColor = .white
        sizeLabel.backgroundColor = .red
        sizeLabel.textAlignment = .center
        sizeLabel.text = "Large"
        sizeLabel.font = .systemFont(ofSize: 12)
        
        imageViewProduct.layer.masksToBounds = true
        imageViewProduct.layer.cornerRadius = 10
        imageViewProduct.contentMode = .scaleAspectFill
    }
    func calculateFrame(){
         x2 = UIScreen.main.bounds.width / 2 - (UIScreen.main.bounds.width * 0.92) / 2
         y1 = 1000
         y2 = 100
         w2 = UIScreen.main.bounds.width * 0.92
         h2 = UIScreen.main.bounds.height * 0.75
    }
    func createConstraints(){
        closeButton.snp.makeConstraints(){
            $0.bottom.equalToSuperview().inset(20)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.9)
            $0.height.equalToSuperview().multipliedBy(0.1)
        }
        enterButton.snp.makeConstraints(){
            $0.bottom.equalTo(closeButton.snp.top).offset(-30)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(closeButton)
        }
        segmentCapacity.snp.makeConstraints(){
            $0.bottom.equalTo(enterButton.snp.top).offset(-30)
            $0.left.equalTo(enterButton)
            $0.width.equalToSuperview().multipliedBy(0.4)
            $0.height.equalTo(enterButton)
        }
        priceLabel.snp.makeConstraints(){
            $0.bottom.equalTo(segmentCapacity)
            $0.right.equalTo(enterButton)
            $0.width.equalTo(segmentCapacity)
            $0.height.equalTo(segmentCapacity)
        }
        imageViewProduct.snp.makeConstraints(){
            $0.top.equalToSuperview().inset(30)
            $0.left.right.equalTo(enterButton)
            $0.bottom.equalTo(segmentCapacity.snp.top).offset(-30)
        }
        sizeLabel.snp.makeConstraints(){
            $0.right.top.equalToSuperview().inset(10)
            $0.width.equalTo(60)
        }
    }
    
}
