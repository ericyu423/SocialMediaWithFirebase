//
//  ViewController.swift
//  SocialMediaWithFirebase
//
//  Created by eric yu on 3/24/18.
//  Copyright © 2018 eric yu. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
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
        button.layer.masksToBounds = true

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
    
    let alreadyHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        
        let attributedTitle = NSMutableAttributedString(string: "Already have an account ", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14), NSAttributedStringKey.foregroundColor: UIColor.lightGray])
        
        attributedTitle.append(NSMutableAttributedString(string: "Sign In", attributes:[NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14), NSAttributedStringKey.foregroundColor: UIColor(red: 17/255, green: 154/255, blue: 237/255, alpha: 1)
            ]))
        
        button.setAttributedTitle(attributedTitle, for: .normal)
        
        button.setTitle("Don't have an account?  Sign Up.", for: .normal)
 
        button.addTarget(self, action: #selector(handleAlreadyHaveAccountTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var stackView:UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [emailTextField, usernameTextField, passwordTextField, signUpButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()
    
    @objc private func handleAlreadyHaveAccountTapped(){
        navigationController?.popViewController(animated: true)
    }
    
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
            

            guard let image = self.photoButton.imageView?.image else { return }
            
            guard let uploadData = UIImageJPEGRepresentation(image, 0.3) else {return} //30% original
            let filename = UUID().uuidString
            Storage.storage().reference().child("profile_images").child(filename).putData(uploadData, metadata: nil, completion: { (metadata, error) in
                
                if let error = error {
                    print("Failed to upload profil image:",error)
                    return
                }
                guard let profileImageUrl = metadata?.downloadURL()?.absoluteString else {return}
                print("Successfully uploaded profil image:",profileImageUrl)
                
                guard let uid = user?.uid else {return}
                let dictValues = ["username":username,"profileImageUrl": profileImageUrl]
                let value = [uid:dictValues]
                
                
                Database.database().reference().child("users").updateChildValues(value, withCompletionBlock: { (error, ref) in
                    
                    if let error = error {
                        print("failed to save user info to db",error)
                        return
                    }
                    print("Successfully saved user info to db")
                })//Database.database() ends
            }) //storage().reference().child ends
        }//Auth.auth().createUser ends
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(alreadyHaveAccountButton)
        
        alreadyHaveAccountButton.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
        
        view.backgroundColor = .white
        setupSubViews()
    }
    
    private func setupSubViews(){
       
        //MARK: PhotoButton
        view.addSubview(photoButton)
        
        photoButton.anchor(top: view.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 40, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: heightPhotoButton, height: heightPhotoButton)
        photoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        //MARK: StackView
        view.addSubview(stackView)
        stackView.anchor(top: self.photoButton.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 20, paddingLeft: 40, paddingBottom: 0, paddingRight: 40, width: 0, height: 200)
    }

}


//MARK: UIImagePickerControllerDelegate
extension SignUpViewController {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            photoButton.setImage(editedImage.withRenderingMode(.alwaysOriginal), for: .normal)
        } else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            photoButton.setImage(originalImage.withRenderingMode(.alwaysOriginal), for: .normal)
        }
        dismiss(animated: true, completion: nil)
    }
    
}



