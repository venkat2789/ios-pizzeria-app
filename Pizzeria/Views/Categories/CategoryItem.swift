//
//  CategoryItem.swift
//
//  Created by Venkatachalapathy Sivaprakasam on 5/16/22.
//

import SwiftUI

struct CategoryItem: View {
    var pizza: Pizza
    
    var body: some View {
        VStack(alignment: .leading) {
            pizza.image
                .renderingMode(.original)
                .resizable()
                .frame(width: 155, height: 155)
                .cornerRadius(5)
            
            HStack(spacing: 3) {
                Text(pizza.name)
                    .foregroundColor(.primary)
                    .font(.caption)
                    .bold()
                
                Image(systemName: "flame.circle")
                    .font(.subheadline)
                    .foregroundColor(.red)
                
                Image(systemName: "leaf.circle")
                    .font(.subheadline)
                    .foregroundColor(.green)
            }
        }
        .padding(.leading, 15)
        .frame(width: 170)
    }
}

struct CategoryItem_Previews: PreviewProvider {
    static var previews: some View {
        CategoryItem(pizza: ModelData().pizzas[0])
    }
}
