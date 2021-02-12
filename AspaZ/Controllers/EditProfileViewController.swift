//
//  EditProfileViewController.swift
//  AspaZ
//
//  Created by Riza on 1/10/21.
//

import UIKit
import RealmSwift

protocol EditedProfileProtocol {
    func editProfile(name: String, phoneNumber: String, city: String, address: String)
}

class EditProfileViewController: UIViewController, UITextFieldDelegate {

    var editProfileDelegate: EditedProfileProtocol?
    let realm = try! Realm()
    var observer: NSObjectProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = #colorLiteral(red: 0.631372549, green: 0.0431372549, blue: 0.1647058824, alpha: 1)
        nameTextField.delegate = self
        phoneNumberTextField.delegate = self
        cityTextField.delegate = self
        addressTextField.delegate = self
        
        setupViews()
        
    }
    
    //MARK: - Setting UI
    
    let profileLabel: UILabel = {
        let profileLabel = UILabel()
        profileLabel.text = "Профиліңізді өзгертіңіз"
        profileLabel.numberOfLines = 1
        profileLabel.textColor = .white
        profileLabel.font = UIFont.boldSystemFont(ofSize: 26)
        profileLabel.textAlignment = .center
        return profileLabel
    }()
    
    let nameTextField: UITextField = {
       let nameTextField = UITextField()
        nameTextField.keyboardType = .default
        nameTextField.placeholder = "Аты-Жөніңіз"
        nameTextField.font = UIFont.systemFont(ofSize: 16)
        nameTextField.textColor = .black
        nameTextField.textAlignment = .left
        return nameTextField
    }()
    
    let phoneNumberTextField: UITextField = {
       let phoneNumberTextField = UITextField()
        phoneNumberTextField.keyboardType = .numberPad
        phoneNumberTextField.placeholder = "Телефон номеріңіз"
        phoneNumberTextField.font = UIFont.systemFont(ofSize: 16)
        phoneNumberTextField.textColor = .black
        phoneNumberTextField.textAlignment = .left
        return phoneNumberTextField
    }()
    
    let cityTextField: UITextField = {
       let cityTextField = UITextField()
        cityTextField.keyboardType = .default
        cityTextField.placeholder = "Қалаңыз"
        cityTextField.font = UIFont.systemFont(ofSize: 16)
        cityTextField.textColor = .black
        cityTextField.textAlignment = .left
        return cityTextField
    }()
    
    let addressTextField: UITextField = {
       let addressTextField = UITextField()
        addressTextField.keyboardType = .default
        addressTextField.placeholder = "Мекен-Жайыңыз"
        addressTextField.font = UIFont.systemFont(ofSize: 16)
        addressTextField.textColor = .black
        addressTextField.textAlignment = .left
        return addressTextField
    }()
    
    let nameContainer: UIView = {
        let nameContainer = UIView()
        nameContainer.backgroundColor = .white
        return nameContainer
    }()
    
    let phoneNumberContainer: UIView = {
        let phoneNumberContainer = UIView()
        phoneNumberContainer.backgroundColor = .white
        return phoneNumberContainer
    }()
    
    let cityContainer: UIView = {
        let cityContainer = UIView()
        cityContainer.backgroundColor = .white
        return cityContainer
    }()
    
    let addressContainer: UIView = {
        let addressContainer = UIView()
        addressContainer.backgroundColor = .white
        return addressContainer
    }()
    
    let saveButton: UIButton = {
        let saveButton = UIButton()
        saveButton.setTitle("Сақтау", for: .normal)
        saveButton.setTitleColor(.white, for: .normal)
        saveButton.titleLabel?.font = UIFont.systemFont(ofSize: 22)
        return saveButton
    }()
    
    @objc func saveTapped() {
        dismiss(animated: true, completion: nil)
        
        editProfileDelegate?.editProfile(name: nameTextField.text ?? "",
                                         phoneNumber: phoneNumberTextField.text ?? "",
                                         city:cityTextField.text ?? "",
                                         address: addressTextField.text ?? "")
        
        UserDefaults.standard.setValue(nameTextField.text, forKey: "name")
        UserDefaults.standard.setValue(phoneNumberTextField.text, forKey: "phoneNumber")
        UserDefaults.standard.setValue(cityTextField.text, forKey: "city")
        UserDefaults.standard.setValue(addressTextField.text, forKey: "address")
        
    }

    func setupViews() {
        
        view.addSubview(profileLabel)
        view.addSubview(nameContainer)
        view.addSubview(phoneNumberContainer)
        view.addSubview(cityContainer)
        view.addSubview(addressContainer)
        view.addSubview(saveButton)
        
        nameContainer.addSubview(nameTextField)
        phoneNumberContainer.addSubview(phoneNumberTextField)
        cityContainer.addSubview(cityTextField)
        addressContainer.addSubview(addressTextField)
        
        profileLabel.frame = CGRect(x: 30, y: 20, width: view.frame.width, height: 30)
        profileLabel.center.x = view.center.x
        
        nameContainer.frame = CGRect(x: 30, y: 80, width: 250, height: 30)
        nameContainer.center.x = view.center.x
        nameContainer.layer.cornerRadius = 5
        nameTextField.frame = CGRect(x: 10, y: 4, width: nameContainer.frame.width - 20, height: 20)
        
        phoneNumberContainer.frame = CGRect(x: 30, y: 140, width: 250, height: 30)
        phoneNumberContainer.center.x = view.center.x
        phoneNumberContainer.layer.cornerRadius = 5
        phoneNumberTextField.frame = CGRect(x: 10, y: 4, width: phoneNumberContainer.frame.width - 20, height: 20)
        
        cityContainer.frame = CGRect(x: 30, y: 200, width: 250, height: 30)
        cityContainer.center.x = view.center.x
        cityContainer.layer.cornerRadius = 5
        cityTextField.frame = CGRect(x: 10, y: 4, width: cityContainer.frame.width - 20, height: 20)
        
        addressContainer.frame = CGRect(x: 30, y: 260, width: 250, height: 30)
        addressContainer.center.x = view.center.x
        addressContainer.layer.cornerRadius = 5
        addressTextField.frame = CGRect(x: 10, y: 4, width: addressContainer.frame.width - 20, height: 20)
        
        saveButton.frame = CGRect(x: view.center.x - saveButton.frame.width / 4, y: 330, width: 120, height: 20)
        saveButton.center.x = view.center.x
        saveButton.addTarget(self, action: #selector(saveTapped), for: .touchUpInside)
        
    }
    
    //MARK: - TextField delegate methods
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameTextField.endEditing(true)
        phoneNumberTextField.endEditing(true)
        cityTextField.endEditing(true)
        addressTextField.endEditing(true)
        return true
    }
    
}
