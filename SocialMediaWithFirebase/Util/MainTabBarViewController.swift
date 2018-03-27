//
//  MainTabBarViewController.swift
//  SocialMediaWithFirebase
//
//  Created by eric yu on 3/25/18.
//  Copyright © 2018 eric yu. All rights reserved.
//

import UIKit
import Firebase

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
            let loginVC = LoginViewController()
                let navC = UINavigationController(rootViewController: loginVC)
                self.present(navC, animated: true, completion: nil)
            }
            return
        }

       setupViewControllers()
    }
    
    //will be call to reset
    internal func setupViewControllers(){
        //collection view needs to initialized with layout
        let layout = UICollectionViewFlowLayout()
        let userProfileController = UserProfileController(collectionViewLayout: layout)
        
        let navController = UINavigationController(rootViewController: userProfileController)
        
        navController.tabBarItem.image = #imageLiteral(resourceName: "profile_unselected")
        navController.tabBarItem.selectedImage = #imageLiteral(resourceName: "profile_selected")
        
        tabBar.tintColor = .black
        
        let SignUpVC = SignUpViewController()
        SignUpVC.view.backgroundColor = .white
        viewControllers = [navController, SignUpVC]
    }

 

   

}
