//
//  ViewController.swift
//  SocialMediaWithFirebase
//
//  Created by eric yu on 3/24/18.
//  Copyright © 2018 eric yu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
 
    private let heightPhotoButton:CGFloat = 150
    
     lazy var photoButton: UIButton = {
        var button = UIButton()
        button.backgroundColor = .white
        button.layer.cornerRadius = heightPhotoButton/2
        button.layer.borderWidth = 4
        button.layer.borderColor = UIColor.darkGray.cgColor
        
        button.setTitle("+ \nPhoto", for: .normal)
        button.setTitleColor(UIColor.darkGray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.textAlignment = .center
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let emailTextField: UITextField = { x in
        let tf = UITextField()
        tf.placeholder = x
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        return tf
    }("Email")
    
    let usernameTextField: UITextField = { x in
        let tf = UITextField()
        tf.placeholder = x
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        return tf
    }("Username")
    
    let passwordTextField: UITextField = { x in
        let tf = UITextField()
        tf.placeholder = x
        tf.isSecureTextEntry = true
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        return tf
    }("Password")
    
    let signUpButton: UIButton = { x in
        let button = UIButton(type: .system)
        button.setTitle(x, for: .normal)
        button.backgroundColor = UIColor(red: 149/255, green: 204/255, blue: 244/255, alpha: 1)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.white, for: .normal)
        return button
    }("Sign Up")
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(photoButton)
        view.addSubview(emailTextField)
        addAutoConstraintToSubviews()
        
    }

    func addAutoConstraintToSubviews(){
        
        NSLayoutConstraint.activate([
            photoButton.heightAnchor.constraint(equalToConstant: heightPhotoButton),
            photoButton.widthAnchor.constraint(equalToConstant: heightPhotoButton),
            photoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            photoButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 40)
        ])
        
        setupInputFields()
        
 

    }
    
    private func setupInputFields(){
        /*
        let stackView = UIStackView(arrangedSubviews: [emailTextField, usernameTextField, passwordTextField, signUpButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 10*/
        
        
        let stackView:UIStackView = {
            let stackView = UIStackView(arrangedSubviews: [emailTextField, usernameTextField, passwordTextField, signUpButton])
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.distribution = .fillEqually
            stackView.axis = .vertical
            stackView.spacing = 10
            return stackView
            
        }()
        
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: photoButton.bottomAnchor, constant: 20),
            stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40),
            stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40),
            stackView.heightAnchor.constraint(equalToConstant: 200)
            ])
        
    }
    
    

}



