//
//  UsersBasketViewController.swift
//  SpaceCoffe V4
//
//  Created by Grigoriy Korotaev on 06.06.2023.
//

import UIKit

class UsersBasketViewController: UIViewController {

    static let share = UsersBasketViewController()
    var basketView = BasketView()
    var promoView = PromoView()
    var summ = 0
    var isTimerWorking = false
    
    override func viewDidLoad() {
        super.viewDidLoad()        
    }
    override func viewDidAppear(_ animated: Bool) {
        basketView.basketsTableView.reloadData()
        calculateResult()
        checkTable()
    }
    override func loadView() {
        view = basketView
        configurateTableView()
        configurateButtons()
        view.addSubview(promoView)
    }
    
    func configurateTableView(){
        basketView.basketsTableView.register(BasketCellTableViewCell.self, forCellReuseIdentifier: BasketCellTableViewCell.reuseId)
        basketView.basketsTableView.delegate = self
        basketView.basketsTableView.dataSource = self
    }
    func basketBadge(){
        if let tabBarController = self.tabBarController {
            if let basketVC = tabBarController.viewControllers?[2] as? UsersBasketViewController {
                basketVC.tabBarItem.badgeValue = String(basketArray.count)
            }
        }
    }
    func calculateResult(){
        
        summ = 0
        for cup in basketArray{
            summ += cup.price
        }
        if isPromoActivate == false {
            basketView.finalWealthLabel.text = String(summ) + " рублей" } else {
                basketView.finalWealthLabel.text = String(Double(summ) * promoKf) + " рублей"
            }
    }

}
extension UsersBasketViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        basketArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: BasketCellTableViewCell.reuseId, for: indexPath) as? BasketCellTableViewCell {
            cell.productImage.image = UIImage(named: basketArray[indexPath.row].image) ?? UIImage()
            
            cell.nameLabel.text = basketArray[indexPath.row].name
            cell.priceLabel.text = String(basketArray[indexPath.row].price) + "Рублей"
            cell.capacityLabel.text = String(basketArray[indexPath.row].capacity) + "Мл"
            cell.buttonMinusFunc = {
                basketArray.remove(at: indexPath.row)
                self.basketBadge()
                self.basketView.basketsTableView.reloadData()
                self.calculateResult()
            }
            cell.buttonPlusFunc = {
                basketArray.append(basketArray[indexPath.row])
                self.basketView.basketsTableView.reloadData()
                self.calculateResult()
            }
            return cell
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

//MARK: - ConfigurateButtons

extension UsersBasketViewController {
    func configurateButtons(){
        basketView.cleanButton.addTarget(self, action: #selector(clean), for: .touchUpInside)
        basketView.promocodeButton.addTarget(self, action: #selector(openClosePromo), for: .touchUpInside)
        promoView.closeButton.addTarget(self, action: #selector(openClosePromo), for: .touchUpInside)
        promoView.acceptButton.addTarget(self, action: #selector(checkPromo), for: .touchUpInside)
        basketView.acceptButton.addTarget(self, action: #selector(accept), for: .touchUpInside)
    }
    @objc func clean(){
        basketArray = [cafe]()
        basketView.basketsTableView.reloadData()
        basketBadge()
        isPromoActivate = false
        promoKf = 1
        calculateResult()
        basketView.promocodeButton.isEnabled = true
        basketView.promocodeButton.setTitle("Промокод", for: .normal)
        promoView.promoTextField.text = ""
    }
    @objc func checkPromo(){
        let promo = promoView.promoTextField.text!
        calculateResult()
        animateAdvertisingView()

        if promoArray.contains(promo) {
            promoKf = promocodesDictionary[promo] ?? 1
            isPromoActivate = true
            calculateResult()
            basketView.promocodeButton.isEnabled = false
            basketView.promocodeButton.setTitle("Промокод активирован ✓", for: .normal)
        }
    }
    @objc func openClosePromo(){
        animateAdvertisingView()
    }
    @objc func accept(){
        createNewOrder()
    }
}

//MARK: - Animator

extension UsersBasketViewController {
    func animateAdvertisingView(){
        switch promoView.currentCondition {
    case .close:
            promoView.animator = UIViewPropertyAnimator(duration: 0.5 , curve: .easeInOut)
            promoView.animator.addAnimations {
            self.promoView.frame.origin.y = self.promoView.y2
        }
            promoView.animator.startAnimation()
            promoView.currentCondition = .open
    case .open:
            promoView.animator = UIViewPropertyAnimator(duration: 0.5 , curve: .easeInOut)
            promoView.animator.addAnimations {
            self.promoView.frame.origin.y = self.promoView.y1
        }
            promoView.animator.startAnimation()
            view.endEditing(true)
            promoView.currentCondition = .close
    }
    }
    func checkTable(){
        if basketArray.count == 0 {
            basketView.basketsTableView.alpha = 0
            basketView.conditionalLabel.text = "Тут пока пусто 😔"
        } else {
            basketView.basketsTableView.alpha = 1
        }
    }
}
//MARK: - CreateNewOrderFunctions

extension UsersBasketViewController {
    func createNewOrder(){
        lastOrderNumber += 1
        let newOrder = order(userPhone: settings.shared.currentUserName , dateOrder: Date(), numberOrder: String(lastOrderNumber), basket: basketArray)
        DataClass.share.saveOrder(arrayProducts: newOrder.basket, userPhone: newOrder.userPhone, dateOrder: newOrder.dateOrder, numberOrder: newOrder.numberOrder)
        UserDefaults.standard.set(lastOrderNumber, forKey: lastOrderKey)
        telegramSender.shared.telegramRequest(message: telegramSender.shared.transform(order: newOrder))
        clean()
    }
}
