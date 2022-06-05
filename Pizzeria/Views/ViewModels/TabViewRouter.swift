//
//  TabViewRouter.swift
//  Pizzeria
//
//  Created by Venkatachalapathy Sivaprakasam on 5/25/22.
//

import SwiftUI

struct TabViewRouter: View {
    @State private var selectedTab = 0 //for programmatic switching
    @EnvironmentObject var modelData: ModelData
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: PizzaOrder.entity(), sortDescriptors: [], predicate: NSPredicate(format: "status != %@", Status.completed.rawValue))
    var orders: FetchedResults<PizzaOrder>
    
    var body: some View {
        TabView (selection: $selectedTab) {
                Home()
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
                MenuView(items: modelData.pizzas)
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
                    .badge(orders.count)
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
