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
//        view.backgroundColor = UIColor(white: 0.95, alpha: 1)
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

    let bubbleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ChatLogMessageCell.grayBubble
        imageView.tintColor = UIColor(white: 0.90, alpha: 1)
        return imageView
    }()

    static let grayBubble = UIImage(named: "bubble_gray")?.resizableImageWithCapInsets(UIEdgeInsetsMake(22,26,22,26)).imageWithRenderingMode(.AlwaysTemplate)
    static  let blueBubble = UIImage(named: "bubble_blue")?.resizableImageWithCapInsets(UIEdgeInsetsMake(22,26,22,26)).imageWithRenderingMode(.AlwaysTemplate)

    override func setUpViews() {
        super.setUpViews()

        addSubview(textBubbleView)
        addSubview(messageTextView)
        addSubview(profileImageView)


        addConstraintsWithFormat("H:|[v0(30)]", views: profileImageView)
        addConstraintsWithFormat("V:[v0(30)]|", views: profileImageView)
        profileImageView.backgroundColor = UIColor.blueColor()

        //add bubbles 
        textBubbleView.addSubview(bubbleImageView)

        addConstraintsWithFormat("H:|[v0]|", views: bubbleImageView)
        addConstraintsWithFormat("V:|[v0]|", views: bubbleImageView)

    }
}
