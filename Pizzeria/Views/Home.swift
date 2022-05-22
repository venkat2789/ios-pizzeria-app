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
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            Button(action: {
                viewRouter.currentPage = .list
            }) {
                Text("Go to ContentView")
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home().environmentObject(ViewRouter())
    }
}
