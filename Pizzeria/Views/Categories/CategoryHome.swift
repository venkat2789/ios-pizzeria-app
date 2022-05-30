//
//  CategoryHome.swift
//
//  Created by Venkatachalapathy Sivaprakasam on 5/16/22.
//

import SwiftUI

struct CategoryHome: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @EnvironmentObject var modelData: ModelData
    @State private var showingProfile = false

    var body: some View {
        NavigationView {
            List {
                Text("Select from our amazing categories of pizza below or view the full menu.")
                    .padding(.top)
                    .padding(.bottom)
//                PageView(pages: modelData.features.map { FeatureCard(landmark: $0) })
//                    .aspectRatio(3 / 2, contentMode: .fit)
//                    .listRowInsets(EdgeInsets())

                ForEach(modelData.categories.keys.sorted(), id: \.self) { key in
                    CategoryRow(categoryName: key, items: modelData.categories[key]!)
                        .padding(.bottom)
                }
                .listRowInsets(EdgeInsets())
            }
            .listStyle(.inset)
            .navigationTitle("Welcome,")
            .navigationBarBackButtonHidden(true)
//            .toolbar {
//                Button {
//                    showingProfile.toggle()
//                } label: {
//                    Label("User Profile", systemImage: "person.crop.circle")
//                }
//            }
//            .sheet(isPresented: $showingProfile) {
////                ProfileHost()
////                    .environmentObject(modelData)
//            }
        }
    }
}

struct CategoryHome_Previews: PreviewProvider {
    static var previews: some View {
        CategoryHome()
            .environmentObject(ModelData())
            .environmentObject(ViewRouter())
    }
}
