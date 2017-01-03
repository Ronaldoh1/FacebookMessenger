//
//  ChatLogMessageCell.swift
//  FacebookMessenger
//
//  Created by Ronald Hernandez on 1/2/17.
//  Copyright © 2017 Ronaldoh1. All rights reserved.
//

import UIKit

class ChatLogMessageCell: BaseCell {

    lazy var messageTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFontOfSize(18)
        textView.text = "Sample Text"
        textView.backgroundColor = UIColor.clearColor()

        return textView
    }()

    let textBubbleView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.95, alpha: 1)
        view.layer.cornerRadius = 15
        view.layer.masksToBounds = true
        return view
    }()

    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .ScaleAspectFill
        imageView.layer.cornerRadius = 15
        imageView.layer.masksToBounds = true
        return imageView
    }()

    override func setUpViews() {
        super.setUpViews()

        addSubview(textBubbleView)
        addSubview(messageTextView)
        addSubview(profileImageView)

        addConstraintsWithFormat("H:|[v0(30)]", views: profileImageView)
        addConstraintsWithFormat("V:[v0(30)]|", views: profileImageView)
        profileImageView.backgroundColor = UIColor.blueColor()
    }
}
