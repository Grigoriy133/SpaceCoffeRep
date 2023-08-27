//
//  BasketView.swift
//  SpaceCoffe V4
//
//  Created by Grigoriy Korotaev on 10.06.2023.
//

import UIKit
import SnapKit

class BasketView: UIView {

    var topLabel = UILabel()
    var basketsTableView = UITableView()
    var finalWealthLabel = UILabel()
    var bottomLabel = UILabel()
    var acceptButton = UIButton()
    var cleanButton = UIButton()
    var promocodeButton = UIButton()
    var conditionalView = UIView()
    var conditionalLabel = UILabel()

    init() {
        super.init(frame: .zero)
        backgroundColor = backgroundColorMain
        setupViews()
        configurateViews()
        makeconstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupViews(){
        addSubview(topLabel)
        bottomLabel.addSubview(finalWealthLabel)
        addSubview(bottomLabel)
        addSubview(acceptButton)
        addSubview(cleanButton)
        addSubview(promocodeButton)
        addSubview(conditionalView)
        conditionalView.addSubview(conditionalLabel)
        addSubview(basketsTableView)
    }
    func configurateViews(){
        bottomLabel.text = "  Итоговая стоимость:"
        bottomLabel.textAlignment = .left
        bottomLabel.backgroundColor = backgroundColorMain
        bottomLabel.layer.borderWidth = 1
        bottomLabel.layer.borderColor = lightGreenColor.cgColor
        bottomLabel.textColor = .white
        bottomLabel.layer.cornerRadius = 10
        bottomLabel.layer.masksToBounds = true
        bottomLabel.font = UIFont(name: "Futura", size: 20)
        
        topLabel.text = "Содержание заказа"
        topLabel.textAlignment = .center
        topLabel.backgroundColor = backgroundColorMain
        topLabel.layer.borderWidth = 1
        topLabel.layer.borderColor = lightGreenColor.cgColor
        topLabel.textColor = .white
        topLabel.layer.cornerRadius = 10
        topLabel.layer.masksToBounds = true
        topLabel.font = UIFont(name: "Futura", size: 27)
        
        finalWealthLabel.text = "300 рублей"
        finalWealthLabel.textAlignment = .right
        finalWealthLabel.textColor = .white
        finalWealthLabel.font = UIFont(name: "Futura", size: 20)
        
        acceptButton.setTitle("Заказать", for: .normal)
        acceptButton.layer.cornerRadius = 10
        acceptButton.backgroundColor = buttonsGreenColor
        
        promocodeButton.setTitle("Промокод", for: .normal)
        promocodeButton.layer.cornerRadius = 10
        promocodeButton.backgroundColor = buttonsGreenColor
        
        cleanButton.setTitle("Очистить", for: .normal)
        cleanButton.layer.cornerRadius = 10
        cleanButton.backgroundColor = .red
        
        basketsTableView.alpha = 1
        basketsTableView.backgroundColor = .white
        basketsTableView.layer.cornerRadius = 10
        
        conditionalView.backgroundColor = secondBlackColor
        conditionalView.layer.cornerRadius = 10
        
        conditionalLabel.textColor = .white
        conditionalLabel.font = UIFont(name: "Futura", size: 30)
    }
    
    //MARK: - Constraints
    func makeconstraints(){
        topLabel.snp.makeConstraints(){
            $0.top.equalToSuperview().inset(UIScreen.main.bounds.height * 0.07)
            $0.width.equalToSuperview().multipliedBy(0.95)
            $0.centerX.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.1)
        }
        acceptButton.snp.makeConstraints(){
            $0.bottom.equalToSuperview().inset(UIScreen.main.bounds.height * 0.12)
            $0.width.equalToSuperview().multipliedBy(0.95)
            $0.height.equalToSuperview().multipliedBy(0.05)
            $0.centerX.equalToSuperview()
        }
        promocodeButton.snp.makeConstraints(){
            $0.bottom.equalTo(acceptButton.snp.top).offset(-10)
            $0.width.equalToSuperview().multipliedBy(0.68)
            $0.height.equalToSuperview().multipliedBy(0.05)
            $0.left.equalTo(topLabel)
        }
        cleanButton.snp.makeConstraints(){
            $0.bottom.equalTo(acceptButton.snp.top).offset(-10)
            $0.width.equalToSuperview().multipliedBy(0.25)
            $0.height.equalToSuperview().multipliedBy(0.05)
            $0.right.equalTo(topLabel)
        }
        bottomLabel.snp.makeConstraints(){
            $0.bottom.equalTo(promocodeButton.snp.top).offset(-10)
            $0.width.equalToSuperview().multipliedBy(0.95)
            $0.centerX.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.05)
        }
        finalWealthLabel.snp.makeConstraints(){
            $0.right.equalToSuperview().inset(10)
            $0.centerY.equalToSuperview()
        }
        basketsTableView.snp.makeConstraints(){
            $0.top.equalTo(topLabel.snp.bottom).inset(-10)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.95)
            $0.bottom.equalTo(bottomLabel.snp.top).inset(-10)
        }
        conditionalView.snp.makeConstraints(){
            $0.top.bottom.left.right.equalTo(basketsTableView)
        }
        conditionalLabel.snp.makeConstraints(){
            $0.centerX.centerY.equalToSuperview()
        }
    }
    
}
