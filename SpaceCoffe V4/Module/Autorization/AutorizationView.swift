//
//  AutorizationView.swift
//  SpaceCoffe V4
//
//  Created by Grigoriy Korotaev on 03.06.2023.
//

//
//  AutorizationView.swift
//  SpaceCoffe V3
//
//  Created by Grigoriy Korotaev on 11.05.2023.
//

import UIKit
import SnapKit

class AutorizationView: UIView {
    let additionalView = UIView()
    let mainImageView = UIImageView()
    let textFieldPhone = UITextField()
    let textFieldPassword = UITextField()
    let buttonEnter = UIButton()
    let buttonRegistration = UIButton()
    let textStack = UIStackView()
    let buttonStack = UIStackView()

//MARK: - lifecycle
    init() {
        super.init(frame: .zero)
        calculateKf()
        setupViews()
        createViews()
        createContraints()
        configurateKeyboard()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
//MARK: - UI
    func configurateKeyboard(){
        keyButton.shared.addDoneButtonOnKeyboard(textField: textFieldPhone)
        keyButton.shared.addDoneButtonOnKeyboard(textField: textFieldPassword)
    }
    func calculateKf(){
        kf = UIScreen.main.bounds.height / 700
    }
    func setupViews(){
        addSubview(additionalView)
        additionalView.backgroundColor = backgroundColorMain
        additionalView.addSubview(mainImageView)
        additionalView.addSubview(textStack)
        additionalView.addSubview(buttonStack)
        textStack.addSubview(textFieldPhone)
        textStack.addSubview(textFieldPassword)
        buttonStack.addSubview(buttonEnter)
        buttonStack.addSubview(buttonRegistration)
    }
    func createViews(){
        mainImageView.image = UIImage(named: "astronavt")
        mainImageView.contentMode = .scaleAspectFill
        
        buttonEnter.backgroundColor = buttonsGreenColor
        buttonRegistration.backgroundColor = buttonsGreenColor
        buttonEnter.layer.cornerRadius = 10
        buttonRegistration.layer.cornerRadius = 10
        buttonEnter.setTitle("Войти", for: .normal)
        buttonRegistration.setTitle("Регистрация", for: .normal)
        buttonEnter.setTitleColor(.white, for: .normal)
        buttonRegistration.setTitleColor(.white, for: .normal)
        
        textFieldPhone.backgroundColor = UIColor(red: 234/255, green: 231/255, blue: 226/255, alpha: 1)
        textFieldPassword.backgroundColor = UIColor(red: 234/255, green: 231/255, blue: 226/255, alpha: 1)
        textFieldPhone.layer.cornerRadius = 10
        textFieldPassword.layer.cornerRadius = 10
        textFieldPhone.font = UIFont.systemFont(ofSize: 30 * kf)
        textFieldPassword.font = UIFont.systemFont(ofSize: 30 * kf)
        textFieldPhone.placeholder = "Телефон"
        textFieldPassword.placeholder = "Пароль"

        buttonStack.spacing = 10
        textStack.spacing = 10
    }
    func createContraints(){
        additionalView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)

        mainImageView.snp.makeConstraints{
            $0.top.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.4)
            $0.width.equalToSuperview()
        }
        textStack.snp.makeConstraints{
            $0.top.equalTo(mainImageView.snp.bottom).offset(UIScreen.main.bounds.height * 0.05)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.9)
            $0.height.equalToSuperview().multipliedBy(0.2)
        }
        buttonStack.snp.makeConstraints{
            $0.top.equalTo(textStack.snp.bottom).offset(UIScreen.main.bounds.height * 0.07)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.9)
            $0.height.equalToSuperview().multipliedBy(0.2)
        }
        textFieldPhone.snp.makeConstraints{
            $0.top.left.right.equalToSuperview()
            $0.height.equalToSuperview().dividedBy(2.4)
        }
        textFieldPassword.snp.makeConstraints{
            $0.bottom.left.right.equalToSuperview()
            $0.height.equalToSuperview().dividedBy(2.4)
        }
        buttonEnter.snp.makeConstraints{
            $0.top.left.right.equalToSuperview()
            $0.height.equalToSuperview().dividedBy(2.4)
        }
        buttonRegistration.snp.makeConstraints{
            $0.bottom.left.right.equalToSuperview()
            $0.height.equalToSuperview().dividedBy(2.4)
        }
    }
}
