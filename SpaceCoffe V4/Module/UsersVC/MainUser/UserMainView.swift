//
//  userMainView.swift
//  SpaceCoffe V3
//
//  Created by Grigoriy Korotaev on 29.05.2023.
//

import UIKit
import SnapKit


class userMainView: UIView {

    var scrollViewMain = UIScrollView()
    var cardView = UIView()

    // MARK: var to Animator
    let tapGestureRecognizer = UITapGestureRecognizer()
    var animator = UIViewPropertyAnimator()
    var currentCondition = ConditionView.close
    var w1 = CGFloat()
    var h1 = CGFloat()
    var x1 = CGFloat()
    var y1 = CGFloat()
    
    var productsCollection = {
        let collectionLayout = UICollectionViewLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionLayout)
        collectionView.backgroundColor = backgroundColorMain
        collectionView.bounces = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    var advertisingCollection  = {
        let collectionLayout = UICollectionViewLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionLayout)
        collectionView.isPagingEnabled = true
        //не оттягивалась View
        collectionView.bounces = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    init() {
        super.init(frame: .zero)
        setupView()
        makeconstraints()
        calculateAnimatorVar()
        configurateCard()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//MARK: - Views
    
    func setupView(){
        addSubview(scrollViewMain)
        scrollViewMain.contentSize = CGSize(width: scrollViewMain.frame.size.width, height: scrollViewMain.frame.size.height)
        advertisingCollection.backgroundColor = backgroundColorMain
        
        scrollViewMain.isScrollEnabled = true
        scrollViewMain.addSubview(advertisingCollection)
        scrollViewMain.addSubview(productsCollection)
        scrollViewMain.addSubview(cardView)
        scrollViewMain.backgroundColor = backgroundColorMain
    }
    
    //MARK: - Constraints
    func makeconstraints(){
        scrollViewMain.snp.makeConstraints(){
            $0.size.equalToSuperview()
        }
        advertisingCollection.snp.makeConstraints(){
            $0.left.right.equalToSuperview()
            $0.top.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalToSuperview().dividedBy(6)
        }
        productsCollection.snp.makeConstraints(){
            $0.centerX.equalToSuperview()
            $0.top.equalTo(advertisingCollection.snp.bottom).offset(UIScreen.main.bounds.height / 40)
            $0.width.equalToSuperview().multipliedBy(0.95)
            $0.height.equalToSuperview().multipliedBy(0.5)
        }
    }
    
}

//MARK: - ANimation

extension userMainView {
    func calculateAnimatorVar(){
        let bounds = UIScreen.main.bounds
        w1 = bounds.width / 1.1
        h1 = bounds.height / 8
        x1 = bounds.width * 0.05
        y1 = bounds.height * 5.7/8
    }
    func configurateCard(){
        cardView.frame = CGRect(x: x1, y: y1, width: w1, height: h1)
        cardView.backgroundColor = pinkColor
        cardView.layer.cornerRadius = 15
        cardView.layer.zPosition = 2
        cardView.addGestureRecognizer(tapGestureRecognizer)
    }
   
}
