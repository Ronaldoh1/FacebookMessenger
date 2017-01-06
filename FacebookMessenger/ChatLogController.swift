//
//  ChatLogController.swift
//  FacebookMessenger
//
//  Created by Ronald Hernandez on 12/30/16.
//  Copyright © 2016 Ronaldoh1. All rights reserved.
//

import UIKit

class ChatLogController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UITextFieldDelegate {

    var friend: Friend? {
        didSet {
            navigationItem.title = friend?.name
            messages = friend?.messages?.allObjects as? [Message]
            messages = messages?.sort({$0.date!.compare($1.date!) == .OrderedAscending})
        }
    }

    let messageInputContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.whiteColor()
        return view
    }()

    lazy var inputTextField: UITextField = {
        let textField = UITextField()
        textField.delegate = self
        textField.placeholder = "Enter Message"
        return textField
    }()

    lazy var sendButton: UIButton = {
        let button = UIButton()
        button.setTitle("Send", forState: .Normal)
        let titleColor = UIColor(red: 0, green: 137/255, blue: 249/255, alpha: 1)
        button.setTitleColor(titleColor, forState: .Normal)
        button.titleLabel?.font = UIFont.boldSystemFontOfSize(16)
        button.addTarget(self, action: #selector(handleSend) , forControlEvents: .TouchUpInside)
        return button
    }()

    var bottomConstraint: NSLayoutConstraint?

    var messages: [Message]?
    let cellID = "cellID"

    override func viewDidLoad() {
        super.viewDidLoad()

        tabBarController?.tabBar.hidden = true 
        collectionView?.backgroundColor = UIColor.whiteColor()
        collectionView?.registerClass(ChatLogMessageCell.self, forCellWithReuseIdentifier: cellID)

        //Add Bottom ContainerView and add constraints
        view.addSubview(messageInputContainerView)
        view.addConstraintsWithFormat("H:|[v0]|", views: messageInputContainerView)
        view.addConstraintsWithFormat("V:[v0(48)]", views: messageInputContainerView)
        bottomConstraint = NSLayoutConstraint(item: messageInputContainerView, attribute: .Bottom, relatedBy: .Equal, toItem: view, attribute: .Bottom, multiplier: 1, constant: 0)

        view.addConstraint(bottomConstraint!)
        setUpInputComponents()

        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(handleKeyboardNotification), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(handleKeyboardNotification), name: UIKeyboardWillHideNotification, object: nil)

    }

    func handleSend() {
        //insert into Core Data
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = appDelegate.managedObjectContext
       let message =  FriendsViewController.createMessageWithText(inputTextField.text!, friend: friend!, context: context, minutesAgo: 0, isSender: true)
        do {
            try context.save()


            //update the collectionView after inserting it.

            messages?.append(message)
            let indexPath = NSIndexPath(forItem: messages!.count - 1, inSection: 0  )
            collectionView?.insertItemsAtIndexPaths([indexPath])

            // scroll tableview to top 
            collectionView?.scrollToItemAtIndexPath(indexPath, atScrollPosition: .Bottom, animated: true)

            // remove the text from the textfield 

            inputTextField.text = nil 

        } catch let error {
            print(error)
        }
        
    }

    func handleKeyboardNotification(notification: NSNotification) {

        if let userInfo = notification.userInfo {
            let keyboardFrame = userInfo[UIKeyboardFrameEndUserInfoKey]?.CGRectValue()
            let isKeyboardShowing = notification.name == UIKeyboardWillShowNotification

            bottomConstraint?.constant = isKeyboardShowing ? -keyboardFrame!.height : 0

            UIView.animateWithDuration(0, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: { 
                self.view.layoutIfNeeded()
                }, completion: { (completion) in
                    let indexPath = NSIndexPath(forItem: self.messages!.count - 1, inSection: 0)
                    self.collectionView?.scrollToItemAtIndexPath(indexPath, atScrollPosition: .Bottom, animated: true)
            })
        }
    }

    private func setUpInputComponents() {
        let topBorderView = UIView()
        topBorderView.backgroundColor = UIColor(white: 0.5, alpha: 0.5)

        messageInputContainerView.addSubview(topBorderView)
        messageInputContainerView.addSubview(inputTextField)
        messageInputContainerView.addSubview(sendButton)
        messageInputContainerView.addConstraintsWithFormat("H:|-8-[v0][v1(60)]-8-|", views: inputTextField, sendButton)
        messageInputContainerView.addConstraintsWithFormat("V:|[v0(1)][v1]|", views: topBorderView, inputTextField)
        messageInputContainerView.addConstraintsWithFormat("V:|[v0]|", views: sendButton)
        messageInputContainerView.addConstraintsWithFormat("H:|[v0]|", views: topBorderView)
    }

    //MARK: CollectionView Delegate method
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        inputTextField.endEditing(true)
    }

    //MARK: CollectionView Datasource Methods

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = messages?.count {
            return count
        }
        return 0
    }

    //
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellID, forIndexPath: indexPath) as!ChatLogMessageCell
        cell.messageTextView.text = messages?[indexPath.item].text

        if let message = messages?[indexPath.item], messageText = messages?[indexPath.item].text, imageName = messages?[indexPath.item].friend?.profileImageName {
            cell.profileImageView.image = UIImage(named: imageName)

            let size = CGSizeMake(250, 1000)
            let options = NSStringDrawingOptions.UsesFontLeading.union(.UsesLineFragmentOrigin)
            let estimatedFrame = NSString(string: messageText).boundingRectWithSize(size, options: options, attributes: [NSFontAttributeName : UIFont.systemFontOfSize(18)], context: nil)
            //Chat bubbles for messages recived
            if !message.isSender!.boolValue {
                cell.messageTextView.frame = CGRectMake(48 + 8, 0, estimatedFrame.width + 16, estimatedFrame.height + 20)
                cell.textBubbleView.frame = CGRectMake(48 - 10, -4, estimatedFrame.width + 16 + 8 + 16, estimatedFrame.height + 20 + 6)
                cell.profileImageView.hidden = false
//                cell.textBubbleView.backgroundColor = UIColor(white: 0.95, alpha: 1)
                cell.messageTextView.textColor = UIColor.blackColor()
                cell.bubbleImageView.tintColor = UIColor(white: 0.95, alpha: 1)
                cell.bubbleImageView.image = ChatLogMessageCell.grayBubble
            } else {
                //chat bubbles for messages sent
                cell.messageTextView.frame = CGRectMake(view.frame.width - estimatedFrame.width - 16 - 16 - 8, 0, estimatedFrame.width + 16 , estimatedFrame.height + 20)
                cell.textBubbleView.frame = CGRectMake(view.frame.width - estimatedFrame.width - 16 - 8 - 16 - 10 - 4, 0, estimatedFrame.width + 16 + 8 + 10, estimatedFrame.height + 20 + 6)
                cell.profileImageView.hidden = true
//                cell.textBubbleView.backgroundColor = UIColor(red: 0, green: 137/255, blue: 249/255, alpha: 1)
                cell.messageTextView.textColor = UIColor.whiteColor()
                cell.bubbleImageView.tintColor = UIColor(red: 0, green: 137/255, blue: 249/255, alpha: 1)
                cell.bubbleImageView.image = ChatLogMessageCell.blueBubble
            }
        }

        return cell
    }

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(8, 0, 0, 0)
    }

    // MARK: Cell Layout

    //we'll need to calculate the width and the height of the cell.
    //let's calculate the height of the cell based on text amount

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {

        if let messageText = messages?[indexPath.item].text {
            let size = CGSizeMake(250, 1000)
            let options = NSStringDrawingOptions.UsesFontLeading.union(.UsesLineFragmentOrigin)
            let estimatedFrame = NSString(string: messageText).boundingRectWithSize(size, options: options, attributes: [NSFontAttributeName : UIFont.systemFontOfSize(18)], context: nil)
            return CGSizeMake(view.frame.width, estimatedFrame.height + 20)
        }

        return CGSizeMake(view.frame.width, 100)
    }

}
