//
//  AccountSheet.swift
//  Pizzeria
//
//  Created by Venkatachalapathy Sivaprakasam on 5/22/22.
//

import SwiftUI

struct AccountSheet: View {
    @Environment(\.colorScheme) private var colorScheme
    @Binding var user_name: String
    @Binding var user_phone_number: String
    @Binding var user_email: String
    @Binding var user_address: String
    @Binding var showAccountInfoSheet: Bool
    
    var body: some View {
        NavigationView{
            VStack {
                CloseButton(showAccountInfoSheet: $showAccountInfoSheet)
                
                Header(user_name: $user_name, user_phone_number: $user_phone_number, user_email: $user_email, user_address: $user_address)
                
                Spacer()
                
                InfoList()
                
                LogOutButton()
                
                Spacer()
                
                Footer()
                
            }
            .navigationBarHidden(true)
            .background(colorScheme == .light ? Color("LightGrayBackground") : nil)
        }
    }
}

struct AccountSheet_Previews: PreviewProvider {
    static var previews: some View {
        AccountSheet(
            user_name: Binding.constant("John Doe"),
            user_phone_number: Binding.constant("123-456-7890"),
            user_email: Binding.constant("example@example.com"),
            user_address: Binding.constant("123 Apple Way, NY 12345"),
            showAccountInfoSheet: Binding.constant(true)).environmentObject(ViewRouter())
    }
}



struct LogOutButton: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @State private var showAlert: Bool = false
    
    var body: some View {
        Button(action: {
            showAlert = true
        }) {
            Text("Logout")
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(width: 150, height: 45)
                .background(Color.red)
                .cornerRadius(15.0)
        }
        .alert(isPresented: $showAlert){
            Alert(
                title: Text("Are you sure you want to logout?"),
                primaryButton: .destructive((Text("Confirm"))) {
                    withAnimation(){
                        viewRouter.currentPage = .login
                    }
                },
                secondaryButton: .cancel()
            )
        }
        
    }
}

struct InfoList: View {
    var body: some View {
        List{
            NavigationLink(destination: ToBeDevelopedView(systemName: "pencil.and.outline", text: "Come back soon, we are still building this section of the app.")){
                Text("Order History")
                    .font(.body)
            }
            .frame(height: 35)
            
            NavigationLink(destination: ToBeDevelopedView(systemName: "pencil.and.outline", text: "Come back soon, we are still building this section of the app.")){
                Text("Payment Methods")
                    .font(.body)
            }
            .frame(height: 35)
            
            NavigationLink(destination: ToBeDevelopedView(systemName: "pencil.and.outline", text: "Come back soon, we are still building this section of the app.")){
                Text("Saved Addresses")
                    .font(.body)
            }
            .frame(height: 35)
        }
        .listStyle(.grouped)
    }
}

struct Footer: View {
    var body: some View {
        HStack {
            Text("App Version")
            Text("1.0.1")
        }
        .font(.subheadline)
        .foregroundColor(.secondary)
        .padding()
    }
}

struct Header: View {
    @Binding var user_name: String
    @Binding var user_phone_number: String
    @Binding var user_email: String
    @Binding var user_address: String
    
    var body: some View {
        VStack(spacing: 5){
            Text(user_name)
                .font(.title3)
                .bold()
                .kerning(-0.5)
            Divider()
                .frame(width: 200)
            Text(user_email)
                .font(.subheadline)
            Text(user_phone_number)
                .font(.caption)
            
            NavigationLink(destination: ProfileView(user_name: $user_name, user_phone_number: $user_phone_number, user_email: $user_email, user_address: $user_address)){
                Text("Edit")
                    .font(.caption)
                    .padding(10)
            }
        }
        .padding(.top, 30)
    }
}

struct CloseButton: View {
    @Binding var showAccountInfoSheet: Bool
    
    var body: some View {
        HStack{
            Spacer()
            Button(action: {
                showAccountInfoSheet = false
            }){
                Image(systemName: "xmark.circle")
                    .imageScale(.large)
            }
        }
        .padding(10)
    }
}
