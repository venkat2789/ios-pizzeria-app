//
//  TabViewRouter.swift
//  Pizzeria
//
//  Created by Venkatachalapathy Sivaprakasam on 5/25/22.
//

import SwiftUI

struct TabViewRouter: View {
    @State private var selectedTab = 0 //useful for programmatically switching tabs
    
    var body: some View {
        TabView (selection: $selectedTab) {
                CategoryHome()
                    .tabItem {
                        Image(systemName: "house")
                        Text("Home")
                    }
                    .tag(0)
                RewardsView()
                    .tabItem {
                        Image(systemName: "dollarsign.circle")
                        Text("Rewards")
                    }
                    .tag(1)
                MenuView()
                    .tabItem {
                        Image(systemName: "plus")
                        Text("Menu")
                    }
                    .tag(2)
                FavoritesView()
                    .tabItem {
                        Image(systemName: "heart")
                        Text("Favorites")
                    }
                    .tag(3)
                OrderView()
                    .badge(1)
                    .tabItem {
                        Image(systemName: "creditcard")
                        Text("My Order")
                    }
                    .tag(4)
            }
            .font(.headline)
            .accentColor(.red)// remove and set this in assets
        }
}

struct TabViewRouter_Previews: PreviewProvider {
    static var previews: some View {
        TabViewRouter()
            .environmentObject(ModelData())
    }
}
