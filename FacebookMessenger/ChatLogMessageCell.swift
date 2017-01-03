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
        textView.font = UIFont.systemFontOfSize(16)
        textView.text = "sample text"
        textView.translatesAutoresizingMaskIntoConstraints = false

        return textView
    }()

    override func setUpViews() {
        super.setUpViews()
        self.backgroundColor = UIColor.orangeColor()

        addSubview(messageTextView)
        addConstraintsWithFormat("H:|[v0]|", views: messageTextView)
        addConstraintsWithFormat("V:|[v0]|", views: messageTextView)
    }
}
