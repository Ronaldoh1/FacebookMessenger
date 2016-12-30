//
//  FriendsViewController.swift
//  FacebookMessenger
//
//  Created by Ronald Hernandez on 12/29/16.
//  Copyright © 2016 Ronaldoh1. All rights reserved.
//

import UIKit
import CoreData

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

    func clearData() {
        let delegate = UIApplication.sharedApplication().delegate as? AppDelegate

        if let context = delegate?.managedObjectContext {
            do {
                let entityNames = ["Friend", "Message"]
                for entityName in entityNames {
                    let fetchRequest = NSFetchRequest(entityName: entityName)
                    let objects = try context.executeFetchRequest(fetchRequest) as? [NSManagedObject]
                    for object in objects! {
                        context.deleteObject(object)
                    }
                }

                try(context.save())

            } catch let error {
                print(error)
            }
        }
    }

    func setUpData() {
        clearData()
        let delegate = UIApplication.sharedApplication().delegate as? AppDelegate

        if let context = delegate?.managedObjectContext {
            guard let miguel = NSEntityDescription.insertNewObjectForEntityForName("Friend", inManagedObjectContext: context) as?  Friend else {
                return
            }

            miguel.name = "Miguel Alvarez"
            miguel.profileImageName = "vegeta"


           guard  let message = NSEntityDescription.insertNewObjectForEntityForName("Message", inManagedObjectContext: context) as?  Message else {
                return
            }

            message.friend = miguel
            message.date = NSDate()
            message.text = "I'm trying to turn up"

            guard let ronald = NSEntityDescription.insertNewObjectForEntityForName("Friend", inManagedObjectContext: context) as?  Friend else {
                return
            }
            ronald.name = "Ronald Hernandez"
            ronald.profileImageName = "goku"

            guard let message2 = NSEntityDescription.insertNewObjectForEntityForName("Message", inManagedObjectContext: context) as? Message else {
                return
            }

            message2.friend = ronald
            message2.date = NSDate()
            message2.text = "Me too"

            do {
                try context.save()
            } catch let error {
                print(error)
            }

        }

        loadData()
    }

    func loadData() {

        let delegate = UIApplication.sharedApplication().delegate as? AppDelegate

        if let context = delegate?.managedObjectContext {

            let fetchRequest = NSFetchRequest(entityName: "Message")
            do {
                messages = try context.executeFetchRequest(fetchRequest) as? [Message]
            }catch let error {
                print(error)
            }
        }

    }
}

