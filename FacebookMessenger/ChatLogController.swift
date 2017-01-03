//
//  ChatLogController.swift
//  FacebookMessenger
//
//  Created by Ronald Hernandez on 12/30/16.
//  Copyright © 2016 Ronaldoh1. All rights reserved.
//

import UIKit

class ChatLogController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    var friend: Friend? {
        didSet {
            navigationItem.title = friend?.name
            messages = friend?.messages?.allObjects as? [Message]
            messages = messages?.sort({$0.date!.compare($1.date!) == .OrderedAscending})
        }
    }

    var messages: [Message]?
    let cellID = "cellID"

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = UIColor.whiteColor()
        collectionView?.registerClass(ChatLogMessageCell.self, forCellWithReuseIdentifier: cellID)
    }


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

        if let imageName = messages?[indexPath.item].friend?.profileImageName {
            cell.profileImageView.image = UIImage(named: imageName)
        }

        if let messageText = messages?[indexPath.item].text {
            let size = CGSizeMake(250, 1000)
            let options = NSStringDrawingOptions.UsesFontLeading.union(.UsesLineFragmentOrigin)
            let estimatedFrame = NSString(string: messageText).boundingRectWithSize(size, options: options, attributes: [NSFontAttributeName : UIFont.systemFontOfSize(18)], context: nil)
            cell.messageTextView.frame = CGRectMake(40, 0, estimatedFrame.width + 16 + 16, estimatedFrame.height + 20)
            cell.textBubbleView.frame = CGRectMake(40, 0, estimatedFrame.width + 16 + 8, estimatedFrame.height + 20)
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
