//
//  PhotoSelectorHeader.swift
//  SocialMediaWithFirebase
//
//  Created by eric yu on 3/29/18.
//  Copyright © 2018 eric yu. All rights reserved.
//

import UIKit

class PhotoSelectorHeader: UICollectionViewCell {
    let photoImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill //expand out side the bounds
        iv.clipsToBounds = true //cut the boarder
        iv.backgroundColor = .cyan
        return iv
    }()
    override init(frame: CGRect){
        super.init(frame:frame)
        addSubview(photoImageView)
        photoImageView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
