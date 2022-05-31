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
            VStack{
                VStack(alignment: .leading, spacing: 10.0) {
                    Text("Welcome,")
                        .font(.title)
                        .bold()
                        .padding(.top, 20)
                    
                    Text("Select from our amazing categories of pizza below or view the full menu.")
                        .font(.title3)
                        .padding(.bottom, 10)
                }
                .padding(.leading, 10)
                .padding(.trailing, 10)
                
                List {
                    //                PageView(pages: modelData.features.map { FeatureCard(landmark: $0) })
                    //                    .aspectRatio(3 / 2, contentMode: .fit)
                    //                    .listRowInsets(EdgeInsets())
                    
                    ForEach(modelData.categories.keys.sorted(), id: \.self) { key in
                        CategoryRow(categoryName: key, items: modelData.categories[key]!)
                            .padding(.bottom, 5)
                            .padding(.top, 5)
                    }
                    .listRowInsets(EdgeInsets())
                }
                .listStyle(.inset)
                //            .navigationTitle("Welcome,")
                .navigationBarHidden(true)
                .navigationBarBackButtonHidden(true)
                //            .toolbar {
                //                Button {
                //                    showingProfile.toggle()
                //                } label: {
                //                    Label("User Profile", systemImage: "person.crop.circle")
                //                }
                //            }
                //            .sheet(isPresented: $showingProfile) {
                //               ProfileHost()
                //                   .environmentObject(modelData)
                //            }
            }
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
