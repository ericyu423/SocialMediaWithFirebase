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
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.darkGray.cgColor
        button.setTitle("Photo", for: .normal)
        button.setTitleColor(UIColor.darkGray, for: .normal)
        
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
            photoButton.heightAnchor.constraint(equalToConstant: heightPhotoButton),
            photoButton.widthAnchor.constraint(equalToConstant: heightPhotoButton),
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

