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
    @FetchRequest(entity: PizzaOrder.entity(), sortDescriptors: [])
    var orders: FetchedResults<PizzaOrder>
    
    var body: some View {
        TabView (selection: $selectedTab) {
                Home()
                    .tabItem {
                        Image(systemName: "house")
                        Text("Home")
                    }
                    .tag(0)
                Rewards()
                    .tabItem {
                        Image(systemName: "dollarsign.circle")
                        Text("Rewards")
                    }
                    .tag(1)
                Menu(items: modelData.pizzas)
                    .tabItem {
                        Image(systemName: "plus")
                        Text("Menu")
                    }
                    .tag(2)
                Favorites(items: modelData.pizzas)
                    .tabItem {
                        Image(systemName: "heart")
                        Text("Favorites")
                    }
                    .tag(3)
                Orders()
                    .badge(orders.count)
                    .tabItem {
                        Image(systemName: "creditcard")
                        Text("My Order")
                    }
                    .tag(4)
            }
            .font(.headline)
        }
}

struct TabViewRouter_Previews: PreviewProvider {
    static var previews: some View {
        TabViewRouter()
            .environmentObject(ModelData())
    }
}
