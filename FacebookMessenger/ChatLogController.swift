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

        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = UIColor.orangeColor()
    }

//
//    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
//        return 1
//    }
//
//    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 3
//
//    }

}
