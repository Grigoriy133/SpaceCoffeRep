//
//  RegistrationViewController.swift
//  SpaceCoffe V3
//
//  Created by Grigoriy Korotaev on 17.05.2023.
//

import UIKit

class RegistrationViewController: UIViewController {

    let viewR = ViewRegistration()
    var currentRegime = regime.regular
    var animate = UIViewPropertyAnimator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addDelegate()
    }
    override func loadView() {
        view = viewR
        setupButtonFunc()
    }
    override func viewWillAppear(_ animated: Bool) {
        keyButton.shared.view = view
        refreshTextFields()
    }
//MARK: - Animation
    func animation(regime: regime){
        animate = UIViewPropertyAnimator(duration: 1, curve: .easeInOut)
        switch regime {
        case .regular:
            animate.addAnimations{
            self.viewR.additionalView.frame.origin.y = -UIScreen.main.bounds.height / 7
        }
            currentRegime = .edit
        case .edit:
            animate.addAnimations{
            self.viewR.additionalView.frame.origin.y = 0
        }
            currentRegime = .regular
    }
        animate.startAnimation()
    }
}
//MARK: - TextFieldDelegate
extension RegistrationViewController: UITextFieldDelegate{
    func addDelegate() {
        viewR.textFieldPassword.delegate = self
        viewR.textFieldPhone.delegate = self
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        animation(regime: currentRegime)
    }
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        animation(regime: currentRegime)
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == viewR.textFieldPhone {
            let allowedCharacters = CharacterSet.decimalDigits
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)}
            return true
        }
    func refreshTextFields(){
        viewR.textFieldPhone.text = ""
        viewR.textFieldPassword.text = ""
    }
}
//MARK: - ButtonFunction

extension RegistrationViewController {
    func setupButtonFunc(){
        viewR.buttonAccept.addTarget(self, action: #selector(acceptFunc), for: .touchUpInside)
    }
    @objc func acceptFunc(){
        let password1 = viewR.textFieldPassword.text ?? ""
        let phone1 = viewR.textFieldPhone.text ?? ""
        if checkPassword(password: password1)&&checkPhone(phone: phone1)&&checkIsThisPhoneRegistratedAlready(phone: phone1){
            let newUser = user(userType: false, password: password1, phone: phone1, id: 1, registrationDate: Date())
            DataClass.share.saveUser(newUser: newUser)
            DataClass.share.loadUsersFromStorage()
            navigationController?.popViewController(animated: true)
        }
    }
    func checkPassword(password: String) -> Bool {
        if password.count < 7 {
            let alertError = reusableFunction.shared.summonAlertConroller(title: "Слишком короткий пароль", message: "Минимально 6 символов")
            present(alertError, animated: true)
            return false
        }
        return true
    }
    func checkPhone(phone: String) -> Bool {
        if phone.count != 11 {
            let alertError = reusableFunction.shared.summonAlertConroller(title: "Неверный телефон", message: "Формат 79992392007")
            present(alertError, animated: true)
            return false
        }
        return true
    }
    func checkIsThisPhoneRegistratedAlready(phone: String) -> Bool {
        DataClass.share.loadUsersFromStorage()
        var i = 0
        for user in localUserStorage{
            if user.phone == phone {
                i = 1
            }
        }
        switch i{
        case 0: return true
        default:
            let alertError = reusableFunction.shared.summonAlertConroller(title: "Пользователь существует", message: "")
            present(alertError, animated: true)
            return false
        }
        
    }
}


