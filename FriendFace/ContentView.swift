//
//  ContentView.swift
//  FriendFace
//
//  Created by saj panchal on 2021-08-01.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Users.entity(), sortDescriptors: [], predicate: nil) var users: FetchedResults<Users>
    @FetchRequest(entity: Friends.entity(), sortDescriptors: [], predicate: nil) var friends: FetchedResults<Friends>
    var body: some View {
         NavigationView {
            Form {
               
                List {
                    ForEach(users, id: \.id) { user in
                        NavigationLink(
                            destination: UserDetailsView(predicate: "name == '\(user.Name)'"),
                            label: {
                                Text(user.Name)
                            })
                        
                    }
                }
            }.navigationBarTitle("FriendsFace")
         }.onAppear(perform: {
            fetchData()
         })
     
    }
     func fetchData() {
       // var users: [User] = []
        print("on appear")
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            print("Invalid URL")
            return
        }
        let urlRequest = URLRequest(url: url)
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            let decoder = JSONDecoder()
            guard let data = data else {
                return
            }
            guard let decodedData = try? decoder.decode([User].self, from: data) else {
            return
            }
            DispatchQueue.main.async {
//                self.users = decodedData
                for entry in decodedData {
                    let user = Users(context: moc)
                    user.id = entry.id
                    user.name = entry.name
                    user.isActive = entry.isActive
                    user.age = Int16(entry.age)
                    user.company = entry.company
                    user.email = entry.email
                    user.address = entry.address
                    user.about = entry.about
                    user.registered = entry.registered
                    user.Tags = entry.tags
                    user.Friends = entry.friends
                    do {
                        
                            try? self.moc.save()
                        
                    }
                }
               // self.users = self.userObject.users
                for user in self.users {
                    print("users:\(user.Name)",user.Friends)
                }
            }
           
           
            
        }.resume()
     
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

/*
 
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
 convenience init(id: String, name: String) {
 self.init()
 self.id = id
 self.name = name
 }
 }
 
 extension Friends : Identifiable {
 
 }
 */

/*
 import Foundation
 import CoreData
 
 
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
 $0.Name < $1.Name
 }
 var friendsStruct: [Friend] = []
 for friend in friends {
 let friendStruct = Friend(id: friend.Id, name: friend.Name)
 friendsStruct.append(friendStruct)
 }
 return friendsStruct
 }
 
 set(newFriends) {
 var friendsArr: [Friends] = []
 for newFriend in newFriends {
 let friend: Friends = FriendFace.Friends(id: newFriend.id, name: newFriend.name)
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

 */
