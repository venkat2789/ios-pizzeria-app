//
//  Home.swift
//
//  Created by Venkatachalapathy Sivaprakasam on 5/16/22.
//

import SwiftUI

struct Home: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @EnvironmentObject var modelData: ModelData
    
    var body: some View {
        NavigationView {
            VStack{
                WelcomeMessage()
                
                List {
                    ForEach(modelData.categories.keys.sorted(), id: \.self) { key in
                        CategoryRow(categoryName: key, items: modelData.categories[key]!)
                            .padding(.bottom, 5)
                            .padding(.top, 5)
                    }
                    .listRowInsets(EdgeInsets())
                }
                .listStyle(.inset)
                .navigationBarHidden(true)
                .navigationBarBackButtonHidden(true)
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
            .environmentObject(ModelData())
            .environmentObject(ViewRouter())
    }
}

struct WelcomeMessage: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 20.0) {
            Text("Welcome,")
                .font(.title)
                .bold()
                .padding(.top, 20)
            
            Text("Select from our amazing categories of pizza below or view the full menu.")
                .font(.headline)
                .padding(.bottom, 20)
        }
    }
}