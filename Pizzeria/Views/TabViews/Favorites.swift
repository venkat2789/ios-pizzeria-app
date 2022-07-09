//
//  FavoritesView.swift
//  Pizzeria
//
//  Created by Venkatachalapathy Sivaprakasam on 5/23/22.
//

import SwiftUI

struct Favorites: View {
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
                            NavigationLink(destination: Detail(pizza: pizza),
                                           label: {
                                VStack(alignment: .leading) {
                                    CategoryItem(pizza: pizza)
                                        .padding(.trailing, 15)
                                }
                            })
                        }
                    }
                }
                .navigationTitle("My Favorites")
            }
            if(filteredPizzas.count == 0) {
                ToBeDevelopedView(systemName: "heart", text: "You dont have any favorites yet.")
            }
        }
    }
}

struct Favorites_Previews: PreviewProvider {
    static var pizzas = ModelData().pizzas
    
    static var previews: some View {
        Favorites(items: Array(pizzas.prefix(5)))
    }
}
