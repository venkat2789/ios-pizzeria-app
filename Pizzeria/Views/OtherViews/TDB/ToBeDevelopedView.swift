//
//  ToBeDevelopedView.swift
//  Pizzeria
//
//  Created by Venkatachalapathy Sivaprakasam on 6/11/22.
//

import SwiftUI

struct ToBeDevelopedView: View {
    var systemName: String
    var text: String
    
    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: systemName)
                .font(.largeTitle)
                .foregroundColor(.red)
            Text(text)
                .font(.title3)
                .kerning(-1.0)
                .multilineTextAlignment(.center)
        }
        .padding()
    }
}

struct ToBeDevelopedView_Previews: PreviewProvider {
    static var previews: some View {
        ToBeDevelopedView(systemName: "cart", text: "Text goes here.")
    }
}
