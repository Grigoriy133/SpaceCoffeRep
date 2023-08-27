//
//  ViewController.swift
//  SpaceCoffe V3
//
//  Created by Grigoriy Korotaev on 11.05.2023.
//

import UIKit
import SnapKit

class AutorizationViewController: UIViewController {
    var aView = AutorizationView()
    var animate = UIViewPropertyAnimator()
    var currentRegime = regime.regular
    let registrationViewController = RegistrationViewController()
   
    override func loadView() {
        view = aView
        addDelegate()
        setupButtons()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        currentGlobalEnter(userName: settings.shared.currentUserName, userType: settings.shared.isUserOwner)
        loadUser()
        loadLastNumber()
    }
    override func viewWillAppear(_ animated: Bool) {
        keyButton.shared.view = view
        self.navigationController?.isNavigationBarHidden = true
       
    }
}

//MARK: - animation
extension AutorizationViewController {
    func animation(regime: regime){
        animate = UIViewPropertyAnimator(duration: 1, curve: .easeInOut)
        switch regime {
        case .regular:
            animate.addAnimations{
            self.aView.additionalView.frame.origin.y = -UIScreen.main.bounds.height / 7
        }
            currentRegime = .edit
        case .edit:
            animate.addAnimations{
            self.aView.additionalView.frame.origin.y = 0
        }
            currentRegime = .regular
    }
        animate.startAnimation()
    }
}
//MARK: - TextFieldDelegate
extension AutorizationViewController: UITextFieldDelegate{
    func addDelegate() {
        aView.textFieldPassword.delegate = self
        aView.textFieldPhone.delegate = self
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        animation(regime: currentRegime)
    }
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        animation(regime: currentRegime)
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == aView.textFieldPhone {
            let allowedCharacters = CharacterSet.decimalDigits
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)}
            return true
        }
}
//MARK: - ButtonFunction
extension AutorizationViewController{
    func setupButtons(){
        aView.buttonEnter.addTarget(self, action: #selector(enterButtonFunc), for: .touchUpInside)
        aView.buttonRegistration.addTarget(self, action: #selector(registrationButtonFunc), for: .touchUpInside)
    }
    @objc func enterButtonFunc(){
        let writtenPhone = aView.textFieldPhone.text ?? ""
        let writtenPassword = aView.textFieldPassword.text ?? ""

            if localUsersPasswordDictionary[writtenPassword] == writtenPhone && writtenPassword != "" {
                var userType = Bool()
                var userName = String()
                for user in localUserStorage {
                    if user.phone == writtenPhone {
                        userType = user.userType
                        userName = user.phone
                    }
                }
                settings.shared.settupCurrentUser(nameUser: userName, typeUser: userType)
                currentGlobalEnter(userName: userName, userType: userType)
                return
            } else {
               let alertErrorLoginPassword = reusableFunction.shared.summonAlertConroller(title: "Неверный номер телефона или пароль", message: "Попробуйте авторизоваться заново")
                present(alertErrorLoginPassword, animated: true)
            }
    }
    @objc func registrationButtonFunc(){
        navigationController?.pushViewController(registrationViewController, animated: true)
    }
}
//MARK: - EnterParametrs
extension AutorizationViewController{
    func currentGlobalEnter(userName: String, userType: Bool){
        let ownerViewController = OwnerTabBar()
        let userTabBar = MainUserTabBar()
        userTabBar.tabBar.backgroundColor = backgroundColorMain
        ownerViewController.tabBar.backgroundColor = backgroundColorMain
        
        settings.shared.loadSettings()
        
        if userName == "" {
                DataClass.share.loadUsersFromStorage()
        } else {
            if userType {
                navigationController?.pushViewController(ownerViewController, animated: true)
            } else {
                navigationController?.pushViewController(userTabBar, animated: true)
            }
        }
    }
}

//MARK: - CheckAutorization

extension AutorizationViewController{
    func loadUser(){
        if settings.shared.currentUserName != "" {
            currentGlobalEnter(userName: settings.shared.currentUserName, userType: settings.shared.isUserOwner)
        }
    }
    func loadLastNumber(){
        lastOrderNumber = UserDefaults.standard.integer(forKey: lastOrderKey)
    }
}

