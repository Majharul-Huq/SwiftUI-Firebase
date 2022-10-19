//
//  DataManager.swift
//  SwiftUI-Firebase
//
//  Created by Majharul Huq on 2022/10/19.
//

import SwiftUI
import Firebase

class DataManager: ObservableObject {
    
    @Published var users: [User] = []
    
    init() {
        fetchUsers()
    }
    
    func fetchUsers(){
        users.removeAll()
        let db = Firestore.firestore()
        let ref = db.collection("Users")
        ref.getDocuments { snapshot, error in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            
            if let snapshot = snapshot {
                for document in snapshot.documents {
                    let data = document.data()
                    
                    let name = data["name"] as? String ?? ""
                    let age = data["age"] as? String ?? ""
                    
                    let user = User(id: "1", name: name, age: age)
                    self.users.append(user)
                }
            }
        }
    }
}
