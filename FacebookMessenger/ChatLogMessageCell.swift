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

    override func setUpViews() {
        super.setUpViews()

        addSubview(textBubbleView)
        addSubview(messageTextView)
    }
}
