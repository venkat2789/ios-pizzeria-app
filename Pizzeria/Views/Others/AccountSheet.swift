//
//  AccountSheet.swift
//  Pizzeria
//
//  Created by Venkatachalapathy Sivaprakasam on 5/22/22.
//

import SwiftUI

struct AccountSheet: View {
    @AppStorage("user_name") var user_name = ""
    @AppStorage("user_phone_number") var user_phone_number = ""
    @AppStorage("user_email") var user_email = ""
    
    var body: some View {
        VStack {
            NavigationView {
                UserInfoForm(name: $user_name, phoneNumber: $user_phone_number, email: $user_email)
            }
            .frame(height: 325)
            
            SaveButton()
            
            Spacer()
            
            HStack {
                Text("App Version")
                Text("1.0.0")
            }
            .font(.subheadline)
            .foregroundColor(.secondary)
            .padding()
            
        }
        .background(Color("LightGrayBackground"))
    }
}

struct AccountSheet_Previews: PreviewProvider {
    static var previews: some View {
        AccountSheet()
    }
}

struct SaveButton: View {
    @Environment(\.presentationMode) private var presentationMode
    
    var body: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()//close order sheet
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
    
    var body: some View {
        Form {
            Section(header: Text("Contact Details")) {
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
        }
        .navigationTitle("Profile")
    }
}
