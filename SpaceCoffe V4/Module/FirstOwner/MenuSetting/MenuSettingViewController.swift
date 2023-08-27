//
//  MenuSettingViewController.swift
//  SpaceCoffe V4
//
//  Created by Grigoriy Korotaev on 22.06.2023.
//

import UIKit
import SnapKit

class MenuSettingViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    let mSView = MenuSettingView()
    let addAView = AddAdvView()
    let addPView = addPromView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addDataSourceDelegats()
        configuratePicker()
    }
    override func loadView() {
        view = mSView
        configurateButtons()
        addViews()
    }
}

//MARK: - TableViewsConfigurate

extension MenuSettingViewController: UITableViewDelegate, UITableViewDataSource {
   
    func addDataSourceDelegats(){
        mSView.tableViewAdvertising.delegate = self
        mSView.tableViewAdvertising.dataSource = self
        mSView.tableViewPromo.delegate = self
        mSView.tableViewPromo.dataSource = self
        mSView.tableViewAdvertising.register(advCell.self, forCellReuseIdentifier: advCell.reuseId)
        mSView.tableViewPromo.register(promCell.self, forCellReuseIdentifier: promCell.reuseId)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView{
        case mSView.tableViewAdvertising:
            return generalAdvertisingArray.count
        case mSView.tableViewPromo:
            return promoArray.count
        default:  return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableView{
        case mSView.tableViewAdvertising:
            if let cell = tableView.dequeueReusableCell(withIdentifier: advCell.reuseId, for: indexPath) as? advCell{
                cell.advImageView.image = generalAdvertisingArray[indexPath.row].image
                cell.labelNumber.text = String(indexPath.row + 1) + " Акция"
                return cell
            }
            return UITableViewCell()
        
        case mSView.tableViewPromo:
            if let cell1 = tableView.dequeueReusableCell(withIdentifier: promCell.reuseId, for: indexPath) as? promCell{

                cell1.labelKey.text = " Ключ: " + promoArray[indexPath.row]
                cell1.labelValue.text = " Значение: " +  String(promocodesDictionary[promoArray[indexPath.row]] ?? 1)
                return cell1
            }
            return UITableViewCell()
            
        default: return UITableViewCell()
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        switch tableView{
        case mSView.tableViewAdvertising:
            let deleteAction = UIContextualAction(style: .destructive, title: "Delete") {  (contextualAction, view, boolValue) in
                let deletedText = generalAdvertisingArray[indexPath.row].terms
                DataClass.share.deleteAdverising(text: deletedText)
                self.mSView.tableViewAdvertising.reloadData()
            }
            let swipeActions = UISwipeActionsConfiguration(actions: [deleteAction])
            return swipeActions
        case mSView.tableViewPromo:
            let deleteAction = UIContextualAction(style: .destructive, title: "Delete") {  (contextualAction, view, boolValue) in
                let deletedKey = promoArray[indexPath.row]
                DataClass.share.deletePromo(key: deletedKey)
                self.mSView.tableViewPromo.reloadData()
            }
            let swipeActions = UISwipeActionsConfiguration(actions: [deleteAction])
            return swipeActions
       
        default: return UISwipeActionsConfiguration()
            
        }
    }
    
}

//MARK: - ButtonsFuncs

extension MenuSettingViewController {
    func configuratePicker(){
        addAView.imagePicker.delegate = self
        addAView.imagePicker.sourceType = .photoLibrary
        addAView.imagePicker.allowsEditing = false

    }
    func configurateButtons() {
        mSView.logOutButton.addTarget(self, action: #selector(logout), for: .touchUpInside)
        mSView.addButtonAdv.addTarget(self, action: #selector(add1), for: .touchUpInside)
        addAView.closeButton.addTarget(self, action: #selector(add1), for: .touchUpInside)
        addAView.buttonAddImage.addTarget(self, action: #selector(showPicker), for: .touchUpInside)
        addAView.acceptButton.addTarget(self, action: #selector(createNewAdv), for: .touchUpInside)
        mSView.addButtonPromo.addTarget(self, action: #selector(add2), for: .touchUpInside)
        addPView.closeButton.addTarget(self, action: #selector(add2), for: .touchUpInside)
        addPView.acceptButton.addTarget(self, action: #selector(createNewProm), for: .touchUpInside)
    }
    func addViews(){
        view.addSubview(addAView)
        view.addSubview(addPView)
    }
    @objc func add1(){
        animateView()
    }
    @objc func add2(){
        print(addPView.currentCondition)
        animateView2()
    }
    @objc func showPicker(){
        self.present(addAView.imagePicker, animated: true, completion: nil)
    }
    @objc func createNewAdv(){
        if addAView.promoImage.image != nil && addAView.promoTextView.text != "" {
            DataClass.share.saveAdvertising(image: addAView.promoImage.image ?? UIImage(), text: addAView.promoTextView.text)
            DataClass.share.loadAdvertising()
            mSView.tableViewAdvertising.reloadData()
            animateView()
        }
    }
    @objc func createNewProm(){
        if addPView.keyTextField.text != "" && addPView.valueTextField.text != "" {
            let newValue = Double(addPView.valueTextField.text ?? "1.0") ?? 1.0
            DataClass.share.savePromo(key: addPView.keyTextField.text ?? "error", value: newValue)
            DataClass.share.loadPromo()
            mSView.tableViewPromo.reloadData()
            animateView2()
        }
    }
    @objc func logout() {
        navigationController?.popToRootViewController(animated: true)
        settings.shared.currentUserName = ""
        settings.shared.isUserOwner = false
        settings.shared.settupCurrentUser(nameUser: "", typeUser: false)
        DataClass.share.loadUsersFromStorage()
    }
}

//MARK: - Animator

extension MenuSettingViewController {
    func animateView(){
        switch addAView.currentCondition {
        case .close:
            addAView.animator = UIViewPropertyAnimator(duration: 0.5 , curve: .easeInOut)
            addAView.animator.addAnimations {
                self.addAView.frame.origin.y = self.addAView.y2
            }
            addAView.animator.startAnimation()
            addAView.currentCondition = .open
        case .open:
            addAView.animator = UIViewPropertyAnimator(duration: 0.5 , curve: .easeInOut)
            addAView.animator.addAnimations {
                self.addAView.frame.origin.y = self.addAView.y1
            }
            addAView.animator.startAnimation()
            view.endEditing(true)
            addAView.currentCondition = .close
        }
    }
    func animateView2(){
        switch addPView.currentCondition {
        case .close:
            addPView.animator = UIViewPropertyAnimator(duration: 0.5 , curve: .easeInOut)
            addPView.animator.addAnimations {
                self.addPView.frame.origin.y = self.addPView.y2
            }
            addPView.animator.startAnimation()
            addPView.currentCondition = .open
        case .open:
            addPView.animator = UIViewPropertyAnimator(duration: 0.5 , curve: .easeInOut)
            addPView.animator.addAnimations {
                self.addPView.frame.origin.y = self.addPView.y1
            }
            addPView.animator.startAnimation()
            view.endEditing(true)
            addPView.currentCondition = .close
        }
    }
}

//MARK: - PickerDelegate

extension MenuSettingViewController {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        print("her")
        addAView.promoImage.image = selectedImage
        dismiss(animated: true, completion: nil)
    }

}
