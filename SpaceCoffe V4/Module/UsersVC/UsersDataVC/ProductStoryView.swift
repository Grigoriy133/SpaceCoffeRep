//
//  ProductsViewController.swift
//  SpaceCoffe V4
//
//  Created by Grigoriy Korotaev on 06.06.2023.
//

import UIKit
import SnapKit

class productStoryView : UIView {

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
    var containtsLabel = UILabel()
    var storyTableView = UITableView()
   
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
        addSubview(containtsLabel)
        addSubview(storyTableView)
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
        
        containtsLabel.layer.masksToBounds = true
        containtsLabel.backgroundColor = secondBlackColor
        containtsLabel.layer.borderWidth = 1
        containtsLabel.layer.borderColor = lightGreenColor.cgColor
        containtsLabel.layer.cornerRadius = 10
        containtsLabel.text = "Содержание заказа"
        containtsLabel.textColor = .white
        containtsLabel.textAlignment = .center
        
        storyTableView.layer.masksToBounds = true
        storyTableView.backgroundColor = .white
        storyTableView.layer.cornerRadius = 10
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
        containtsLabel.snp.makeConstraints(){
            $0.top.equalToSuperview().inset(20)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(closeButton)
        }
        storyTableView.snp.makeConstraints(){
            $0.top.equalTo(containtsLabel.snp.bottom).offset(10)
            $0.bottom.equalTo(closeButton.snp.top).offset(-10)
            $0.width.equalTo(containtsLabel)
            $0.centerX.equalToSuperview()
        }
       
    }
    
}
