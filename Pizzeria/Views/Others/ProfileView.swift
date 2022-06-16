//
//  ProfileView.swift
//  Pizzeria
//
//  Created by Venkatachalapathy Sivaprakasam on 6/15/22.
//

import SwiftUI

struct ProfileView: View {
    @Binding var user_name: String
    @Binding var user_phone_number: String
    @Binding var user_email: String
    @Binding var user_address: String
    
    var body: some View {
        VStack{
            NavigationView {
                UserInfoForm(name: $user_name, phoneNumber: $user_phone_number, email: $user_email, address: $user_address)
            }
            
            SaveButton()
                .padding()
            
            Spacer()
        }
        .background(Color("LightGrayBackground"))
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(
            user_name: Binding.constant("John Doe"),
            user_phone_number: Binding.constant("123-456-7890"),
            user_email: Binding.constant("abc@abc.com"),
            user_address: Binding.constant("123 Apple Way, NY 12345"))
    }
}

struct SaveButton: View {
    @Environment(\.presentationMode) private var presentationMode
    
    var body: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()//go back
        }) {
            Text("Save")
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(width: 150, height: 45)
                .background(Color.red)
                .cornerRadius(15.0)
        }
    }
}

struct UserInfoForm: View {
    @Binding var name: String
    @Binding var phoneNumber: String
    @Binding var email: String
    @Binding var address: String
    
    var body: some View {
        Form {
            Section(header: Text("Personal Information")) {
                TextField("Name", text: $name)
                    .textInputAutocapitalization(.words)
                    .disableAutocorrection(true)
                    .keyboardType(.default)
                TextField("Mobile", text: $phoneNumber)
                    .keyboardType(.phonePad)
                TextField("Email", text: $email)
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                    .keyboardType(.emailAddress)
            }
            
            Section(header: Text("Address")){
                TextField("Full address", text: $address)
                    .textInputAutocapitalization(.words)
                    .disableAutocorrection(true)
                    .keyboardType(.default)
            }
        }
        .navigationTitle("My Profile")
    }
}
