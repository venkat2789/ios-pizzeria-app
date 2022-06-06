//
//  FavoritesView.swift
//  Pizzeria
//
//  Created by Venkatachalapathy Sivaprakasam on 5/23/22.
//

import SwiftUI

struct FavoritesView: View {
    var body: some View {
        VStack {
            Text("This is Favorites view")
            MapView()
        }
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
    }
}
