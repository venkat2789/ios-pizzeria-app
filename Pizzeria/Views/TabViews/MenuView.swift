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
            Text("This is Menu view")
            
            Button(action: {
                withAnimation(.default){
                    viewRouter.currentPage = .detail
                }
            }) {
                Text("Go to DetailView")
            }
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView().environmentObject(ViewRouter())
    }
}
