//
//  SharePhotoViewController.swift
//  SocialMediaWithFirebase
//
//  Created by eric yu on 4/7/18.
//  Copyright © 2018 eric yu. All rights reserved.
//

import UIKit
import Firebase

class SharePhotoViewController: UIViewController {
    
    //image will be set by whoever that is calling this file
    var selectedImage: UIImage? {
        didSet {
            self.imageView.image = selectedImage
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        
        
        //greyish background
        view.backgroundColor = UIColor(displayP3Red: 240/255, green: 240/255, blue: 240/255, alpha: 1)
            
       
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Share", style: .plain, target: self, action: #selector(handleShare))
        
        setupImageAndTextViews()
    }
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .red
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    let textView: UITextView = {
        let tv = UITextView()
        tv.font = UIFont.systemFont(ofSize: 14)
        return tv
    }()
    
    fileprivate func setupImageAndTextViews() {
        let containerView = UIView()
        containerView.backgroundColor = .white
        
        view.addSubview(containerView)
        containerView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 100)
        
        containerView.addSubview(imageView)
        imageView.anchor(top: containerView.topAnchor, left: containerView.leftAnchor, bottom: containerView.bottomAnchor, right: nil, paddingTop: 8, paddingLeft: 8, paddingBottom: 8, paddingRight: 0, width: 84, height: 0)
        
        containerView.addSubview(textView)
        textView.anchor(top: containerView.topAnchor, left: imageView.rightAnchor, bottom: containerView.bottomAnchor, right: containerView.rightAnchor, paddingTop: 0, paddingLeft: 4, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }

    @objc private func handleShare(){
        guard let image = selectedImage else { return }
        
        guard let uploadData = UIImageJPEGRepresentation(image, 0.5) else { return }
        let fileName = NSUUID().uuidString
        Storage.storage().reference().child("posts").child(fileName).putData(uploadData, metadata: nil) { (metaData, error) in
            if let error = error {
                print("Failed to upload post image:",error)
                return
            }
            guard let imageUrl = metaData?.downloadURL()?.absoluteString else { return }
            print("succesfully uploaded image",imageUrl)
            
            self.saveToDatabaseWithImageUrl()
            
        }
    }
    
    fileprivate func saveToDatabaseWithImageUrl(){
        
        
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

}
