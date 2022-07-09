//
//  RewardItem.swift
//  Pizzeria
//
//  Created by Venkatachalapathy Sivaprakasam on 6/12/22.
//

import SwiftUI

struct RewardItem: View {
    var purchaseDate: String
    var purchaseAmount: Double
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5){
            
            HStack(spacing: 0) {
                Image(systemName: "gift")
                    .font(.title2)
                    .foregroundColor(.red)
                    .padding(.trailing, 10)
                
                VStack(alignment: .leading, spacing: 5) {
                    Text(purchaseDate)
                        .font(.subheadline)
                    Text("Points Earned")
                        .font(.headline)
                }
                
                Spacer()
                
                Image(systemName: "checkmark.circle")
                    .font(.headline)
                    .foregroundColor(.green)
                
                Text(" + \(getPoints(dollars: purchaseAmount)) points")
                    .font(.subheadline)
                    .kerning(-0.5)
            }
            
            Text(getPoints(dollars: purchaseAmount) + " points earned for purchase of $\(String(format: "%.2f", purchaseAmount))")
                .font(.caption)
                .foregroundColor(.secondary)
                .padding(.leading, 35)
        }
        .frame(height: 100)
    }
    
    func getPoints(dollars: Double) -> String{
        let points = dollars * 1.5
        return String(format: "%.0f", points)
    }
}

struct RewardItem_Previews: PreviewProvider {
    static var previews: some View {
        RewardItem(purchaseDate: "06/11/2022", purchaseAmount: 10.00)
    }
}
