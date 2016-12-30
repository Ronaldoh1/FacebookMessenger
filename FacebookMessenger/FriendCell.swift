//
//  FriendCell.swift
//  FacebookMessenger
//
//  Created by Ronald Hernandez on 12/30/16.
//  Copyright © 2016 Ronaldoh1. All rights reserved.
//

import UIKit

class FriendCell: BaseCell {

    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .ScaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "goku")
        imageView.layer.cornerRadius = 34
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    override func setUpViews() {
          self.backgroundColor = UIColor.yellowColor()

        self.addSubview(profileImageView)

        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-12-[v0(68)]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": profileImageView]))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-12-[v0(68)]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": profileImageView]))
    }

}
