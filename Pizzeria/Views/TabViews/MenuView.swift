//
//  MenuView.swift
//  Pizzeria
//
//  Created by Venkatachalapathy Sivaprakasam on 5/23/22.
//

import SwiftUI

struct MenuView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    var items: [Pizza]
    let columns: [GridItem] =
    Array(repeating: .init(.flexible()), count: 2)
    
    var body: some View {
        VStack{
            NavigationView {
                ScrollView {
                    VStack {
                        Text("All Pizzas")
                            .font(.title3)
                            .bold()
                            .foregroundColor(.red)
                        Text("An amazing pizza quote here.")
                            .font(.subheadline)
                            .bold()
                            .foregroundColor(.secondary)
                    }
                    .padding()
                    
                    LazyVGrid(columns: columns, spacing: 15){
                        ForEach(items) { pizza in
                            NavigationLink(destination: DetailView(pizza: pizza),
                                           label: {
                                VStack(alignment: .leading) {
                                    CategoryItem(pizza: pizza)
                                    HStack {
                                        Text("Placeholder")
                                            .padding(.leading, 15)
                                            .font(.caption2)
                                            .foregroundColor(.secondary)
                                        Spacer()
                                    }
                                }
                            })
                        }
                    }
                }
                .navigationBarHidden(true)
            }
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var pizzas = ModelData().pizzas
    
    static var previews: some View {
        MenuView(items: Array(pizzas.prefix(5))).environmentObject(ViewRouter()).previewInterfaceOrientation(.portraitUpsideDown)
    }
}
