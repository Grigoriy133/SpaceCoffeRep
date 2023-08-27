//
//  StatView.swift
//  SpaceCoffe V4
//
//  Created by Grigoriy Korotaev on 22.06.2023.
//

import UIKit
import Charts
import SnapKit

class StatView: UIView {

    let datePickerFrom = UIDatePicker()
    let datePickerTo = UIDatePicker()
    let calculateButton = UIButton()
    let labelFrom = UILabel()
    let labelTo = UILabel()
    let stack1 = UIStackView()
    let stack2 = UIStackView()
    let stack3 = UIStackView()
    let cupResultLabel = UILabel()
    let summaryResultLabel = UILabel()
    
    var pieChart = PieChartView()
    var barChart = BarChartView()
    
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
        stack1.addSubview(datePickerFrom)
        stack2.addSubview(datePickerTo)
        addSubview(calculateButton)
        stack1.addSubview(labelFrom)
        stack2.addSubview(labelTo)
        stack3.addSubview(cupResultLabel)
        stack3.addSubview(summaryResultLabel)
        addSubview(pieChart)
        addSubview(barChart)
        addSubview(stack1)
        addSubview(stack2)
        addSubview(stack3)
    }
    func configurateView(){
        stack1.backgroundColor = .white
        stack1.layer.borderWidth = 1
        stack1.layer.borderColor = lightGreenColor.cgColor
        stack1.layer.cornerRadius = 10
        stack1.layer.masksToBounds = true
        stack1.axis = .vertical
        stack1.spacing = 10
        stack1.alignment = .center
        
        stack2.backgroundColor = .white
        stack2.layer.borderWidth = 1
        stack2.layer.borderColor = lightGreenColor.cgColor
        stack2.layer.cornerRadius = 10
        stack2.layer.masksToBounds = true
        stack2.axis = .vertical
        stack2.spacing = 10
        stack2.alignment = .center
        
        stack3.backgroundColor = .white
        stack3.layer.borderWidth = 1
        stack3.layer.borderColor = lightGreenColor.cgColor
        stack3.layer.cornerRadius = 10
        stack3.layer.masksToBounds = true
        stack3.axis = .vertical
        stack3.alignment = .leading
        
        cupResultLabel.text = " Кол-во кружек в период: "
        summaryResultLabel.text = " Выручка за период: "
        cupResultLabel.textAlignment = .left
        summaryResultLabel.textAlignment = .left
        
        labelFrom.text = "Начальная дата"
        
        labelTo.text = "Конечная дата"
        
        datePickerFrom.datePickerMode = .date
        datePickerTo.datePickerMode = .date
        
        calculateButton.backgroundColor = buttonsGreenColor
        calculateButton.setTitle("Рассчет", for: .normal)
        calculateButton.layer.cornerRadius = 10
        calculateButton.layer.masksToBounds = true
        
        barChart.layer.cornerRadius = 10
        calculateButton.layer.masksToBounds = true
        
        pieChart.layer.cornerRadius = 10
        calculateButton.layer.masksToBounds = true
        

    }
    func createConstraints(){
        stack1.snp.makeConstraints(){
            $0.top.equalToSuperview().inset(UIScreen.main.bounds.height * 0.05)
            $0.width.equalToSuperview().multipliedBy(0.43)
            $0.left.equalToSuperview().inset(UIScreen.main.bounds.width * 0.05)
            $0.height.equalToSuperview().multipliedBy(0.1)
        }
        stack2.snp.makeConstraints(){
            $0.top.equalToSuperview().inset(UIScreen.main.bounds.height * 0.05)
            $0.width.equalToSuperview().multipliedBy(0.43)
            $0.right.equalToSuperview().inset(UIScreen.main.bounds.width * 0.05)
            $0.height.equalToSuperview().multipliedBy(0.1)
        }
        labelFrom.snp.makeConstraints(){
            $0.left.right.top.equalToSuperview().inset(10)
            $0.height.equalToSuperview().multipliedBy(0.3)
        }
        labelTo.snp.makeConstraints(){
            $0.left.right.top.equalToSuperview().inset(10)
            $0.height.equalToSuperview().multipliedBy(0.3)
        }
        datePickerFrom.snp.makeConstraints(){
            $0.bottom.equalToSuperview().inset(10)
            $0.height.equalToSuperview().multipliedBy(0.3)
            $0.centerX.equalToSuperview()
        }
        datePickerTo.snp.makeConstraints(){
            $0.bottom.equalToSuperview().inset(10)
            $0.height.equalToSuperview().multipliedBy(0.3)
            $0.centerX.equalToSuperview()
        }
        calculateButton.snp.makeConstraints(){
            $0.left.equalTo(stack1)
            $0.right.equalTo(stack2)
            $0.top.equalTo(stack2.snp.bottom).offset(15)
            $0.height.equalToSuperview().multipliedBy(0.05)
        }
        stack3.snp.makeConstraints(){
            $0.top.equalTo(calculateButton.snp.bottom).offset(10)
            $0.width.equalTo(calculateButton)
            $0.centerX.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.07)
        }
        summaryResultLabel.snp.makeConstraints(){
            $0.top.equalToSuperview().inset(5)
        }
        cupResultLabel.snp.makeConstraints(){
            $0.bottom.equalToSuperview().inset(5)
        }
        barChart.snp.makeConstraints(){
            $0.left.right.equalTo(calculateButton)
            $0.height.equalToSuperview().multipliedBy(0.2)
            $0.top.equalTo(stack3.snp.bottom).offset(10)
        }
        pieChart.snp.makeConstraints(){
            $0.left.right.equalTo(calculateButton)
            $0.bottom.equalToSuperview().inset(35)
            $0.top.equalTo(barChart.snp.bottom)
        }
    }
}
