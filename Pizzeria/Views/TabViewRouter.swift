//
//  TabViewRouter.swift
//  Pizzeria
//
//  Created by Venkatachalapathy Sivaprakasam on 5/25/22.
//

import SwiftUI

struct TabViewRouter: View {
    
    var body: some View {
            TabView {
                HomeView()
                    .tabItem {
                        Image(systemName: "house")
                        Text("Home")
                    }
                RewardsView()
                    .tabItem {
                        Image(systemName: "dollarsign.circle")
                        Text("Rewards")
                    }
                MenuView()
                    .tabItem {
                        Image(systemName: "plus")
                        Text("Menu")
                    }
                FavoritesView()
                    .tabItem {
                        Image(systemName: "heart")
                        Text("Favorites")
                    }
                OrderView()
                    .badge(1)
                    .tabItem {
                        Image(systemName: "creditcard")
                        Text("My Order")
                    }
            }
            .font(.headline)
        }
}

struct TabViewRouter_Previews: PreviewProvider {
    static var previews: some View {
        TabViewRouter()
    }
}
