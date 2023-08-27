//
//  UsersDataViewController.swift
//  SpaceCoffe V4
//
//  Created by Grigoriy Korotaev on 06.06.2023.
//

import UIKit

class UsersDataViewController: UIViewController {

    let uDView = UsersDataView()
    let oSView = productStoryView()
    var currentArray = [order]()
    var currentOrder = order()
    let refreshControl = UIRefreshControl()
    

    let formatter = DateFormatter()

    override func viewDidLoad() {
        super.viewDidLoad()
        loadCurrentOrdersHistory()
        configurateTableView()
        dateConfigurate()
        view.addSubview(oSView)
    }
    override func loadView() {
        view = uDView
        setupButtonAction()
        createRefresh()
    }
    override func viewDidAppear(_ animated: Bool) {
        loadCurrentOrdersHistory()
        uDView.ordersStoryTable.reloadData()
    }
    
    func dateConfigurate(){
        formatter.dateFormat = "dd.MM.yyyy HH:mm"
    }
    func calculateWorth(order: order) -> String {
        var summ = 0
        for product in order.basket {
            summ += product.price
        }
        return String(summ)
    }
}
//MARK: - SetupButton
extension UsersDataViewController {
    func setupButtonAction(){
        uDView.singoutButton.addTarget(self, action: #selector(logOut), for: .touchUpInside)
    }
   @objc func logOut(){
        navigationController?.popToRootViewController(animated: true)
        settings.shared.currentUserName = ""
        settings.shared.isUserOwner = false
       settings.shared.settupCurrentUser(nameUser: "", typeUser: false)
       DataClass.share.loadUsersFromStorage()
    }
}
//MARK: - LoadOrderData
extension UsersDataViewController{
    func loadCurrentOrdersHistory(){
        currentArray = [order]()
        DataClass.share.loadOrders()
        for order in orderStorage {
            if order.userPhone == settings.shared.currentUserName {
                currentArray.append(order)
            }
        }
    }
}
//MARK: - TableViewDataSourse
extension UsersDataViewController: UITableViewDelegate, UITableViewDataSource {
    func configurateTableView(){
        uDView.ordersStoryTable.register(OrdersHistoryCell.self, forCellReuseIdentifier: OrdersHistoryCell.reuseId)
        uDView.ordersStoryTable.dataSource = self
        uDView.ordersStoryTable.delegate = self
        
        oSView.storyTableView.register(ProductStoryCell.self, forCellReuseIdentifier: ProductStoryCell.reuseId)
        oSView.storyTableView.delegate = self
        oSView.storyTableView.dataSource = self
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case uDView.ordersStoryTable:
            return currentArray.count
        case oSView.storyTableView:
            return currentOrder.basket.count
        default:
            return 0
        }
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableView {
        case uDView.ordersStoryTable:
            if let cell = tableView.dequeueReusableCell(withIdentifier: OrdersHistoryCell.reuseId, for: indexPath) as? OrdersHistoryCell {
                let date = currentArray[indexPath.row].dateOrder
                cell.dateLabel.text = "Дата/Время заказа: " + formatter.string(from: date)
                cell.numberLabel.text = "Номер заказа:  " + String(currentArray[indexPath.row].numberOrder)
                cell.priceLabel.text = calculateWorth(order: currentArray[indexPath.row]) + " Руб"
                return cell
            }
            return UITableViewCell()
        case oSView.storyTableView:
            if let cell = tableView.dequeueReusableCell(withIdentifier: ProductStoryCell.reuseId, for: indexPath) as? ProductStoryCell {
                cell.productImage.image = UIImage(named: currentOrder.basket[indexPath.row].image)
                cell.priceLabel.text = String(currentOrder.basket[indexPath.row].price) + " Руб"
                cell.nameLabel.text = currentOrder.basket[indexPath.row].name
                cell.capacityLabel.text = String(currentOrder.basket[indexPath.row].capacity) + " Мл"
                return cell
            }
            return UITableViewCell()
        
        default:
            return UITableViewCell()
        }
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch tableView{
        case uDView.ordersStoryTable:
            return 50
        default:
            return 80
        }
       
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch tableView{
        case uDView.ordersStoryTable:
            currentOrder = currentArray[indexPath.row]
            animateOrderView()
            oSView.storyTableView.reloadData()
        default: break
        }
        
    }
}
extension UsersDataViewController {
    // MARK: - Refresh
    func createRefresh() {
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        refreshControl.tintColor = UIColor.clear
        uDView.ordersStoryTable.addSubview(refreshControl)
        oSView.closeButton.addTarget(self, action: #selector(cancelButton), for: .touchUpInside)
    }
    @objc func refreshData() {
        loadCurrentOrdersHistory()
        uDView.ordersStoryTable.reloadData()
        refreshControl.endRefreshing()
    }
}

// MARK: - Animation

extension UsersDataViewController {
    func animateOrderView(){
        switch oSView.currentCondition {
        case .close:
            oSView.animator = UIViewPropertyAnimator(duration: 0.5 , curve: .easeInOut)
            oSView.animator.addAnimations {
                self.oSView.frame.origin.y = self.oSView.y2
            }
            oSView.animator.startAnimation()
            oSView.currentCondition = .open
        case .open:
            oSView.animator = UIViewPropertyAnimator(duration: 0.5 , curve: .easeInOut)
            oSView.animator.addAnimations {
                self.oSView.frame.origin.y = self.oSView.y1
            }
            oSView.animator.startAnimation()
            oSView.currentCondition = .close
        }
    }
    @objc func cancelButton(){
        animateOrderView()
    }
}


