//
//  LoginViewController.swift
//  AspaZ
//
//  Created by Riza on 1/7/21.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    //MARK: - Login and Register handling methods
    
    let loginRegisterButton: UIButton = {
        let button = UIButton()
        button.setTitle("Register", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor( .white, for: .normal)
        button.addTarget(self, action: #selector(handleLoginRegister), for: .touchUpInside)
        return button
    }()
    
    // handling login and register buttons
    @objc func handleLoginRegister() {
        if loginSegmentedControl.selectedSegmentIndex == 0 {
            handleLogin()
        } else {
            handleRegister()
        }
    }
    
    // Signing in methods
    @objc func handleLogin() {
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
            if error != nil {
                print(error!)
                return
            }
            
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    // Registering a new user methods
    @objc func handleRegister() {

        guard let email = emailTextField.text, let password = passwordTextField.text else {
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            if error != nil {
                print(error!)
            }
            
            guard let uid = authResult?.user.uid else { return }
            
            let ref = Database.database().reference(fromURL: "https://aspaz-d5506-default-rtdb.firebaseio.com/")
            let usersReference = ref.child("users").child(uid)
            let values = ["email" : email]
            usersReference.updateChildValues(values) { (err, ref) in
                if err != nil {
                    print(err!)
                    return
                }
                
                self.dismiss(animated: true, completion: nil )
                
            }
            
        }

    
    }
    
    //MARK: - Setting UI

    let loginContainer: UIView = {
        let container = UIView()
        container.backgroundColor = .white
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    let buttonContainer: UIView = {
        let container = UIView()
        container.backgroundColor = #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1)
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    let emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email"
        tf.keyboardType = .emailAddress
        tf.font = UIFont.systemFont(ofSize: 20)
        tf.textColor = .black
        tf.textAlignment = .left
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
//        tf.keyboardType = .default
        tf.textContentType = .newPassword
        tf.isSecureTextEntry = true
        tf.font = UIFont.systemFont(ofSize: 20)
        tf.textColor = .black
        tf.textAlignment = .left
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let dividerLineView: UIView = {
        let dlv = UIView()
        dlv.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        dlv.translatesAutoresizingMaskIntoConstraints = false
        return dlv
    }()
    
    let loginSegmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Login", "Register"])
        sc.selectedSegmentIndex = 1
        sc.translatesAutoresizingMaskIntoConstraints = false
        sc.backgroundColor = #colorLiteral(red: 0.5197702646, green: 0.1086745039, blue: 0.03999869525, alpha: 1)
        sc.addTarget(self, action: #selector(changeButtonTile), for: .valueChanged)
        return sc
    }()
    
    // Changing the button name of the segmented control
    @objc func changeButtonTile (sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            loginRegisterButton.setTitle("Login", for: .normal)
        } else {
            loginRegisterButton.setTitle("Register", for: .normal)
        }
    }
    
    func setupViews() {
        
        view.backgroundColor = #colorLiteral(red: 0.631372549, green: 0.0431372549, blue: 0.1647058824, alpha: 1)
        view.addSubview(loginContainer)
        view.addSubview(buttonContainer)
        view.addSubview(loginSegmentedControl)
        buttonContainer.addSubview(loginRegisterButton)
        loginContainer.addSubview(emailTextField)
        loginContainer.addSubview(dividerLineView)
        loginContainer.addSubview(passwordTextField)
        
        loginSegmentedControl.bottomAnchor.constraint(equalTo: loginContainer.topAnchor, constant: -10).isActive = true
        loginSegmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        loginSegmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        loginSegmentedControl.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        loginContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginContainer.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -40).isActive = true
        loginContainer.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -20).isActive = true
        loginContainer.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/5).isActive = true
        loginContainer.layer.cornerRadius = 5
        
        emailTextField.topAnchor.constraint(equalTo: loginContainer.topAnchor).isActive = true
        emailTextField.leadingAnchor.constraint(equalTo: loginContainer.leadingAnchor, constant: 10).isActive = true
        emailTextField.trailingAnchor.constraint(equalTo: loginContainer.trailingAnchor, constant: 10).isActive = true
        emailTextField.heightAnchor.constraint(equalTo: loginContainer.heightAnchor, multiplier: 1/2).isActive = true
        
        dividerLineView.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        dividerLineView.widthAnchor.constraint(equalTo: loginContainer.widthAnchor).isActive = true
        dividerLineView.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        passwordTextField.leadingAnchor.constraint(equalTo: loginContainer.leadingAnchor, constant: 10).isActive = true
        passwordTextField.trailingAnchor.constraint(equalTo: loginContainer.trailingAnchor, constant: 10).isActive = true
        passwordTextField.heightAnchor.constraint(equalTo: loginContainer.heightAnchor, multiplier: 1/2).isActive = true
        
        buttonContainer.topAnchor.constraint(equalTo: loginContainer.bottomAnchor, constant: 10).isActive = true
        buttonContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        buttonContainer.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -20).isActive = true
        buttonContainer.heightAnchor.constraint(equalTo: loginContainer.heightAnchor, multiplier: 1/3).isActive = true
        buttonContainer.layer.cornerRadius = 5
        
        loginRegisterButton.centerXAnchor.constraint(equalTo: buttonContainer.centerXAnchor).isActive = true
        loginRegisterButton.centerYAnchor.constraint(equalTo: buttonContainer.centerYAnchor).isActive = true
        
    }
    
    
}

