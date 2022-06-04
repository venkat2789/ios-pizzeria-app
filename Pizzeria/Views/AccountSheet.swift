//
//  AccountSheet.swift
//  Pizzeria
//
//  Created by Venkatachalapathy Sivaprakasam on 5/22/22.
//

import SwiftUI

struct AccountSheet: View {
    @State var name: String = ""
    @State var phoneNumber: String = ""
    @State var email: String = ""
    
    var body: some View {
        VStack {
            NavigationView {
                UserInfoForm(name: $name, phoneNumber: $phoneNumber, email: $email)
            }
            .frame(height: 325)
            
            SaveButton()
            
            Spacer()
            
            HStack {
                Text("App Version")
                Text("1.0.1")
            }
            .font(.subheadline)
            .foregroundColor(.secondary)
            
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
                TextField("Mobile", text: $phoneNumber)
                TextField("Email", text: $email)
            }
        }
        .navigationTitle("Profile")
    }
}
