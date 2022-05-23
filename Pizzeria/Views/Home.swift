//
//  Home.swift
//  Pizzeria
//
//  Created by Venkatachalapathy Sivaprakasam on 5/22/22.
//

import SwiftUI


struct Home: View {
    @EnvironmentObject var viewRouter: ViewRouter
    
    var body: some View {
        VStack{
            Text("Categories/Food Menu")
            Button(action: {
                withAnimation(){
                    viewRouter.currentPage = .detail
                }
            }) {
                Text("Go to DetailView")
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home().environmentObject(ViewRouter())
    }
}
