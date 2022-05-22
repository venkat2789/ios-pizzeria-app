//
//  Login.swift
//  Pizzeria
//
//  Created by Venkatachalapathy Sivaprakasam on 5/21/22.
//

import SwiftUI

struct Login: View {
    @State var username: String = ""
    @State var password: String = ""
    @State var authSuccess: Bool = false
    @State var authFailure: Bool = false
    @EnvironmentObject var viewRouter: ViewRouter
    
    let validUserName = "123"
    let validPassword = "123"
    
    var body: some View {
        ZStack {
            VStack {
                Text("Welcome!")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .padding(.bottom, 20)
                
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .foregroundColor(.red)
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 150, height: 150)
                    .clipped()
                    .cornerRadius(150)
                    .padding(.bottom, 75)
                
                TextField("Username", text: $username)
                    .padding()
                    .background(Color("TextFieldBackground"))
                    .cornerRadius(5.0)
                    .padding(.bottom, 20)
                
                SecureField("Password", text: $password)
                    .padding()
                    .background(Color("TextFieldBackground"))
                    .cornerRadius(5.0)
                    .padding(.bottom, 20)
                
                if(authFailure){ //consider making this alert
                    Text("Invalid credentials. Please try again!")
                        .font(.caption)
                        .bold()
                        .foregroundColor(.red)
                        .offset(y: -10)
                }
                
                Button(action: { //consider disabling until details are entered
                    if (self.username == validUserName && self.password == validPassword) {
                        self.authSuccess = true
                        self.authFailure = false
                        withAnimation(){
                            viewRouter.currentPage = .home
                        }
                    } else {
                        self.authFailure = true
                        self.authSuccess = false
                    }
                }) {
                    Text("Login")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 220, height: 60)
                        .background(Color.red)
                        .cornerRadius(15.0)
                }
                
            }
            .padding()
            
//            if(authSuccess){
//                Text("Login successful!")
//                    .font(.headline)
//                    .frame(width: 220, height: 60)
//                    .background(Color.green)
//                    .cornerRadius(15.0)
//                    .foregroundColor(.white)
//            }
        }
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login().environmentObject(ViewRouter())
    }
}
