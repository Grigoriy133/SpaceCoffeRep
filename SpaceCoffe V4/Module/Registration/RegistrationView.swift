
import UIKit
import SnapKit

class ViewRegistration: UIView {
   
    let imageViewMain = UIImageView()
    let textFieldPhone = UITextField()
    let textFieldPassword = UITextField()
    let buttonAccept = UIButton()
    let stackViews = UIStackView()
    let additionalView = UIView()
    
    init() {
        super.init(frame: .zero)
        setupViews()
        createButton()
        configurateKeyboard()
        createConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - UIView
    
    func setupViews(){
        addSubview(additionalView)
        additionalView.addSubview(imageViewMain)
        additionalView.addSubview(stackViews)
        stackViews.addSubview(textFieldPhone)
        stackViews.addSubview(textFieldPassword)
        additionalView.addSubview(buttonAccept)
        
        backgroundColor = backgroundColorMain
        
        imageViewMain.image = UIImage(named: "logo")
        imageViewMain.contentMode = .scaleAspectFill
        
        textFieldPhone.backgroundColor = UIColor(red: 234/255, green: 231/255, blue: 226/255, alpha: 1)
        textFieldPassword.backgroundColor = UIColor(red: 234/255, green: 231/255, blue: 226/255, alpha: 1)
        textFieldPhone.layer.cornerRadius = 10
        textFieldPassword.layer.cornerRadius = 10
        textFieldPhone.font = UIFont.systemFont(ofSize: 30 * kf)
        textFieldPassword.font = UIFont.systemFont(ofSize: 30 * kf)
        textFieldPhone.placeholder = "Телефон"
        textFieldPassword.placeholder = "Пароль"
    }
    func createButton(){
        buttonAccept.backgroundColor = buttonsGreenColor
        buttonAccept.layer.cornerRadius = 10
        buttonAccept.setTitle("Зарегестрироваться", for: .normal)
        buttonAccept.setTitleColor(.white, for: .normal)
    }
    func configurateKeyboard(){
        keyButton.shared.addDoneButtonOnKeyboard(textField: textFieldPhone)
        keyButton.shared.addDoneButtonOnKeyboard(textField: textFieldPassword)
    }
    func createConstraints(){
        additionalView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        
        imageViewMain.snp.makeConstraints{
            $0.top.equalToSuperview().inset(UIScreen.main.bounds.height * 0.15)
            $0.left.right.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.15)
            $0.width.equalToSuperview()
        }
        stackViews.snp.makeConstraints{
            $0.top.equalTo(imageViewMain.snp.bottom).offset(UIScreen.main.bounds.height * 0.15)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.9)
            $0.height.equalToSuperview().multipliedBy(0.3)
        }
        textFieldPhone.snp.makeConstraints{
            $0.top.left.right.equalToSuperview()
            $0.height.equalToSuperview().dividedBy(3.5)
        }
        textFieldPassword.snp.makeConstraints{
            $0.top.equalTo(textFieldPhone.snp.bottom).offset(30)
            $0.height.equalToSuperview().dividedBy(3.5)
            $0.width.equalToSuperview()
        }
        buttonAccept.snp.makeConstraints{
            $0.top.equalTo(stackViews.snp.bottom).offset(30)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(textFieldPassword)
            $0.width.equalTo(textFieldPassword)
        }
    }
    
    
}
