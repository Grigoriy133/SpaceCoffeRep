//
//  ownerMainViewController.swift
//  SpaceCoffe V3
//
//  Created by Grigoriy Korotaev on 15.05.2023.
//

import UIKit
import Charts

class StatisticViewController: UIViewController {

    let sview = StatView()
    var ordersArrayDuration = [order]()
    var DataArray = [cafe]()
    var startDate = Date()
    var endDate = Date()
    var newProductArray = [cafe]()
    
    var barDataSet = [barStruct]()
    var pieDataSet = [pieStruct]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DataClass.share.loadAdvertising()
        DataClass.share.loadPromo()
        sview.barChart.drawBarShadowEnabled = false
    }
    override func loadView() {
        view = sview
        sview.calculateButton.addTarget(self, action: #selector(tap1), for: .touchUpInside)
    }
    @objc func tap1(){
        segregateProductBar()
        segregateProductPie()
        calculateResult()
    }
}

extension StatisticViewController: ChartViewDelegate {
    func configurateChartsBar(){
        sview.barChart.delegate = self
        
        var entries = [BarChartDataEntry]()
        var i = 1
        barDataSet.forEach{ element in
            entries.append(BarChartDataEntry(x: Double(i)
                                             , y: Double(element.productArray.count)))
            i += 1
        }
        let set = BarChartDataSet(entries: entries)
        set.colors = ChartColorTemplates.pastel()
        let data = BarChartData(dataSet: set)
        sview.barChart.data = data
    }
    
    func configurateChartsPie(){
     
        var dataEntries: [PieChartDataEntry] = []

        pieDataSet.forEach { element in
            let quotient = ( Double(element.productArray.count) / Double(converteOrderToProduct(array: ordersArrayDuration).count ) ) * 100
            dataEntries.append(PieChartDataEntry(value: Double(element.productArray.count), label: element.name + "" + String(Int(quotient)) + " %"))
        }
        let pieChartDataSet = PieChartDataSet(entries: dataEntries, label: "")
        pieChartDataSet.colors = ChartColorTemplates.material()
        pieChartDataSet.sliceSpace = 2.0
        sview.pieChart.data = PieChartData(dataSet: pieChartDataSet)
    }
}

//MARK: - GenerateData

extension StatisticViewController{
    func loadDataDuration(){
        startDate = sview.datePickerFrom.date
        endDate = sview.datePickerTo.date
 
        DataClass.share.loadOrders()
        DataArray = [cafe]()
        ordersArrayDuration = orderStorage.filter { (element) -> Bool in
            return element.dateOrder >= startDate && element.dateOrder <= endDate
        }
    }
    func segregateProductBar(){
       loadDataDuration()
        barDataSet = [barStruct]()
        let calendar = Calendar.current
        var date1 = startDate
        
        repeat {
            var newProductArray = [order]()
            ordersArrayDuration.forEach { order in
                let result = calendar.compare(date1, to: order.dateOrder, toGranularity: .day)
                if result == .orderedSame {
                    newProductArray.append(order)
                }
            }
            let newBarStruct = barStruct(dateSince1970: date1.timeIntervalSince1970, productArray: converteOrderToProduct(array: newProductArray))
            barDataSet.append(newBarStruct)
            date1 += TimeInterval(86400)
        } while date1 <= endDate
        configurateChartsBar()
    }
    func converteOrderToProduct(array: [order]) -> [cafe]{
       var newArray = [cafe]()
        array.forEach { order in
            newArray += order.basket
        }
        return newArray
    }
    
    func segregateProductPie(){
        pieDataSet = [pieStruct]()
        
        newProductArray = converteOrderToProduct(array: ordersArrayDuration)
        var namesArray = [String]()
        for element in newProductArray {
            if namesArray.contains(element.name) == false {
                namesArray.append(element.name)
            }
        }
        for i in namesArray {
            var newArrayProducts = [cafe]()
            var name1 = String()
            for element in newProductArray {
                if element.name == i {
                    newArrayProducts.append(element)
                    name1 = i
                }
            }
        let newStruct = pieStruct(name: name1, productArray: newArrayProducts)
            pieDataSet.append(newStruct)
        }
        configurateChartsPie()
    }
    func calculateResult(){
        
        sview.cupResultLabel.text = " Кол-во кружек в период: "
        sview.summaryResultLabel.text = " Выручка за период: "
        
        var summ = 0
        var number = 0
        newProductArray.forEach { product in
            number += 1
            summ += product.price
        }
        sview.summaryResultLabel.text! += " " + String(summ) + " Руб"
        sview.cupResultLabel.text! += " " + String(number) + " Стаканов"
    }
}
