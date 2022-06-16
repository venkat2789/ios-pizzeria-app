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
    
    
    var body: some View {
        NavigationView{
            VStack {
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
                    
                    Button(action: {}){
                        Text("Edit")
                            .font(.caption)
                    }
                    .padding(10)
                    
                }
                .padding(30)
                
                Spacer()
                
                List{
                    NavigationLink(destination: NoItemsView(systemName: "pencil.and.outline", text: "Come back soon, we are still building this section of the app.")){
                        Text("Order History")
                            .font(.body)
                    }
                    .frame(height: 35)
                    
                    NavigationLink(destination: NoItemsView(systemName: "pencil.and.outline", text: "Come back soon, we are still building this section of the app.")){
                        Text("Payment Methods")
                            .font(.body)
                    }
                    .frame(height: 35)
                    
                    NavigationLink(destination: NoItemsView(systemName: "pencil.and.outline", text: "Come back soon, we are still building this section of the app.")){
                        Text("Saved Addresses")
                            .font(.body)
                    }
                    .frame(height: 35)
                }
                .listStyle(.grouped)
                
                Button(action: {
                    //
                }) {
                    Text("Log out")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 150, height: 45)
                        .background(Color.red)
                        .cornerRadius(15.0)
                }
                
                Spacer()
                
                HStack {
                    Text("App Version")
                    Text("1.0.0")
                }
                .font(.subheadline)
                .foregroundColor(.secondary)
                .padding()
                
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
            user_address: Binding.constant("123 Apple Way, NY 12345"))
    }
}


