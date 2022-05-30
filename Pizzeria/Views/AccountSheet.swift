//
//  AccountSheet.swift
//  Pizzeria
//
//  Created by Venkatachalapathy Sivaprakasam on 5/22/22.
//

import SwiftUI

struct AccountSheet: View {
    @Environment(\.presentationMode) private var presentationMode
    
    var body: some View {
        VStack {
            NavigationView {
                Form {
                    Section(header: Text("Contact Details")) {
                        Text("Name")
                        Text("Contact")
                    }
//                    Section(header: Text("ABOUT")) {
//                        HStack {
//                            Text("App Version")
//                            Spacer()
//                            Text("1.0.0")
//                        }
//                    }
                    
                }
                .navigationTitle("Profile")
            }
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
            Spacer()
        }
        .background(Color("LightGrayBackground"))
    }
}

struct AccountSheet_Previews: PreviewProvider {
    static var previews: some View {
        AccountSheet()
    }
}
