//
//  UsersDataView.swift
//  SpaceCoffe V4
//
//  Created by Grigoriy Korotaev on 16.06.2023.
//

import UIKit
import SnapKit

class UsersDataView: UIView {

    let userNameLabel = UILabel()
    let stotyLabel = UILabel()
    let singoutButton = UIButton()
    let ordersStoryTable = UITableView()
    
    init() {
        super.init(frame: .zero)
        backgroundColor = backgroundColorMain
        sutupViews()
        configurateViews()
        createConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func sutupViews(){
        addSubview(userNameLabel)
        addSubview(singoutButton)
        addSubview(ordersStoryTable)
        addSubview(stotyLabel)
    }
    
    func configurateViews(){
        userNameLabel.layer.masksToBounds = true
        userNameLabel.backgroundColor = secondBlackColor
        userNameLabel.layer.borderWidth = 1
        userNameLabel.layer.borderColor = lightGreenColor.cgColor
        userNameLabel.layer.cornerRadius = 10
        userNameLabel.text = "Пользователь  " + settings.shared.currentUserName 
        userNameLabel.textColor = .white
        userNameLabel.textAlignment = .center
        
        stotyLabel.layer.masksToBounds = true
        stotyLabel.backgroundColor = secondBlackColor
        stotyLabel.layer.borderWidth = 1
        stotyLabel.layer.borderColor = lightGreenColor.cgColor
        stotyLabel.layer.cornerRadius = 10
        stotyLabel.text = "История заказов"
        stotyLabel.textColor = .white
        stotyLabel.textAlignment = .center
        
        singoutButton.setImage(UIImage(systemName: "rectangle.portrait.and.arrow.forward"), for: .normal)
        singoutButton.backgroundColor = .lightGray
        singoutButton.layer.cornerRadius = 10
        
        ordersStoryTable.backgroundColor = .white
        ordersStoryTable.layer.cornerRadius = 10
    }
    func createConstraints(){
        userNameLabel.snp.makeConstraints(){
            $0.top.equalToSuperview().inset(50)
            $0.left.equalToSuperview().inset(UIScreen.main.bounds.width / 20)
            $0.right.equalTo(singoutButton.snp.left).inset(-10)
            $0.height.equalToSuperview().multipliedBy(0.05)
        }
        singoutButton.snp.makeConstraints(){
            $0.right.equalToSuperview().inset(UIScreen.main.bounds.width / 20)
            $0.top.equalTo(userNameLabel)
            $0.width.equalToSuperview().multipliedBy(0.2)
            $0.height.equalTo(userNameLabel)
        }
        stotyLabel.snp.makeConstraints(){
            $0.top.equalTo(userNameLabel.snp.bottom).offset(10)
            $0.left.equalTo(userNameLabel)
            $0.right.equalTo(singoutButton)
            $0.height.equalToSuperview().multipliedBy(0.05)
        }
        ordersStoryTable.snp.makeConstraints(){
            $0.top.equalTo(stotyLabel.snp.bottom).offset(10)
            $0.left.equalTo(userNameLabel)
            $0.right.equalTo(singoutButton)
            $0.bottom.equalToSuperview().inset(100)
        }
    }
    
}
