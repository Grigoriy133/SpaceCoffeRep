//
//  userMainViewController.swift
//  SpaceCoffe V3
//
//  Created by Grigoriy Korotaev on 15.05.2023.
//

import UIKit

class userMainViewController: UIViewController {
    
    var uMView = userMainView()
    var advertisingNumber = CGFloat()
    var orderView = ProductsView()
    var advertisingView = AdvertisingView()
    var selectedCoffeCup : coffe?
    var secondP = Int()
    
    override func loadView() {
        view = uMView
        view.addSubview(orderView)
        view.addSubview(advertisingView)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        DataClass.share.loadAdvertising()
        DataClass.share.loadPromo()
        calculateNumberItems()
        setupViews()
        setupDelegate()
        createMenu()
        setupRecognizerAndButtonsTarget()
    }
    override func viewDidAppear(_ animated: Bool) {
        tabBarController?.tabBar.barStyle = .black
    }

//MARK: - Views
 
    func setupViews(){
        
        let layout = createLayoutAdvertising()
        let layout2 = createLayoutAProducts()

        uMView.advertisingCollection.collectionViewLayout = layout
        uMView.productsCollection.collectionViewLayout = layout2
        uMView.advertisingCollection.register(CollectionViewCellAdvertising.self, forCellWithReuseIdentifier: CollectionViewCellAdvertising.reuseId)
        uMView.productsCollection.register(CollectionViewCellProducts.self, forCellWithReuseIdentifier: CollectionViewCellProducts.reuseId)
    }
    
    func setupDelegate(){
        uMView.advertisingCollection.dataSource = self
        uMView.advertisingCollection.delegate = self
        uMView.productsCollection.dataSource = self
        uMView.productsCollection.delegate = self
    }
    //MARK: - CreateLayout
    
    func createLayoutAdvertising() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            let section = NSCollectionLayoutSection(group: self.createGroupAdvertising())
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 20)
            return section
        }
        layout.configuration.scrollDirection = .horizontal
        return layout
    }
    
    func createLayoutAProducts() -> UICollectionViewCompositionalLayout {
    let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
        let section = NSCollectionLayoutSection(group: self.createGroupProducts())
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
        return section
    }
        layout.configuration.scrollDirection = .horizontal
        return layout
    }

    func createGroupAdvertising() -> NSCollectionLayoutGroup {
        let item1 = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .absolute(UIScreen.main.bounds.width - 20), heightDimension: .fractionalHeight(1)))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .absolute(((UIScreen.main.bounds.width - 20) * advertisingNumber) + (advertisingNumber * 20)), heightDimension: .fractionalHeight(1)), subitems: [item1])
        group.interItemSpacing = .fixed(20)
        return group
    }
    
    func createGroupProducts() -> NSCollectionLayoutGroup {
        let item1 = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.465), heightDimension: .fractionalHeight(0.9)))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.4)), subitems: [item1])
        group.interItemSpacing = .fixed(20)
        return group
    }
    //MARK: - DataGenerate
        func createMenu(){
            products.shared.createCafeElement(vname: cafeType.coffe, name: "Cappuchino", capacity: 200, image: "cap1", price: 99)
            products.shared.createCafeElement(vname: cafeType.coffe, name: "Latte", capacity: 200, image: "lat1", price: 99)
            products.shared.createCafeElement(vname: cafeType.coffe, name: "Espresso", capacity: 50, image: "espr1", price: 49)
            products.shared.createCafeElement(vname: cafeType.coffe, name: "Raph", capacity: 200, image: "raf1", price: 149)
            products.shared.createCafeElement(vname: cafeType.coffe, name: "Americano", capacity: 100, image: "a1", price: 99)
            products.shared.createCafeElement(vname: cafeType.coffe, name: "Mocko", capacity: 200, image: "mok1", price: 149)
            products.shared.createCafeElement(vname: cafeType.coffe, name: "Chocolate", capacity: 200, image: "choc1", price: 99)
        }
    func calculateNumberItems(){
        advertisingNumber = CGFloat(generalAdvertisingArray.count)
    }
}
extension userMainViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var number = 0
        switch collectionView {
        case uMView.advertisingCollection: number = generalAdvertisingArray.count
        case uMView.productsCollection: number = products.shared.arrayCafe.count
        default: number = 1
        }
        return number
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var newCell = UICollectionViewCell()
        switch collectionView {
        case uMView.advertisingCollection:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellAdvertising.reuseId, for: indexPath) as? CollectionViewCellAdvertising {
                cell.advImageView.image = generalAdvertisingArray[indexPath.row].image
                newCell = cell
            }
        case uMView.productsCollection:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellProducts.reuseId, for: indexPath) as? CollectionViewCellProducts {
                cell.prodImageView.image = UIImage(named: products.shared.arrayCafe[indexPath.row].image)
                cell.priceLabel.text = "От " + String(products.shared.arrayCafe[indexPath.row].price) + " Р"
                newCell = cell }
        default : newCell = UICollectionViewCell()
            
        }
        return newCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case uMView.productsCollection:
            orderView.imageViewProduct.image = UIImage(named: products.shared.arrayCafe[indexPath.row].image)
            
            
            selectedCoffeCup = coffe(name: products.shared.arrayCafe[indexPath.row].name, capacity: products.shared.arrayCafe[indexPath.row].capacity, image: products.shared.arrayCafe[indexPath.row].image, price: products.shared.arrayCafe[indexPath.row].price)
            configurateOrdersView()
            orderView.segmentCapacity.selectedSegmentIndex = 1
                                     
        animateOrderView()
            
        case uMView.advertisingCollection:
            advertisingView.advertisingImageView.image = generalAdvertisingArray[indexPath.row].image
            advertisingView.termsLabel.text = generalAdvertisingArray[indexPath.row].terms
            animateAdvertisingView()
        default: break
        }
        
    }
}

