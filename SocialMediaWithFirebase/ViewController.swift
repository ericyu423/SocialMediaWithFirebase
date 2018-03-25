//
//  ViewController.swift
//  SocialMediaWithFirebase
//
//  Created by eric yu on 3/24/18.
//  Copyright © 2018 eric yu. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    //MARK:- declarations
     private let heightPhotoButton:CGFloat = 150
    
     private lazy var photoButton: UIButton = {
        var button = UIButton()
        button.backgroundColor = .white
        button.layer.cornerRadius = heightPhotoButton/2
        button.layer.borderWidth = 4
        button.layer.borderColor = UIColor.darkGray.cgColor
        button.setTitle("+ \nPhoto", for: .normal)
        button.addTarget(self, action: #selector(photoButtonClicked), for: .touchUpInside)
        
        button.setTitleColor(UIColor.darkGray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.textAlignment = .center
        
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let emailTextField: UITextField = { x in
        let tf = UITextField()
        tf.placeholder = x
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        return tf
    }("Email")
    
    private let usernameTextField: UITextField = { x in
        let tf = UITextField()
        tf.placeholder = x
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        return tf
    }("Username")
    
    private let passwordTextField: UITextField = { x in
        let tf = UITextField()
        tf.placeholder = x
        tf.isSecureTextEntry = true
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        return tf
    }("Password")
    
    private lazy var signUpButton: UIButton = { x in
        let button = UIButton(type: .system)
        button.setTitle(x, for: .normal)
        button.backgroundColor = UIColor(red: 149/255, green: 204/255, blue: 244/255, alpha: 1)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(signUpClicked), for: .touchUpInside)
        return button
    }("Sign Up")
    
    private lazy var stackView:UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [emailTextField, usernameTextField, passwordTextField, signUpButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()
    
    @objc private func photoButtonClicked(){
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        present(imagePickerController,animated: true,completion: nil)
        
        
    }
    
    @objc private func handleTextInputChange(){
        
        let isTextFieldsAllFilled = emailTextField.text?.count ?? 0 > 0 && usernameTextField.text?.count ?? 0 > 0 && passwordTextField.text?.count ?? 0 > 0
   
        if isTextFieldsAllFilled {
            signUpButton.isEnabled = true
            signUpButton.backgroundColor = UIColor(red: 17/255, green: 154/255, blue: 237/255, alpha: 1)
        } else {
            signUpButton.isEnabled = false
            signUpButton.backgroundColor = UIColor(red: 149/255, green: 204/255, blue: 244/255, alpha: 1)
        }
    }
    
    @objc private func signUpClicked (){
        
        guard let email = emailTextField.text, email.count > 0 else {
            //message user error
            return }
        guard let username = usernameTextField.text, username.count > 0 else {
            
            return }
        guard let password = passwordTextField.text, password.count > 0 else {
            
            return }
     
        Auth.auth().createUser(withEmail: email, password: password) { (user, error ) in
            if let error = error { print("Failed to create user:",error)}
            print("Successfully created user:",user?.uid ?? "")
            guard let uid = user?.uid else {return}
            
            let another = ["layer":"saveSomethingElse"]
            let dict = ["username":another]
            let value = [uid: dict]
            
            // this is to go to database  /users/ folder
            Database.database().reference().child("users").updateChildValues(value, withCompletionBlock: { (error, ref) in
                
                if let error = error {
                    print("failed to save user info to db",error)
                    return
                }
                
                print("Successfully saved user info to db")
                
              })//Database.database() ends
            
            
            
            
        }//Auth.auth().createUser ends
    
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubViews()
    }
    
    private func setupSubViews(){
       
        //MARK: PhotoButton
        view.addSubview(photoButton)
        photoButton.anchor(top: view.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 40, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: heightPhotoButton, height: heightPhotoButton)
        photoButton.anchorToCenter(x: view.centerXAnchor, y: nil, offsetX: 0, offsetY: 0, width: 0, height: 0)

        //MARK: StackView
        view.addSubview(stackView)
        stackView.anchor(top: photoButton.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 20, paddingLeft: 40, paddingBottom: 0, paddingRight: 40, width: nil, height: 200)
    }

}

extension ViewController {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            photoButton.setImage(editedImage.withRenderingMode(.alwaysOriginal), for: .normal)
        } else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            photoButton.setImage(originalImage.withRenderingMode(.alwaysOriginal), for: .normal)
        }
        
        photoButton.layer.masksToBounds = true
        dismiss(animated: true, completion: nil)
    }
    
}



