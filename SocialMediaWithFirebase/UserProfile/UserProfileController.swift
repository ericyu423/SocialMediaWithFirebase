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

struct User {
    let username: String
    let profileImageUrl: String
    
    init(dictionary: [String: Any]) {
        self.username = dictionary["username"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageUrl"]  as? String ?? ""
    }
}

class UserProfileController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let headerHeight:CGFloat = 200
    let headerId = "headerId"
    let cellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLogOutButton()
        collectionView?.backgroundColor = .white
        navigationItem.title = Auth.auth().currentUser?.uid
        fetchUser()
        
        //register header
        collectionView?.register(UserProfileHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
        
        collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    var user: User?
    private func fetchUser() {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in  //.value = Any data changes at a location or, recursively, at any child node
            print(snapshot.value ?? "")
            guard let dictionary = snapshot.value as? [String: Any] else { return }
            
            self.user = User(dictionary: dictionary)
            self.navigationItem.title = self.user?.username
            self.collectionView?.reloadData()
            //reload so once we have user it will refresh header with image
        
            
        })  { (err) in
            print("Failed to fetch user:", err)
        }
    }//fetchUser() ends
}

//MARK:- popUp functions
extension UserProfileController {
    private func setupLogOutButton(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "gear")
            .withRenderingMode(.alwaysOriginal),style: .plain, target: self,action: #selector(settingClicked))
    }
    
    @objc private func settingClicked(){
        let alertController = UIAlertController(title: "Log out", message: "Are you sure", preferredStyle: .actionSheet)
        
        alertController.addAction(UIAlertAction(title: "Log out", style: .destructive, handler: { (_) in
            print ("perform log out")
            
            do { //signout throws
                try Auth.auth().signOut()
            } catch let err {
                
                print("failed to sign out:", err)
            }
            
            
            }))
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
            present(alertController, animated: true, completion: nil)
        
    }
    
    
    
}

//MARK:- collectionView delegates header
extension UserProfileController {

    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! UserProfileHeader
        header.user = self.user // user with key username and password
  
        return header
    }
    
    //tells how big the header is
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return CGSize(width: view.frame.width, height: headerHeight)
    }
}
//MARK:- collection delegate body
extension UserProfileController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        
        cell.backgroundColor = .purple
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - 2) / 3
        return CGSize(width: width, height: width)
    }
}




