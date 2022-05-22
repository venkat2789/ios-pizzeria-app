//
//  MainView.swift
//  Pizzeria
//
//  Created by Venkatachalapathy Sivaprakasam on 5/22/22.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    
    var body: some View {
        switch viewRouter.currentPage {
        case .login:
            Login()
        case .home:
            Home()
                .transition(.scale)
        case .list:
            ContentView()
                .transition(.scale)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView().environmentObject(ViewRouter())
    }
}
