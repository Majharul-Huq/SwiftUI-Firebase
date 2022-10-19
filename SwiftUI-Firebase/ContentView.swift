//
//  ContentView.swift
//  SwiftUI-Firebase
//
//  Created by Majharul Huq on 2022/10/18.
//

import SwiftUI
import Firebase

struct ContentView: View {
    
    @State private var email = ""
    @State private var password = ""
    @State private var userIsLoggedIn = false
    
    var body: some View {
        if userIsLoggedIn {
            UserListView()
        } else {
            content
        }
    }
    
    var content: some View {
        ZStack{
            Color.black

            RoundedRectangle(cornerRadius: 30, style: .continuous)
                .foregroundStyle(.linearGradient(colors: [.green, .blue], startPoint: .topLeading, endPoint: .bottomTrailing))
                .frame(width: 1000, height: 400)
                .rotationEffect(.degrees(135))
                .offset(y: -350)
            
            VStack{
                Text("Welcome Firebase")
                    .foregroundColor(.white)
                    .font(.system(size: 36, weight: .bold, design: .rounded))
                    .offset(x: -30, y: -100)
                
                TextField("Email", text: $email)
                    .foregroundColor(.white)
                    .textFieldStyle(.plain)
                    .placeholder(when: email.isEmpty) {
                        Text("Email")
                            .foregroundColor(.white)
                            .font(.system(size: 20))
                            .bold()
                    }
                
                Rectangle()
                    .frame(width: 350, height: 1)
                    .foregroundColor(.white)
                
                SecureField("Password", text: $password)
                    .foregroundColor(.white)
                    .textFieldStyle(.plain)
                    .placeholder(when: password.isEmpty) {
                        Text("Password")
                            .foregroundColor(.white)
                            .font(.system(size: 20))
                            .bold()
                    }
                
                Rectangle()
                    .frame(width: 350, height: 1)
                    .foregroundColor(.white)
                
                Button{
                    register()
                }label: {
                    Text("Sign Up")
                        .bold()
                        .font(.system(size: 20))
                        .frame(width: 260, height: 50)
                        .background(
                            RoundedRectangle(cornerRadius: 12, style: .continuous)
                                .fill(.linearGradient(colors: [.blue, .blue], startPoint: .top, endPoint: .bottomTrailing))
                        )
                        .foregroundColor(.white)
                }
                .padding(.top)
                .offset(y: 40)
                
                Button{
                    // login here
                }label: {
                    Text("Already have an Account? Login")
                        .bold()
                        .font(.system(size: 20))
                        .foregroundColor(.white)
                }
                .padding(.top)
                .offset(y: 80)
                
                
            }
            .frame(width: 350)
            .onAppear{
                Auth.auth().addStateDidChangeListener { auth, user in
                    if user != nil {
                        userIsLoggedIn.toggle()
                    }
                }
            }
            
            
        }.ignoresSafeArea()
    }
    
    func register(){
        Auth.auth().createUser(withEmail: email, password: password){ result, error in
            if error != nil{
                print("regster error " + error!.localizedDescription)
            }
            
        }
    }
    
    func login(){
        Auth.auth().signIn(withEmail: email, password: password){ result, error in
            if error != nil {
                print("login error " + error!.localizedDescription)
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension View {
    func placeholder<Content: View> (
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder : () -> Content) -> some View {
            ZStack(alignment: alignment){
                placeholder().opacity(shouldShow ? 1 : 0)
                self
                
            }
        }
}

