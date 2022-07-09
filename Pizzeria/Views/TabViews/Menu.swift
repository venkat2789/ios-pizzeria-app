//
//  MenuView.swift
//  Pizzeria
//
//  Created by Venkatachalapathy Sivaprakasam on 5/23/22.
//

import SwiftUI

struct Menu: View {
    @EnvironmentObject var viewRouter: ViewRouter
    var items: [Pizza]
    let columns: [GridItem] =
    Array(repeating: .init(.fixed(185)), count: 2)
    
    var body: some View {
        VStack{
            NavigationView {
                ScrollView {
                    
                    SubHeading()
                    
                    LazyVGrid(columns: columns, spacing: 15){
                        ForEach(items) { pizza in
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
                .navigationTitle("All Pizzas")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}

struct Menu_Previews: PreviewProvider {
    static var pizzas = ModelData().pizzas
    
    static var previews: some View {
        Menu(items: Array(pizzas.prefix(5))).environmentObject(ViewRouter())
    }
}

struct SubHeading: View {
    var body: some View {
        VStack {
            Text("An amazing pizza quote here.")
                .font(.subheadline)
                .bold()
                .foregroundColor(.secondary)
        }
    }
}
