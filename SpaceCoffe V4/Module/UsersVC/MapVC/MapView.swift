//
//  MapView.swift
//  SpaceCoffe V4
//
//  Created by Grigoriy Korotaev on 20.06.2023.
//

import UIKit
import MapKit
import SnapKit

class MapView: UIView {
    let mainMap = MKMapView()
    let labelCurrentPosition = UILabel()
    let labelSelectedStore = UILabel()
    let findMeButton = UIButton()
    let cleanButton = UIButton()
    
    init() {
        super.init(frame: .zero)
        setupViews()
        configurateView()
        createConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupViews(){
        addSubview(mainMap)
        addSubview(labelCurrentPosition)
        addSubview(labelSelectedStore)
        mainMap.addSubview(findMeButton)
    }
    func configurateView(){
        labelCurrentPosition.text = "Выберете вашу кофейню"
        labelCurrentPosition.textAlignment = .center
        labelCurrentPosition.backgroundColor = backgroundColorMain
        labelCurrentPosition.layer.borderWidth = 1
        labelCurrentPosition.layer.borderColor = lightGreenColor.cgColor
        labelCurrentPosition.textColor = .white
        labelCurrentPosition.layer.cornerRadius = 10
        labelCurrentPosition.layer.masksToBounds = true
        labelCurrentPosition.font = UIFont(name: "Futura", size: 27)
        
        labelSelectedStore.text = "улица Пушкина дом колотушкина"
        labelSelectedStore.textAlignment = .center
        labelSelectedStore.backgroundColor = buttonsGreenColor
        labelSelectedStore.textColor = .white
        labelSelectedStore.layer.cornerRadius = 10
        labelSelectedStore.layer.masksToBounds = true
        labelSelectedStore.font = UIFont(name: "Futura", size: 25)
        labelSelectedStore.numberOfLines = 0
        
        mainMap.layer.cornerRadius = 10
        mainMap.layer.masksToBounds = true
        
        findMeButton.layer.cornerRadius = 20
        findMeButton.setImage(UIImage(systemName: "location.circle"), for: .normal)
        findMeButton.alpha = 0.8
        findMeButton.backgroundColor = .gray
    }
    func createConstraints(){
        labelCurrentPosition.snp.makeConstraints(){
            $0.top.equalToSuperview().inset(UIScreen.main.bounds.height * 0.05)
            $0.left.right.equalToSuperview().inset(10)
            $0.height.equalToSuperview().multipliedBy(0.05)
        }
        labelSelectedStore.snp.makeConstraints(){
            $0.top.equalTo(labelCurrentPosition.snp.bottom).offset(10)
            $0.left.right.equalTo(labelCurrentPosition)
            $0.height.equalToSuperview().multipliedBy(0.1)
        }
        mainMap.snp.makeConstraints(){
            $0.top.equalTo(labelSelectedStore.snp.bottom).offset(20)
            $0.left.right.equalTo(labelSelectedStore)
            $0.bottom.equalToSuperview().inset(UIScreen.main.bounds.height * 0.12)
        }
        findMeButton.snp.makeConstraints(){
            $0.top.right.equalToSuperview().inset(10)
            $0.width.height.equalTo(40)
        }
    }
}
