//
//  UserDetailsView.swift
//  FriendFace
//
//  Created by saj panchal on 2021-08-01.
//

import SwiftUI

struct UserDetailsView: View {
    @Environment(\.managedObjectContext) var moc
    var fetchRequest: FetchRequest<Users>
    init(predicate: String) {
        fetchRequest = FetchRequest<Users>(entity: Users.entity(), sortDescriptors: [], predicate: NSPredicate(format: "\(predicate)"), animation: nil)
    }
    
    
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
                        ForEach(0..<(fetchRequest.wrappedValue.first?.Tags.count)!) { index in
                            Text((fetchRequest.wrappedValue.first?.Tags[index])!)
                        }
                    }
                }
                Section(header: Text("Friends")) {
                    List {
                        ForEach(0..<(fetchRequest.wrappedValue.first?.Friends.count)!) { index in
                            NavigationLink(
                                destination: FriendView(predicate: "id == '\((fetchRequest.wrappedValue.first?.Friends[index].id)!)'"),
                                label: {
                                    Text((fetchRequest.wrappedValue.first?.Friends[index].name)!)
                                })
                        }
                    }
                }
        }.navigationBarTitle("User Details")
        }
    }


struct UserDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        UserDetailsView(predicate: "")
    }
}
