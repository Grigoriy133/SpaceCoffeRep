//
//  addPromView.swift
//  SpaceCoffe V4
//
//  Created by Grigoriy Korotaev on 25.06.2023.
//

import UIKit

class addPromView: UIView {
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
    var keyTextField = UITextField()
    var valueTextField = UITextField()
    
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
        addSubview(keyTextField)
        addSubview(valueTextField)
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
    
        promoImage.layer.masksToBounds = true
        promoImage.layer.cornerRadius = 10
        promoImage.contentMode = .scaleAspectFill
        promoImage.image = UIImage(named: "astronavt")
        
        keyTextField.layer.masksToBounds = true
        keyTextField.layer.cornerRadius = 10
        keyTextField.backgroundColor = .white
        keyTextField.placeholder = "Ключ"
        
        valueTextField.layer.masksToBounds = true
        valueTextField.layer.cornerRadius = 10
        valueTextField.backgroundColor = .white
        valueTextField.placeholder = "Значение"
      //  valueTextField.keyboardType = .numberPad

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
        acceptButton.snp.makeConstraints(){
            $0.bottom.equalTo(closeButton.snp.top).offset(-20)
            $0.width.equalTo(closeButton)
            $0.height.equalToSuperview().multipliedBy(0.1)
            $0.centerX.equalToSuperview()
        }
        valueTextField.snp.makeConstraints(){
            $0.bottom.equalTo(acceptButton.snp.top).offset(-30)
            $0.width.equalTo(closeButton)
            $0.height.equalToSuperview().multipliedBy(0.1)
            $0.centerX.equalToSuperview()
        }
        keyTextField.snp.makeConstraints(){
            $0.bottom.equalTo(valueTextField.snp.top).offset(-30)
            $0.width.equalTo(closeButton)
            $0.height.equalToSuperview().multipliedBy(0.1)
            $0.centerX.equalToSuperview()
        }
        promoImage.snp.makeConstraints(){
            $0.right.left.top.equalToSuperview()
            $0.bottom.equalTo(keyTextField.snp.top).offset(-20)
        }
        }
}

//MARK: - KEY

extension addPromView {

      func configurateKey(){
          let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
          addGestureRecognizer(tapGesture)
      }
      @objc func hideKeyboard() {
          endEditing(true)
      }

}
