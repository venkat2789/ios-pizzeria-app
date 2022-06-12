//
//  RewardsView.swift
//  Pizzeria
//
//  Created by Venkatachalapathy Sivaprakasam on 5/23/22.
//

import SwiftUI

struct RewardsView: View {
    var rewardsAvailable: Bool = false
    
    var body: some View {
        ZStack{
            NavigationView {
                ScrollView {
                    
                }
                .navigationTitle("My Rewards")
            }
            if(!rewardsAvailable) {
                NoItemsView(systemName: "dollarsign.circle", text: "There are no rewards available at this time. \n Come back later!")
            }
        }
    }
}

struct RewardsView_Previews: PreviewProvider {
    static var previews: some View {
        RewardsView()
    }
}
