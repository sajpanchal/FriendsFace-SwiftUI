//
//  Users+CoreDataProperties.swift
//  FriendFace
//
//  Created by saj panchal on 2021-08-02.
//
//

import Foundation
import CoreData
import UIKit

extension Users {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Users> {
        return NSFetchRequest<Users>(entityName: "Users")
    }
    
    @NSManaged public var id: String?
    public var Id: String {
        id ?? "N/A"
    }
    @NSManaged public var isActive: Bool
    
    @NSManaged public var name: String?
    public var Name: String {
        name ?? "N/A"
    }
    @NSManaged public var age: Int16
    @NSManaged public var company: String?
    public var Company: String {
        company ?? "N/A"
    }
    @NSManaged public var email: String?
    public var Email: String {
        email ?? "N/A"
    }
    @NSManaged public var address: String?
    public var Address: String {
        address ?? "N/A"
    }
    @NSManaged public var about: String?
    public var About: String {
        about ?? "N/A"
    }
    @NSManaged public var registered: String?
    public var Registered: String {
        registered ?? "N/A"
    }
    @NSManaged public var tags: [String]?
    public var Tags: [String] {
        get {
            tags ?? []
        }
        set(newTags) {
            tags = newTags
        }
    }
    @NSManaged public var friends: NSSet?
    var Friends: [Friend] {
        
        get {
            let friendSet = friends as? Set<Friends> ?? []
            let friends = friendSet.sorted {
               // print($0.Name, $1.Name)
                return  ($0.Name < $1.Name)
            }
            var friendsStruct: [Friend] = []
            for friend in friends {
               
                let friendStruct = Friend(id: friend.Id, name: friend.Name)
                friendsStruct.append(friendStruct)
            }
            for x in friendsStruct {
               
            }
            return friendsStruct
        }
        
        set(newFriends) {
            var friendsArr: [Friends] = []
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            for newFriend in newFriends {
                let friend: Friends = FriendFace.Friends(context: context)
                friend.id = newFriend.id
                friend.name = newFriend.name
                friendsArr.append(friend)
            }
            let set = Set(friendsArr)
            friends =  set as NSSet
            
        }
        
    }
    
}

// MARK: Generated accessors for friends
extension Users {
    
    @objc(addFriendsObject:)
    @NSManaged public func addToFriends(_ value: Friends)
    
    @objc(removeFriendsObject:)
    @NSManaged public func removeFromFriends(_ value: Friends)
    
    @objc(addFriends:)
    @NSManaged public func addToFriends(_ values: NSSet)
    
    @objc(removeFriends:)
    @NSManaged public func removeFromFriends(_ values: NSSet)
    
}

extension Users : Identifiable {
    
}
