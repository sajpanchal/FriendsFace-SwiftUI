//
//  FriendView.swift
//  FriendFace
//
//  Created by saj panchal on 2021-08-01.
//

import SwiftUI

struct FriendView: View {
    @Environment(\.managedObjectContext) var moc
    var fetchRequest: FetchRequest<Users>
    init(predicate: String) {
        fetchRequest = FetchRequest<Users>(entity: Users.entity(), sortDescriptors: [], predicate: NSPredicate(format: "\(predicate)"), animation: nil)
    }
   /* var user: User {
        var myUser: User?
        for user in users.users {
            if user.id == userId {
                myUser = user
                break
            }
            else {
                myUser = User(id: "", isActive: false, name: "", age: 0, company: "", email: "", address: "", about: "", registered: "", tags: [], friends: [])
            }
        }
        return myUser!
        
    }*/
    var body: some View {
        Form {
            Section(header:Text("Name")) {
                Text("\(fetchRequest.wrappedValue.first!.Name)")
            }
            Section(header: Text("Age")) {
                Text("\(fetchRequest.wrappedValue.first!.age)")
            }
            Section(header: Text("isActive")) {
                Text("\(String(fetchRequest.wrappedValue.first!.isActive))")
            }
            Section(header: Text("Company")) {
                Text("\(fetchRequest.wrappedValue.first!.Company)")
            }
            Section(header: Text("E-mail")) {
                Text("\(fetchRequest.wrappedValue.first!.Email)")
            }
            Section(header: Text("Address")) {
                Text("\(fetchRequest.wrappedValue.first!.Address)")
            }
            Section(header: Text("About")) {
                Text("\(fetchRequest.wrappedValue.first!.About)")
            }
            Section(header: Text("Registration Date")) {
                Text("\(fetchRequest.wrappedValue.first!.Registered)")
            }
            Section(header: Text("Tags")) {
                List {
                    ForEach(0..<fetchRequest.wrappedValue.first!.Tags.count) { index in
                        Text(fetchRequest.wrappedValue.first!.Tags[index])
                    }
                }
            }
        }.navigationBarTitle("Friend Details")
    }
}

struct FriendView_Previews: PreviewProvider {
    static var previews: some View {
        FriendView(predicate: "")
    }
}

