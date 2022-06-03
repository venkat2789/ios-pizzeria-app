//
//  CategoryRow.swift
//
//  Created by Venkatachalapathy Sivaprakasam on 5/16/22.
//

import SwiftUI

struct CategoryRow: View {
    var categoryName: String
    var items: [Pizza]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(categoryName)
                .font(.headline)
                .padding(.leading, 15)
                .padding(.top, 10)
            
            ScrollView(.horizontal, showsIndicators: false){
                HStack(alignment: .top, spacing: 0) {
                    
                    ForEach(items) { pizza in
                        NavigationLink {
                            DetailView(pizza: pizza)
                        } label: {
                            CategoryItem(pizza: pizza)
                        }
                    }
                    
                }
            }
            .frame(height: 185)
        }
    }
}

struct CategoryRow_Previews: PreviewProvider {
    static var pizzas = ModelData().pizzas
    
    static var previews: some View {
        CategoryRow(
            categoryName: pizzas[0].category.rawValue,
            items: Array(pizzas.prefix(3))
        )
    }
}
