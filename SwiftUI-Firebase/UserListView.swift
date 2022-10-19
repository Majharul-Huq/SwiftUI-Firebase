//
//  UserListView.swift
//  SwiftUI-Firebase
//
//  Created by Majharul Huq on 2022/10/19.
//

import SwiftUI
import Firebase

struct UserListView: View {
    
    @EnvironmentObject var dataManager: DataManager
    var body: some View {
        
        NavigationView{
            List(dataManager.users, id: \.id){ user in
                VStack{
                    Text("name : " + user.name)
                    Text("age : " + user.age)
                }
            }
            .navigationTitle("Users")
            .navigationBarItems(trailing: Button(action: {
                //add
            }, label: {
                Image(systemName: "plus")
            }))
        }
    }
}

struct UserListView_Previews: PreviewProvider {
    static var previews: some View {
        UserListView()
            .environmentObject(DataManager())
    }
}
