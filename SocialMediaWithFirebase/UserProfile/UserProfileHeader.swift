//
//  UserProfileHeader.swift
//  SocialMediaWithFirebase
//
//  Created by eric yu on 3/25/18.
//  Copyright © 2018 eric yu. All rights reserved.
//

import UIKit
import Firebase

class UserProfileHeader: UICollectionViewCell {
    private let profileImageHeight:CGFloat = 80
    
    lazy var profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .red
        iv.clipsToBounds = true
        iv.layer.cornerRadius = profileImageHeight/2
        return iv
    }()
    
    //whenever UserProfileHeader is called and initialized
    //setupProfileImage() is called
    var user: User? {
        didSet {
            setupProfileImage()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .blue
        
        addSubview(profileImageView)
        
        profileImageView.anchor(top: topAnchor, left: self.leftAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: profileImageHeight, height: profileImageHeight)
    }

    fileprivate func setupProfileImage() {
        
        
        guard let profileImageUrl = user?.profileImageUrl else { return }
        guard let url = URL(string: profileImageUrl) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            //check for the error, then construct the image using data
            if let err = err {
                print("Failed to fetch profile image:", err)
                return
            }
            guard let data = data else { return }
            let image = UIImage(data: data)

            //need to get back onto the main UI thread
            DispatchQueue.main.async {
                self.profileImageView.image = image
            }
        }.resume()
    }
    
   
}
