//
//  UsersOthersView.swift
//  SpaceCoffe V4
//
//  Created by Grigoriy Korotaev on 21.06.2023.
//

import UIKit
import SnapKit

class UsersOthersView: UIView {

    let comeBackForm = UILabel()
    let sendButton = UIButton()
    let textView = UITextView()
    let contactField = UITextField()
    let contactLabel = UILabel()
    
    init() {
        super.init(frame: .zero)
        setupView()
        configurateViews()
        createConstraints()
        configurateKey()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(){
        addSubview(comeBackForm)
        addSubview(sendButton)
        addSubview(textView)
        addSubview(contactField)
        addSubview(contactLabel)
    }
    func configurateViews(){
        comeBackForm.text = "Обратная связь"
        comeBackForm.textAlignment = .center
        comeBackForm.backgroundColor = backgroundColorMain
        comeBackForm.layer.borderWidth = 1
        comeBackForm.layer.borderColor = lightGreenColor.cgColor
        comeBackForm.textColor = .white
        comeBackForm.layer.cornerRadius = 10
        comeBackForm.layer.masksToBounds = true
        comeBackForm.font = UIFont(name: "Futura", size: 27)
        
        contactLabel.text = "Информация для связи"
        contactLabel.textAlignment = .center
        contactLabel.backgroundColor = backgroundColorMain
        contactLabel.layer.borderWidth = 1
        contactLabel.layer.borderColor = lightGreenColor.cgColor
        contactLabel.textColor = .white
        contactLabel.layer.cornerRadius = 10
        contactLabel.layer.masksToBounds = true
        contactLabel.font = UIFont(name: "Futura", size: 20)
        
        sendButton.setTitle("Отправить", for: .normal)
        sendButton.backgroundColor = buttonsGreenColor
        sendButton.layer.masksToBounds = true
        sendButton.layer.cornerRadius = 10
        
        contactField.layer.cornerRadius = 10
        contactField.placeholder = "Телефон или email"
        contactField.layer.masksToBounds = true
        contactField.layer.cornerRadius = 10
        contactField.backgroundColor = .white
        
        textView.layer.masksToBounds = true
        textView.layer.cornerRadius = 10
    }
    func createConstraints(){
        comeBackForm.snp.makeConstraints(){
            $0.top.equalToSuperview().inset(UIScreen.main.bounds.height * 0.07)
            $0.width.equalToSuperview().multipliedBy(0.95)
            $0.centerX.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.1)
        }
        textView.snp.makeConstraints(){
            $0.top.equalTo(comeBackForm.snp.bottom).offset(10)
            $0.width.equalTo(comeBackForm)
            $0.centerX.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.2)
        }
        contactLabel.snp.makeConstraints(){
            $0.top.equalTo(textView.snp.bottom).offset(10)
            $0.width.equalTo(comeBackForm)
            $0.centerX.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.08)
        }
        contactField.snp.makeConstraints(){
            $0.top.equalTo(contactLabel.snp.bottom).offset(10)
            $0.width.equalTo(comeBackForm)
            $0.centerX.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.08)
        }
        sendButton.snp.makeConstraints(){
            $0.top.equalTo(contactField.snp.bottom).offset(10)
            $0.width.equalTo(comeBackForm)
            $0.centerX.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.08)
        }
        
    }
}


//MARK: - KEY

extension UsersOthersView {

      func configurateKey(){
          let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
          addGestureRecognizer(tapGesture)
      }
      @objc func hideKeyboard() {
          endEditing(true)
      }
}
