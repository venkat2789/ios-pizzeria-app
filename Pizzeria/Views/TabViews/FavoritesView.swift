//
//  FavoritesView.swift
//  Pizzeria
//
//  Created by Venkatachalapathy Sivaprakasam on 5/23/22.
//

import SwiftUI

struct FavoritesView: View {
    var items: [Pizza]
    let columns: [GridItem] =
    Array(repeating: .init(.fixed(185)), count: 2)
    
    var filteredPizzas: [Pizza] {
        items.filter { pizza in
            pizza.isFavorite
        }
    }
    
    var body: some View {
        ZStack{
            NavigationView {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 15){
                        ForEach(filteredPizzas) { pizza in
                            NavigationLink(destination: DetailView(pizza: pizza),
                                           label: {
                                VStack(alignment: .leading) {
                                    CategoryItem(pizza: pizza)
                                        .padding(.trailing, 15)
                                    
                                    PlaceholderText()
                                }
                            })
                        }
                    }
                }
                .navigationTitle("My Favorites")
            }
            if(filteredPizzas.count == 0) {
                NoItemsView(systemName: "heart", text: "You dont have any favorites yet.")
            }
        }
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var pizzas = ModelData().pizzas
    
    static var previews: some View {
        FavoritesView(items: Array(pizzas.prefix(5)))
    }
}
