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

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        tabBarController?.tabBar.hidden = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.alwaysBounceVertical = true

        collectionView?.registerClass(MessageCell.self, forCellWithReuseIdentifier: cellID)
        collectionView?.backgroundColor = UIColor.whiteColor()

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

    // MARK: UICollectionViewDelegate

    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let layout = UICollectionViewFlowLayout()
        let chatLogController = ChatLogController(collectionViewLayout: layout)
        chatLogController.friend = messages![indexPath.item].friend
        navigationController?.pushViewController(chatLogController, animated: true)
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


           FriendsViewController.createMessageWithText("I'm trying to turn up...", friend: miguel, context: context, minutesAgo: 2)

            createRonaldMessageWithContext(context)



            guard let donald = NSEntityDescription.insertNewObjectForEntityForName("Friend", inManagedObjectContext: context) as?  Friend else {
                return
            }
            donald.name = "Donald Trump"
            donald.profileImageName = "buu"

            FriendsViewController.createMessageWithText("You're Fired!", friend: donald, context: context, minutesAgo: 0)

            guard let superRonald = NSEntityDescription.insertNewObjectForEntityForName("Friend", inManagedObjectContext: context) as?  Friend else {
                return
            }
            superRonald.name = "Super Ronadl"
            superRonald.profileImageName = "me"
            FriendsViewController.createMessageWithText("Love, Peace and Joy", friend: superRonald, context: context, minutesAgo: 60 * 24)

            do {
                try context.save()
            } catch let error {
                print(error)
            }

        }

        loadData()
    }

    func createRonaldMessageWithContext(context: NSManagedObjectContext) {
        guard let ronald = NSEntityDescription.insertNewObjectForEntityForName("Friend", inManagedObjectContext: context) as?  Friend else {
            return
        }
        ronald.name = "Ronald Hernandez"
        ronald.profileImageName = "goku"

        FriendsViewController.createMessageWithText("Good Morning...It's finally Monday. The day has come", friend: ronald, context: context, minutesAgo: 3)
        FriendsViewController.createMessageWithText("Hello, how are you? hope you're having a good morning? It's great outside", friend: ronald, context: context, minutesAgo: 3)
        FriendsViewController.createMessageWithText("Are you interested in buying an Apple Device? We have a wide variety of apple devices that will suit your needs.", friend: ronald, context: context, minutesAgo: 1)

        //Response:
        FriendsViewController.createMessageWithText("I'm doing terrific", friend: ronald, context: context, minutesAgo: 1, isSender: true)
       FriendsViewController.createMessageWithText("I really want to go out dont have time think about phones", friend: ronald, context: context, minutesAgo: 1, isSender: true)
        FriendsViewController.createMessageWithText("I also want to turn up", friend: ronald, context: context, minutesAgo: 1, isSender: false)

        
    }

   static func createMessageWithText(text: String, friend: Friend, context: NSManagedObjectContext, minutesAgo: Double, isSender: Bool = false) -> Message {
        let message = NSEntityDescription.insertNewObjectForEntityForName("Message", inManagedObjectContext: context) as! Message

        message.friend = friend
        message.date = NSDate().dateByAddingTimeInterval(minutesAgo * 60)
        message.text = text
        message.isSender = NSNumber(bool: isSender)

        return message
    }

    func loadData() {

        let delegate = UIApplication.sharedApplication().delegate as? AppDelegate

        if let context = delegate?.managedObjectContext {

            guard let friends = fetchFriends() else {
                return
            }

            messages = [Message]()

            for friend in friends {
                print(friend.name)
                let fetchRequest = NSFetchRequest(entityName: "Message")
                fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
                fetchRequest.predicate = NSPredicate(format: "friend.name = %@", friend.name!)
                fetchRequest.fetchLimit = 1
                do {
                    let fetchedMessages = try context.executeFetchRequest(fetchRequest) as? [Message]
                    messages?.appendContentsOf(fetchedMessages!)

                }catch let error {
                    print(error)
                }
            }
            messages = messages?.sort({ $0.date!.compare($1.date!) == .OrderedDescending})
        }
    }

    func fetchFriends() -> [Friend]? {
        let delegate = UIApplication.sharedApplication().delegate as? AppDelegate

        if let context = delegate?.managedObjectContext {
            let request = NSFetchRequest(entityName: "Friend")
            do {

               return try context.executeFetchRequest(request) as? [Friend]

            } catch let error {
                print(error)
            }
        }

        return nil
    }
}

