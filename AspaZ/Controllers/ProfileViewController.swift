//
//  ProfileViewController.swift
//  AspaZ
//
//  Created by Riza on 12/23/20.
//

import UIKit
import RealmSwift
import Firebase

class ProfileViewController: UIViewController, EditedProfileProtocol {
    
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        title = "Профиліңіз"
        view.backgroundColor = .white
    
        setupViews()
        showProfile()
        
        if Auth.auth().currentUser?.uid == nil {
            performSelector(onMainThread: #selector(logoutTapped), with: nil, waitUntilDone: false)
        }
    }
    
    //MARK: - Setting UI
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "milkgirl")
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.numberOfLines = 1
//        nameLabel.text = ""
        nameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        nameLabel.textColor = .white
        nameLabel.textAlignment = .left
        return nameLabel
    }()
    
    let phoneNumberLabel: UILabel = {
        let phoneNumberLabel = UILabel()
        phoneNumberLabel.numberOfLines = 1
//        phoneNumberLabel.text = ""
        phoneNumberLabel.font = UIFont.boldSystemFont(ofSize: 16)
        phoneNumberLabel.textColor = .white
        phoneNumberLabel.textAlignment = .left
        return phoneNumberLabel
    }()
    
    let cityLabel: UILabel = {
        let cityLabel = UILabel()
        cityLabel.numberOfLines = 1
//        cityLabel.text = ""
        cityLabel.font = UIFont.boldSystemFont(ofSize: 16)
        cityLabel.textColor = .white
        cityLabel.textAlignment = .left
        return cityLabel
    }()
    
    let addressLabel: UILabel = {
        let addressLabel = UILabel()
        addressLabel.numberOfLines = -1
//        addressLabel.text = ""
        addressLabel.font = UIFont.boldSystemFont(ofSize: 16)
        addressLabel.textColor = .white
        addressLabel.textAlignment = .left
        return addressLabel
    }()
    
    let editProfileButton: UIButton = {
        let editButton = UIButton()
        editButton.setTitle("Профильді өзгерту", for: .normal)
        editButton.setTitleColor(.black, for: .normal)
        editButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 22)
        return editButton
    }()
    
    let backgroundImageView: UIImageView = {
        let backgroundImageView = UIImageView(frame: UIScreen.main.bounds)
        backgroundImageView.image = UIImage(named: "board")
        backgroundImageView.clipsToBounds = true
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        return backgroundImageView
    }()
    
    let buttonContainer: UIView = {
        let container = UIView()
        container.backgroundColor = .white
        return container
    }()
    
    let logoutButton: UIButton = {
        let button = UIButton()
        button.setTitle("Профильден шығу", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(logoutTapped), for: .touchUpInside)
        return button
    }()
    
    @objc func logoutTapped() {
        
        do {
            try Auth.auth().signOut()
        } catch let logoutError {
            print(logoutError)
        }
        
        let loginVC = LoginViewController()
        loginVC.modalPresentationStyle = .fullScreen
        present(loginVC, animated: true, completion: nil)
        
        
    }
    
    @objc func editTapped() {
        let editProfileVC = EditProfileViewController()
        present(editProfileVC, animated: true, completion: nil)
        editProfileVC.editProfileDelegate = self
        editProfileVC.nameTextField.text = nameLabel.text
        editProfileVC.phoneNumberTextField.text = phoneNumberLabel.text
        editProfileVC.cityTextField.text = cityLabel.text
        editProfileVC.addressTextField.text = addressLabel.text
    }
    
    func setupViews() {
        
        view.addSubview(profileImageView)
        view.addSubview(nameLabel)
        view.addSubview(phoneNumberLabel)
        view.addSubview(cityLabel)
        view.addSubview(addressLabel)
        view.addSubview(buttonContainer)
        view.insertSubview(backgroundImageView, at: 0)
        view.addSubview(logoutButton)
        
        
        profileImageView.frame = CGRect(x: 10, y: 10, width: 140, height: 150)
        profileImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 155).isActive = true
        profileImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        profileImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 150 - view.frame.width ).isActive = true
        profileImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: profileImageView.frame.height * 2 - view.frame.height).isActive = true
        profileImageView.layer.masksToBounds = true
        profileImageView.layer.borderWidth = 0.5
        profileImageView.layer.borderColor = UIColor.white.cgColor
        profileImageView.layer.cornerRadius = profileImageView.frame.size.width / 2
        profileImageView.clipsToBounds = true
        
        nameLabel.frame = CGRect(x: profileImageView.frame.width + 20, y: 155, width: 200, height: 22)
        
        nameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 155).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 15).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: nameLabel.frame.width * 2 - view.frame.width).isActive = true
//        nameLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: nameLabel.frame.height * 2 - view.frame.height ).isActive = true
        
        phoneNumberLabel.frame = CGRect(x: profileImageView.frame.width + 20, y: 155 + 40, width: 200, height: 22)
        phoneNumberLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20).isActive = true
        phoneNumberLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 15).isActive = true
        phoneNumberLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: phoneNumberLabel.frame.width * 2 - view.frame.width).isActive = true
        
        cityLabel.frame = CGRect(x: profileImageView.frame.width + 20, y: 155 + 80, width: 200, height: 22)
        cityLabel.topAnchor.constraint(equalTo: phoneNumberLabel.bottomAnchor, constant: 20).isActive = true
        cityLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 15).isActive = true
        cityLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: cityLabel.frame.width * 2 - view.frame.width).isActive = true
        
        addressLabel.frame = CGRect(x: profileImageView.frame.width + 20, y: 155 + 120, width: 200, height: 22)
        addressLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 20).isActive = true
        addressLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 15).isActive = true
        addressLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: addressLabel.frame.width * 2 - view.frame.width).isActive = true
        
        buttonContainer.addSubview(editProfileButton)
        buttonContainer.frame = CGRect(x: 50, y: 155 + profileImageView.frame.height + 60, width: view.frame.width - 100, height: 30)
        buttonContainer.layer.cornerRadius = 5
        editProfileButton.frame = CGRect(x: 10, y: 4, width: buttonContainer.frame.width - 20, height: 20)
        editProfileButton.addTarget(self, action: #selector(editTapped), for: .touchUpInside)
        
        logoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoutButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

        backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    //MARK: - Showing profile data methods
    
    func showProfile() {
        
        if let name = UserDefaults.standard.string(forKey: "name") {
            nameLabel.text = name
        }
        
        if let phoneNumber = UserDefaults.standard.string(forKey: "phoneNumber") {
            phoneNumberLabel.text = phoneNumber
        }
        
        if let city = UserDefaults.standard.string(forKey: "city") {
            cityLabel.text = city
        }
        
        if let address = UserDefaults.standard.string(forKey: "address") {
            addressLabel.text = address
        }
        
    }
    
    func editProfile(name: String, phoneNumber: String, city: String, address: String) {
       
        nameLabel.text = name
        phoneNumberLabel.text = phoneNumber
        cityLabel.text = city
        addressLabel.text = address
        
    }
    
    

    
    
}
