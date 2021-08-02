//
//  Friends+CoreDataProperties.swift
//  FriendFace
//
//  Created by saj panchal on 2021-08-02.
//
//
import Foundation
import CoreData


extension Friends {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Friends> {
        return NSFetchRequest<Friends>(entityName: "Friends")
    }
    
    @NSManaged public var id: String?
    public var Id: String {
        id ?? "N/A"
    }
    @NSManaged public var name: String?
    public var Name: String {
        name ?? "N/A"
    }
    @NSManaged public var users: Users?
   
}

extension Friends : Identifiable {
    
}
