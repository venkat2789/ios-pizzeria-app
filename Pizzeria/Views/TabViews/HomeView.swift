//
//  HomeView.swift
//  Pizzeria
//
//  Created by Venkatachalapathy Sivaprakasam on 5/25/22.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    
    var body: some View {
        Text("This is HomeView")
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environmentObject(ViewRouter())
    }
}
