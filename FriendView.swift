//
//  FriendView.swift
//  FriendFace
//
//  Created by saj panchal on 2021-08-01.
//

import SwiftUI

struct FriendView: View {
    @ObservedObject var users: Users
    @State var userId: String
    var user: User {
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
        
    }
    var body: some View {
        Form {
            Section(header:Text("Name")) {
                Text("\(user.name)")
            }
            Section(header: Text("Age")) {
                Text("\(user.age)")
            }
            Section(header: Text("isActive")) {
                Text("\(String(user.isActive))")
            }
            Section(header: Text("Company")) {
                Text("\(user.company)")
            }
            Section(header: Text("E-mail")) {
                Text("\(user.email)")
            }
            Section(header: Text("Address")) {
                Text("\(user.address)")
            }
            Section(header: Text("About")) {
                Text("\(user.about)")
            }
            Section(header: Text("Registration Date")) {
                Text("\(user.registered)")
            }
            Section(header: Text("Tags")) {
                List {
                    ForEach(0..<user.tags.count) { index in
                        Text(user.tags[index])
                    }
                }
            }
    }
    }
}

struct FriendView_Previews: PreviewProvider {
    static var previews: some View {
        FriendView(users: Users(), userId: "")
    }
}

