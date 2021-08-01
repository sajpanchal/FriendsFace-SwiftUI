//
//  UserDetailsView.swift
//  FriendFace
//
//  Created by saj panchal on 2021-08-01.
//

import SwiftUI

struct UserDetailsView: View {
    @ObservedObject var users: Users
    @State var user: User
    var body: some View {
        NavigationView {
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
                Section(header: Text("Friends")) {
                    List {
                        ForEach(0..<user.friends.count) { index in
                            NavigationLink(
                                destination: FriendView(users: users, userId: user.friends[index].id),
                                label: {
                                    Text(user.friends[index].name)
                                })
                            
                        }
                    }
                }
                
            }
        }
    }
}

struct UserDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        UserDetailsView(users: Users(), user: User(id: "", isActive: false, name: "", age: 0, company: "", email: "", address: "", about: "", registered: "", tags: [], friends: []))
    }
}
