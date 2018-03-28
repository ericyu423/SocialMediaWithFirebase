//
//  MainTabBarViewController.swift
//  SocialMediaWithFirebase
//
//  Created by eric yu on 3/25/18.
//  Copyright © 2018 eric yu. All rights reserved.
//

import UIKit
import Firebase

class MainTabBarViewController: UITabBarController,UITabBarControllerDelegate {

    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController)-> Bool {
        let index = viewControllers?.index(of: viewController)
        if index == 2 {
            
            let layout = UICollectionViewFlowLayout()
            let photoSelectorController = PhotoSelectorController(collectionViewLayout: layout)
            
            let navController = UINavigationController(rootViewController: photoSelectorController)
            
            
            present(navController,animated: true,completion: nil)
    
            return false
        }
        return true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
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
        
        let homeNavController = templateNavController(unselectedImage: #imageLiteral(resourceName: "home_unselected"), selectedImage: #imageLiteral(resourceName: "home_selected"), rootViewController: UserProfileController(collectionViewLayout: UICollectionViewFlowLayout()))
     
        let searchNavController = templateNavController(unselectedImage: #imageLiteral(resourceName: "search_unselected"), selectedImage: #imageLiteral(resourceName: "search_selected"))
        let plusNavController = templateNavController(unselectedImage: #imageLiteral(resourceName: "plus_unselected"), selectedImage: #imageLiteral(resourceName: "plus_unselected"))
        let likeNavController = templateNavController(unselectedImage: #imageLiteral(resourceName: "like_unselected"), selectedImage: #imageLiteral(resourceName: "like_selected"))
        
  
        //collection view needs to initialized with layout
        let layout = UICollectionViewFlowLayout()
        let userProfileController = UserProfileController(collectionViewLayout: layout)
        
        let userProfileNavController = UINavigationController(rootViewController: userProfileController)
        
        userProfileNavController.tabBarItem.image = #imageLiteral(resourceName: "profile_unselected")
        userProfileNavController.tabBarItem.selectedImage = #imageLiteral(resourceName: "profile_selected")
        
        tabBar.tintColor = .black
        
        let SignUpVC = SignUpViewController()
        SignUpVC.view.backgroundColor = .white
        
        viewControllers = [homeNavController, searchNavController,plusNavController,likeNavController, userProfileNavController]
        
        guard let items = tabBar.items else { return }
        
        for item in items {
            item.imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0)
        }
        
        
    }
    
    private func templateNavController(unselectedImage:UIImage,selectedImage:UIImage,rootViewController: UIViewController = UIViewController()) -> UINavigationController {
        let viewController = rootViewController
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.image = unselectedImage
        navController.tabBarItem.selectedImage = selectedImage
        return navController
    }

 

   

}
