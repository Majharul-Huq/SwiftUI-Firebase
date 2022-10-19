//
//  SwiftUI_FirebaseApp.swift
//  SwiftUI-Firebase
//
//  Created by Majharul Huq on 2022/10/18.
//

import SwiftUI
import Firebase

@main
struct SwiftUI_FirebaseApp: App {
    
    @StateObject var dataManager = DataManager()
    
    init(){
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            UserListView()
                .environmentObject(dataManager)
        }
    }
}
