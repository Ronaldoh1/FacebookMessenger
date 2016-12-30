//
//  FriendsViewController.swift
//  FacebookMessenger
//
//  Created by Ronald Hernandez on 12/29/16.
//  Copyright © 2016 Ronaldoh1. All rights reserved.
//

import UIKit

class FriendsViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    private let cellID = "cellID"

    private var messages: [Message]?

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.alwaysBounceVertical = true
        collectionView!.backgroundColor = UIColor.blueColor()

        collectionView?.registerClass(MessageCell.self, forCellWithReuseIdentifier: cellID)

        navigationItem.title = "Recent"

        setUpData()
    }


    //MARK: UICollectionView DataSource
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = messages?.count {
            return count
        }
        return 0
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellID, forIndexPath: indexPath) as! MessageCell
        if let message = messages?[indexPath.item] {
            cell.message = message
        }

        return cell
    }

    //MARK: UICollectionViewDelegateFlowLayout

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(view.frame.width, 100)
    }

}

extension FriendsViewController {

    // MARK: Helper Methods

    func setUpData() {
        let miguel = Friend()
        miguel.name = "Miguel Alvarez"
        miguel.profileImageName = "vegeta"

        let message = Message()
        message.friend = miguel
        message.date = NSDate()
        message.text = "I'm trying to turn up"
        
        let ronald = Friend()
        ronald.name = "Miguel Alvarez"
        ronald.profileImageName = "goku"

        let message2 = Message()
        message2.friend = ronald
        message2.date = NSDate()
        message2.text = "Me too"

        messages = [message, message2]
        
    }
    
}

