//
//  LoginViewController.swift
//  SocialMediaWithFirebase
//
//  Created by eric yu on 3/27/18.
//  Copyright © 2018 eric yu. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    private let containerViewHeight:CGFloat = 150
    
    
    private let emailTextField: UITextField = { x in
        let tf = UITextField()
        tf.placeholder = x
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
       // tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        return tf
    }("Email")
    
    private let passwordTextField: UITextField = { x in
        let tf = UITextField()
        tf.placeholder = x
        tf.isSecureTextEntry = true
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        //tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        return tf
    }("Password")
    
    private lazy var loginButton: UIButton = { x in
        let button = UIButton(type: .system)
        button.setTitle(x, for: .normal)
        button.backgroundColor = UIColor(red: 149/255, green: 204/255, blue: 244/255, alpha: 1)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.white, for: .normal)
       // button.addTarget(self, action: #selector(signUpClicked), for: .touchUpInside)
        return button
    }("Login")
    
    let logoContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(displayP3Red: 0, green: 120/255, blue: 175/255, alpha: 1)
        let logoImageView = UIImageView(image:#imageLiteral(resourceName: "gear"))
        logoImageView.contentMode = .scaleAspectFill
        view.addSubview(logoImageView)
        logoImageView.anchor(top: nil , left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        //if using scaleaspectfill height and width doesn't really matter here.
        
        logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        return view
    }()
    
    let NoAccountsignUpButton: UIButton = {
        let button = UIButton(type: .system)
        
        let attributedTitle = NSMutableAttributedString(string: "Don't have an account ", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14), NSAttributedStringKey.foregroundColor: UIColor.lightGray])

        attributedTitle.append(NSMutableAttributedString(string: "Sign Up", attributes:[NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14), NSAttributedStringKey.foregroundColor: UIColor(red: 17/255, green: 154/255, blue: 237/255, alpha: 1)
            ]))
        
          button.setAttributedTitle(attributedTitle, for: .normal)
        
        button.setTitle("Don't have an account?  Sign Up.", for: .normal)
        
        
        
        button.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
        return button
    }()
    
    @objc func handleShowSignUp() {
        let signUpController = SignUpViewController()
        self.navigationController?.pushViewController(signUpController, animated: true)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(logoContainerView)
        logoContainerView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: containerViewHeight)
        navigationController?.isNavigationBarHidden = true
        view.backgroundColor = .white
        
        view.addSubview(NoAccountsignUpButton)
        NoAccountsignUpButton.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
    }
    
    private func setupInputFieldsForLogin(){
        let stackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField,loginButton])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        
        view.addSubview(stackView)
        stackView.anchor(top: logoContainerView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 40, paddingLeft: 40, paddingBottom: 0, paddingRight: 40, width: 0, height: 140)
        
        
    }
}
