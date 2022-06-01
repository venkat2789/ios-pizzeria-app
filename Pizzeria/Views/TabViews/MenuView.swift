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
    
    var body: some View {
        VStack{
            NavigationView {
                List(1...2, id: \.self) { index in
                    NavigationLink(destination: DetailView(pizza: items[index]),
                        label: {
                            Text("Item #\(index)")
                            .font(.system(size: 20, weight: .bold, design: .rounded))
                    })
                }
                .navigationBarBackButtonHidden(true)
                .navigationTitle("Pizzas")
            }
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var pizzas = ModelData().pizzas
    
    static var previews: some View {
        MenuView(items: Array(pizzas.prefix(3))).environmentObject(ViewRouter())
    }
}
