//
//  UserProfileController.swift
//  SocialMediaWithFirebase
//
//  Created by eric yu on 3/25/18.
//  Copyright © 2018 eric yu. All rights reserved.
//

import Foundation


import UIKit
import Firebase

class UserProfileController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let headerHeight:CGFloat = 200
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = .white
        navigationItem.title = Auth.auth().currentUser?.uid
        fetchUser()
        
        //register header
        collectionView?.register(UserProfileHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "headerId")
    }
    
    var user: User?
    private func fetchUser() {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in  //.value = Any data changes at a location or, recursively, at any child node
            print(snapshot.value ?? "")
            guard let dictionary = snapshot.value as? [String: Any] else { return }
            
            self.user = User(dictionary: dictionary)
            
            self.collectionView?.reloadData()
            //reload so once we have user it will refresh header with image
            self.navigationItem.title = self.user?.username
            
        })  { (err) in
            print("Failed to fetch user:", err)
        }
    }//fetchUser() ends
}

//collectionView delegates
extension UserProfileController {
    
    
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerId", for: indexPath) as! UserProfileHeader
        
        header.user = self.user // user with key username and password
        
        
        
        return header
    }
    
    //tells how big the header is
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return CGSize(width: view.frame.width, height: headerHeight)
    }
}


struct User {
    let username: String
    let profileImageUrl: String
    
    init(dictionary: [String: Any]) {
        self.username = dictionary["username"] as? String ?? "" 
        self.profileImageUrl = dictionary["profileImageUrl"]  as? String ?? ""
    }
}

