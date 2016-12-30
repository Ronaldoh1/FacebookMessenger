//
//  FriendCell.swift
//  FacebookMessenger
//
//  Created by Ronald Hernandez on 12/30/16.
//  Copyright © 2016 Ronaldoh1. All rights reserved.
//

import UIKit

class FriendCell: BaseCell {

    //MARK: Properties

    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .ScaleAspectFill
        imageView.image = UIImage(named: "goku")
        imageView.layer.cornerRadius = 34
        imageView.layer.masksToBounds = true
        return imageView
    }()

    let dividerLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
        return view
    }()

    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Friend Name"
        label.font = UIFont.systemFontOfSize(18)
        return label
    }()

    let messageLabel: UILabel = {
        let label = UILabel()
        label.text = "Your Friends Message and soemthing else ... "
        label.textColor = UIColor.darkGrayColor()
        label.font = UIFont.systemFontOfSize(14)
        return label
    }()

    let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "12:05 PM"
        label.font = UIFont.systemFontOfSize(16)
        label.textAlignment = .Right
        return label
    }()

    // MARK: Life Cycle Methods

    override func setUpViews() {
        self.backgroundColor = UIColor.yellowColor()

        self.addSubview(profileImageView)
        self.addSubview(dividerLineView)

        setupContainerView()

        //profileImageView
        addConstraintsWithFormat("H:|-12-[v0(68)]", views: profileImageView)
        addConstraintsWithFormat("V:[v0(68)]", views: profileImageView)

        //center profile imageView
        addConstraint(NSLayoutConstraint(item: profileImageView, attribute: .CenterY, relatedBy: .Equal, toItem: self, attribute: .CenterY, multiplier: 1, constant: 0))

        //Divider Line View
        addConstraintsWithFormat("H:|-82-[v0]|", views: dividerLineView)
        addConstraintsWithFormat("V:[v0(2)]|", views: dividerLineView)
    }


    private func setupContainerView() {
        let containerView = UIView()
        containerView.backgroundColor = UIColor.redColor()
        addSubview(containerView)

        addConstraintsWithFormat("H:|-90-[v0]|", views: containerView)
        addConstraintsWithFormat("V:[v0(50)]", views: containerView)
        //center container view
        addConstraint(NSLayoutConstraint(item: containerView, attribute: .CenterY, relatedBy: .Equal, toItem: self, attribute: .CenterY, multiplier: 1, constant: 0))

        // Name Label & MessageLabel

        containerView.addSubview(nameLabel)
        containerView.addSubview(messageLabel)
        containerView.addSubview(timeLabel)
        addConstraintsWithFormat("H:|[v0][v1(80)]-12-|", views: nameLabel, timeLabel)
        addConstraintsWithFormat("V:|[v0][v1(24)]|", views: nameLabel, messageLabel)
        addConstraintsWithFormat("H:|[v0]-12-|", views: messageLabel)
        addConstraintsWithFormat("V:|[v0(20)]", views: timeLabel)

    }
}
