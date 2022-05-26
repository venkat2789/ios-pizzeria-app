//
//  TabViewForIntro.swift
//  Pizzeria
//
//  Created by Venkatachalapathy Sivaprakasam on 5/25/22.
//

import SwiftUI

struct TabViewForIntro: View {
    var body: some View {
        TabView {
            Text("Who we are!")
                .tabItem {
                    Text("First")
                }
            Text("What we do!")
                .tabItem {
                    Text("Second")
                }
            Text("Why we matter!")
                .tabItem {
                    Text("Third")
                }
        }
        .background(.red)
        .frame(width: 300, height: 500, alignment: .center)
        .font(.headline)
        .tabViewStyle(PageTabViewStyle())
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
    }
}

struct TabViewForIntro_Previews: PreviewProvider {
    static var previews: some View {
        TabViewForIntro()
    }
}
