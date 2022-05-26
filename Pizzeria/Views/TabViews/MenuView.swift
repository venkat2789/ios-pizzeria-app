//
//  MenuView.swift
//  Pizzeria
//
//  Created by Venkatachalapathy Sivaprakasam on 5/23/22.
//

import SwiftUI

struct MenuView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    
    var body: some View {
        VStack{
//            Text("This is Menu view")
            
            NavigationView {
                List(1...3, id: \.self) { index in
                    NavigationLink(
                        destination: DetailView(),
                        label: {
                            Text("Item #\(index)")
                                .font(.system(size: 20, weight: .bold, design: .rounded))
                        })
         
                }
         
                .navigationTitle("Pizzas")
            }
            
//            Button(action: {
//                withAnimation(.default){
//                    viewRouter.currentPage = .detail
//                }
//            }) {
//                Text("Go to DetailView")
//            }
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView().environmentObject(ViewRouter())
    }
}
