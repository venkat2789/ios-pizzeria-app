//
//  RewardsView.swift
//  Pizzeria
//
//  Created by Venkatachalapathy Sivaprakasam on 5/23/22.
//

import SwiftUI

struct RewardsView: View {
    var body: some View {
        GeometryReader { g in
            
            NavigationView {
                
                ScrollView {
                    
                    VStack(alignment: .leading) {
                        Text("Reward Progress")
                            .font(.title3)
                        
                        Button(action: {}) {
                            Text("How does this work?")
                                .font(.caption)
                                .foregroundColor(Color.green)
                        }
                        .padding(.bottom, 20)
                        
                        HStack {
                            Spacer()
                            ProgressView(progress: 0.67)
                            Spacer()
                        }
                        .padding(.bottom, 20)
                        
                        Text("Recent Activity")
                            .font(.title3)
                        
                        List{
                            RewardItem(purchaseDate: "01 Jun 22", purchaseAmount: 10.00)
                            RewardItem(purchaseDate: "15 May 22", purchaseAmount: 20.00)
                            RewardItem(purchaseDate: "05 Apr 22", purchaseAmount: 15.00)
                        }
                        .frame(width: g.size.width - 30, height: 500)
                        
                    }
                    .padding()
                }
                .navigationTitle("My Rewards")
            }
        }
    }
}

struct RewardsView_Previews: PreviewProvider {
    static var previews: some View {
        RewardsView()
    }
}
