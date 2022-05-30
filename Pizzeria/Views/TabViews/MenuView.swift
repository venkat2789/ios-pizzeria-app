//
//  MenuView.swift
//  Pizzeria
//
//  Created by Venkatachalapathy Sivaprakasam on 5/23/22.
//

import SwiftUI

struct MenuView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @State private var isDetailViewShown = false
    
    var body: some View {
        VStack{
            NavigationView {
                List(1...3, id: \.self) { index in
                    NavigationLink(destination: DetailView(isDetailViewShown: $isDetailViewShown), isActive: $isDetailViewShown,
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
    static var previews: some View {
        MenuView().environmentObject(ViewRouter())
    }
}
