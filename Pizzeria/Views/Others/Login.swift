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
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                
                BrandLogo()
                
                Spacer()
                
                UserName(username: $username)
                
                Password(password: $password)
                
                if(authFailure){ //consider making this as alert
                    AuthFailureMessage()
                }
                
                LoginButton(username: $username, password: $password, authSuccess: $authSuccess, authFailure: $authFailure)
                
            }
            .padding()
        }
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login().environmentObject(ViewRouter())
    }
}

struct BrandLogo: View {
    var body: some View {
        Image(systemName: "person.circle.fill")
            .resizable()
            .foregroundColor(.red)
            .aspectRatio(contentMode: .fill)
            .frame(width: 150, height: 150)
            .clipped()
            .cornerRadius(150)
            .padding(.bottom, 75)
    }
}

struct UserName: View {
    @Binding var username: String
    
    var body: some View {
        TextField("Username", text: $username)
            .padding()
            .background(Color("LightGrayBackground"))
            .cornerRadius(5.0)
            .padding(.bottom, 20)
    }
}

struct Password: View {
    @Binding var password: String
    
    var body: some View {
        SecureField("Password", text: $password)
            .padding()
            .background(Color("LightGrayBackground"))
            .cornerRadius(5.0)
            .padding(.bottom, 20)
    }
}

struct AuthFailureMessage: View {
    var body: some View {
        Text("Invalid credentials. Please try again!")
            .font(.caption)
            .bold()
            .foregroundColor(.red)
            .offset(y: -10)
    }
}

struct LoginButton: View {
    @Binding var username: String
    @Binding var password: String
    @Binding var authSuccess: Bool
    @Binding var authFailure: Bool
    @EnvironmentObject var viewRouter: ViewRouter
    
    let validUserName = "123"
    let validPassword = "123"
    
    var body: some View {
        Button(action: { //consider disabling until details are entered
            if (self.username == validUserName && self.password == validPassword) {
                self.authSuccess = true
                self.authFailure = false
                withAnimation(){
                    viewRouter.currentPage = .landing
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
}
