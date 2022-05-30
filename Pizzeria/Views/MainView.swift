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
        case .landing:
            TabViewRouter()
                .transition(.scale)
        case .home:
            HomeView()
                .transition(.scale)
        case .rewards:
            RewardsView()
                .transition(.scale)
        case .menu:
            MenuView()
                .transition(.scale)
        case .favorites:
            FavoritesView()
                .transition(.scale)
        case .order:
            OrderView()
                .transition(.scale)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView().environmentObject(ViewRouter())
    }
}
