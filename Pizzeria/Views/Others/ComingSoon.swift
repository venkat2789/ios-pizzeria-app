//
//  ComingSoon.swift
//  Pizzeria
//
//  Created by Venkatachalapathy Sivaprakasam on 6/10/22.
//

import SwiftUI

struct ComingSoon: View {
    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: "pencil.and.outline")
                .font(.largeTitle)
                .foregroundColor(.red)
            Text("Come back soon, we are still building this section of the app.")
                .font(.title3)
                .kerning(-1.0)
                .multilineTextAlignment(.center)
        }
        .padding()
    }
}

struct ComingSoon_Previews: PreviewProvider {
    static var previews: some View {
        ComingSoon()
    }
}