//MARK: - Animation

extension userMainViewController {
    func setupRecognizerAndButtonsTarget(){
        self.uMView.tapGestureRecognizer.addTarget(self, action: #selector(tap1))
        self.orderView.closeButton.addTarget(self, action: #selector(closeButton), for: .touchUpInside)
        self.orderView.segmentCapacity.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
        self.advertisingView.closeButton.addTarget(self, action: #selector(closeButtonA), for: .touchUpInside)
        self.orderView.enterButton.addTarget(self, action: #selector(appendToBasket), for: .touchUpInside)
    }
    
    @objc func tap1(){
        switch uMView.currentCondition{
        case .close:
            uMView.animator = UIViewPropertyAnimator(duration: 1, curve: .easeInOut)
            uMView.animator.addAnimations {
                let rotationTransform = CGAffineTransform(rotationAngle: -.pi / 2)
                let scaleTransform = CGAffineTransform(scaleX: 3, y: 1.5)
                self.uMView.cardView.transform = rotationTransform.concatenating(scaleTransform)
                self.uMView.cardView.frame.origin.y = 100
                self.uMView.currentCondition = .open
            }
        case .open:
            self.uMView.animator = UIViewPropertyAnimator(duration: 1, curve: .easeInOut)
            self.uMView.animator.addAnimations {
                let rotationTransform = CGAffineTransform(rotationAngle: 2 * .pi)
                let scaleTransform = CGAffineTransform(scaleX: 1, y: 1)
                self.uMView.cardView.transform = rotationTransform.concatenating(scaleTransform)

                self.uMView.cardView.frame.origin.y = self.uMView.y1
                self.uMView.currentCondition = .close
            }
        }
        self.uMView.animator.startAnimation()
    }

    func animateOrderView(){
        switch orderView.currentCondition {
        case .close:
            orderView.animator = UIViewPropertyAnimator(duration: 0.5 , curve: .easeInOut)
            orderView.animator.addAnimations {
                self.orderView.frame.origin.y = self.orderView.y2
            }
            orderView.animator.startAnimation()
            orderView.currentCondition = .open
        case .open:
            orderView.animator = UIViewPropertyAnimator(duration: 0.5 , curve: .easeInOut)
            orderView.animator.addAnimations {
                self.orderView.frame.origin.y = self.orderView.y1
            }
            orderView.animator.startAnimation()
            orderView.currentCondition = .close
        }
    }
    
    func animateAdvertisingView(){
        switch advertisingView.currentCondition {
    case .close:
            advertisingView.animator = UIViewPropertyAnimator(duration: 0.5 , curve: .easeInOut)
            advertisingView.animator.addAnimations {
            self.advertisingView.frame.origin.y = self.advertisingView.y2
        }
            advertisingView.animator.startAnimation()
            advertisingView.currentCondition = .open
    case .open:
            advertisingView.animator = UIViewPropertyAnimator(duration: 0.5 , curve: .easeInOut)
            advertisingView.animator.addAnimations {
            self.advertisingView.frame.origin.y = self.advertisingView.y1
        }
            advertisingView.animator.startAnimation()
            advertisingView.currentCondition = .close
    }
    }
}

//MARK: - ModalViewController
extension userMainViewController {
    @objc func closeButton(){
        animateOrderView()
    }
    @objc func closeButtonA(){
        animateAdvertisingView()
    }
     func tap1segment(){
        orderView.sizeLabel.text = "Medium"
         orderView.priceLabel.text = String(selectedCoffeCup?.price ?? 0) + " рублей"
    }
     func tap2segment(){
        orderView.sizeLabel.text = "Large"
        orderView.priceLabel.text = String(secondP) + " рублей"
    }
    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            tap1segment()
        case 1:
            tap2segment()
        default:
            break
        }
    }
    @objc func appendToBasket(){
        let name = selectedCoffeCup?.name ?? ""
        let image = selectedCoffeCup?.image ?? ""
        let capacity = tranformString(string: orderView.segmentCapacity.titleForSegment(at: orderView.segmentCapacity.selectedSegmentIndex) ?? "0")
        let price = tranformString(string: orderView.priceLabel.text ?? "0")
        
        let newOrderedProduct = coffe(name: name, capacity: capacity, image: image, price: price)
        basketArray.append(newOrderedProduct)
        basketBadge()
        animateOrderView()
    }
    func basketBadge(){
        if let tabBarController = self.tabBarController {
            if let basketVC = tabBarController.viewControllers?[2] as? UsersBasketViewController {
                basketVC.tabBarItem.badgeValue = String(basketArray.count)
            }
        }
    }
}

//MARK: - ConfigurateOrdersUI

extension userMainViewController {
    func tranformString(string: String) -> Int {
       var newNumber = String()
        for char in string {
            if char.isNumber {
                newNumber += String(char)
            }
        }
        return Int(newNumber) ?? 0
    }
    func configurateOrdersView(){
        let firstC = selectedCoffeCup?.capacity ?? 0
        let secondC = (((selectedCoffeCup?.capacity ?? 0) + 1) * 2) - 2
        secondP = (selectedCoffeCup?.price ?? 0 + 1) * 3/2 - 2
        orderView.segmentCapacity.setTitle(String(firstC)  + " мл", forSegmentAt: 0)
        orderView.segmentCapacity.setTitle(String(secondC) + " мл", forSegmentAt: 1)
        orderView.priceLabel.text = String(secondP) + " рублей"
    }
}
