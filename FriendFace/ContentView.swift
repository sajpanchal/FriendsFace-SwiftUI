//
//  ContentView.swift
//  FriendFace
//
//  Created by saj panchal on 2021-08-01.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Users.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Users.name, ascending: true)], predicate: nil) var users: FetchedResults<Users>
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
            //deleteCoreData()
         })
     
    }
    func deleteCoreData() {
        for x in self.users {
            self.moc.delete(x)
            do {
                try self.moc.save()
                print("deleted")
            }
            catch {
                print("error")
            }
            
        }
       
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
                label:for entry in decodedData {
                    for x in self.users {
                        if entry.id == x.id {
                            continue label
                        }
                    }
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
                        if self.moc.hasChanges {
                            print("changes found")
                            try? self.moc.save()
                        }
                    }
                }
               // self.users = self.userObject.users
                for user in self.users {
                    print(self.users.count)
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

