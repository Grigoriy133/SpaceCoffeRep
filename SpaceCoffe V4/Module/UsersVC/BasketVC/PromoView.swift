//
//  PromoView.swift
//  SpaceCoffe V4
//
//  Created by Grigoriy Korotaev on 13.06.2023.
//

import UIKit

class PromoView: UIView {
    static let huy = PromoView()
    var y1 = CGFloat(0)
    var x2 = CGFloat(0)
    var y2 = CGFloat(0)
    var w1 = CGFloat(0)
    var h1 = CGFloat(0)
    
    var currentCondition = ConditionView.close
    var animator = UIViewPropertyAnimator()
    
    var closeButton = UIButton()
    var acceptButton = UIButton()
    var promoImage = UIImageView()
    var promoLabel = UILabel()
    var promoTextField = UITextField()
    
    init() {
        super.init(frame: .zero)
        calculateFrame()
        setupView()
        createMainView()
        configurateSubviews()
        createConstraints()
        configurateKey()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(){
        addSubview(closeButton)
        addSubview(acceptButton)
        addSubview(promoImage)
        addSubview(promoLabel)
        addSubview(promoTextField)
    }
    
    func createMainView(){
        frame = CGRect(x: x2 , y: y1, width: w1 , height: h1)
        layer.cornerRadius = 15
        backgroundColor = secondBlackColor
    }
    func configurateSubviews(){
        closeButton.layer.cornerRadius = 10
        closeButton.backgroundColor = buttonsGreenColor
        closeButton.setTitle("Отмена", for: .normal)
        
        acceptButton.layer.cornerRadius = 10
        acceptButton.backgroundColor = buttonsGreenColor
        acceptButton.setTitle("Применить", for: .normal)
    
        promoLabel.text = "Введите промокод"
        promoLabel.textColor = .white
        promoLabel.textAlignment = .center

        promoImage.layer.masksToBounds = true
        promoImage.layer.cornerRadius = 10
        promoImage.contentMode = .scaleAspectFill
        promoImage.image = UIImage(named: "astronavt")
        
        promoTextField.layer.masksToBounds = true
        promoTextField.layer.cornerRadius = 10
        promoTextField.backgroundColor = .white
        promoTextField.placeholder = "Промокод"
    }
    func calculateFrame(){
        x2 = UIScreen.main.bounds.width / 2 - (UIScreen.main.bounds.width * 0.99) / 2
        y1 = -1000
        y2 = 0
        w1 = UIScreen.main.bounds.width * 0.99
        h1 = UIScreen.main.bounds.height * 0.8
    }
    
    func createConstraints(){
        closeButton.snp.makeConstraints(){
            $0.bottom.equalToSuperview().inset(20)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.9)
            $0.height.equalToSuperview().multipliedBy(0.1)
        }
        promoImage.snp.makeConstraints(){
            $0.right.left.top.equalToSuperview()
            $0.bottom.equalTo(promoLabel.snp.top)
        }
        acceptButton.snp.makeConstraints(){
            $0.bottom.equalTo(closeButton.snp.top).offset(-20)
            $0.width.equalTo(closeButton)
            $0.height.equalToSuperview().multipliedBy(0.1)
            $0.centerX.equalToSuperview()
        }
        promoTextField.snp.makeConstraints(){
            $0.bottom.equalTo(acceptButton.snp.top).offset(-30)
            $0.width.equalTo(closeButton)
            $0.height.equalToSuperview().multipliedBy(0.1)
            $0.centerX.equalToSuperview()
        }
        promoLabel.snp.makeConstraints(){
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(promoTextField.snp.top).offset(-10)
        }

    }
}

//MARK: - KEY

extension PromoView {

      func configurateKey(){
          let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
          addGestureRecognizer(tapGesture)
      }
      @objc func hideKeyboard() {
          endEditing(true)
      }
}


