//
//  ViewController.swift
//  SocialMediaWithFirebase
//
//  Created by eric yu on 3/24/18.
//  Copyright © 2018 eric yu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var photoButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .red
        button.layer.cornerRadius = self.view.frame.size.height/2
        button.layer.borderWidth = 1
        button.setTitle("Photo", for: .normal)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let emailTextField: UITextField = { x in
        let tf = UITextField()
        tf.placeholder = x;
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }("Email")
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(photoButton)
        addAutoConstraintToSubviews()
        
    }

    func addAutoConstraintToSubviews(){
        
        NSLayoutConstraint.activate([
            photoButton.heightAnchor.constraint(equalToConstant: 140),
            photoButton.widthAnchor.constraint(equalToConstant: 140),
            photoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            photoButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 40)
        ])
        
        /*
        NSLayoutConstraint.activate([
            emailTextField.topAnchor.constraint(equalTo: photoButton.bottomAnchor, constant: 20),
            emailTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40),
            emailTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 40),
            emailTextField.heightAnchor.constraint(equalToConstant: 50)
        ])*/

    }

}

