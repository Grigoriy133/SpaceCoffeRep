//
//  MenuSettingView.swift
//  SpaceCoffe V4
//
//  Created by Grigoriy Korotaev on 25.06.2023.
//

import UIKit

class MenuSettingView: UIView {

    let logOutButton = UIButton()
    let tableViewAdvertising = UITableView()
    let tableViewPromo = UITableView()
    let settingLabel = UILabel()
    let labelAddAdvertising = UILabel()
    let labelAddPromo = UILabel()
    let addButtonAdv = UIButton()
    let addButtonPromo = UIButton()
    
    init() {
        super.init(frame: .zero)
        backgroundColor = backgroundColorMain
        setupView()
        configurateViews()
        createConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupView(){
        addSubview(logOutButton)
        addSubview(tableViewAdvertising)
        addSubview(settingLabel)
        addSubview(labelAddAdvertising)
        addSubview(tableViewPromo)
        addSubview(labelAddPromo)
        addSubview(addButtonPromo)
        addSubview(addButtonAdv)
    }
    func configurateViews(){
        labelAddPromo.layer.masksToBounds = true
        labelAddPromo.backgroundColor = secondBlackColor
        labelAddPromo.layer.borderWidth = 1
        labelAddPromo.layer.borderColor = lightGreenColor.cgColor
        labelAddPromo.layer.cornerRadius = 10
        labelAddPromo.text = "Промокоды"
        labelAddPromo.textColor = .white
        labelAddPromo.textAlignment = .center
    
        labelAddAdvertising.layer.masksToBounds = true
        labelAddAdvertising.backgroundColor = secondBlackColor
        labelAddAdvertising.layer.borderWidth = 1
        labelAddAdvertising.layer.borderColor = lightGreenColor.cgColor
        labelAddAdvertising.layer.cornerRadius = 10
        labelAddAdvertising.text = "Акции"
        labelAddAdvertising.textColor = .white
        labelAddAdvertising.textAlignment = .center
        
        settingLabel.layer.masksToBounds = true
        settingLabel.backgroundColor = secondBlackColor
        settingLabel.layer.borderWidth = 1
        settingLabel.layer.borderColor = lightGreenColor.cgColor
        settingLabel.layer.cornerRadius = 10
        settingLabel.text = "Настройки ассортимента"
        settingLabel.textColor = .white
        settingLabel.textAlignment = .center

        tableViewAdvertising.layer.masksToBounds = true
        tableViewAdvertising.layer.cornerRadius = 10
        tableViewAdvertising.backgroundColor = .white
        
        tableViewPromo.layer.masksToBounds = true
        tableViewPromo.layer.cornerRadius = 10
        tableViewPromo.backgroundColor = .white
        
        logOutButton.setImage(UIImage(systemName: "rectangle.portrait.and.arrow.forward"), for: .normal)
        logOutButton.backgroundColor = .lightGray
        logOutButton.layer.cornerRadius = 10
        
        addButtonAdv.setImage(UIImage(systemName: "plus.square"), for: .normal)
        addButtonAdv.backgroundColor = .lightGray
        addButtonAdv.layer.cornerRadius = 10
        
        addButtonPromo.setImage(UIImage(systemName: "plus.square"), for: .normal)
        addButtonPromo.backgroundColor = .lightGray
        addButtonPromo.layer.cornerRadius = 10
        
    }
    func createConstraints(){
        settingLabel.snp.makeConstraints(){
            $0.top.equalToSuperview().inset(50)
            $0.left.equalToSuperview().inset(UIScreen.main.bounds.width / 20)
            $0.right.equalTo(logOutButton.snp.left).inset(-10)
            $0.height.equalToSuperview().multipliedBy(0.05)
        }
        logOutButton.snp.makeConstraints(){
            $0.right.equalToSuperview().inset(UIScreen.main.bounds.width / 20)
            $0.top.equalTo(settingLabel)
            $0.width.equalToSuperview().multipliedBy(0.2)
            $0.height.equalTo(settingLabel)
        }
        labelAddAdvertising.snp.makeConstraints(){
            $0.right.equalTo(settingLabel)
            $0.top.equalTo(settingLabel.snp.bottom).offset(10)
            $0.left.equalTo(settingLabel)
            $0.height.equalTo(settingLabel)
        }
        tableViewAdvertising.snp.makeConstraints(){
            $0.top.equalTo(labelAddAdvertising.snp.bottom).offset(10)
            $0.left.equalTo(settingLabel)
            $0.right.equalTo(logOutButton)
            $0.height.equalToSuperview().multipliedBy(0.4)
        }
        labelAddPromo.snp.makeConstraints(){
            $0.right.equalTo(labelAddAdvertising)
            $0.top.equalTo(tableViewAdvertising.snp.bottom).offset(10)
            $0.left.equalTo(labelAddAdvertising)
            $0.height.equalTo(labelAddAdvertising)
        }
        tableViewPromo.snp.makeConstraints(){
            $0.top.equalTo(labelAddPromo.snp.bottom).offset(10)
            $0.left.equalTo(settingLabel)
            $0.right.equalTo(logOutButton)
            $0.height.equalToSuperview().multipliedBy(0.2)
        }
        addButtonAdv.snp.makeConstraints(){
            $0.top.equalTo(labelAddAdvertising)
            $0.left.equalTo(logOutButton)
            $0.right.equalTo(logOutButton)
            $0.height.equalTo(labelAddAdvertising)
        }
        addButtonPromo.snp.makeConstraints(){
            $0.top.equalTo(labelAddPromo)
            $0.left.equalTo(logOutButton)
            $0.right.equalTo(logOutButton)
            $0.height.equalTo(labelAddAdvertising)
        }
    }
}
