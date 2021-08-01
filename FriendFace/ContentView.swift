//
//  ContentView.swift
//  FriendFace
//
//  Created by saj panchal on 2021-08-01.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var userObject: Users = Users()
    @State var users = [User]()
   
    var body: some View {
         NavigationView {
            Form {
               
                List {
                    ForEach(userObject.users, id: \.id) { user in
                        NavigationLink(
                            destination: UserDetailsView(users: userObject, user: user),
                            label: {
                                Text(user.name)
                            })
                        
                    }
                }
            }.navigationBarTitle("FriendsFace")
         }.onAppear(perform: {
            userObject.users = fetchData()
         })
     
    }
     func fetchData() -> [User] {
       // var users: [User] = []
        print("on appear")
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            print("Invalid URL")
            return []
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
                self.userObject.users = decodedData
                self.users = self.userObject.users
                for user in self.users {
                    print("users:",user.name)
                }
            }
           
           
            
        }.resume()
        return users
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

