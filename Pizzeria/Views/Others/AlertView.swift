//
//  AlertView.swift
//  Pizzeria
//
//  Created by Venkatachalapathy Sivaprakasam on 6/8/22.
//

import SwiftUI

struct AlertView: View {
    @Binding var presentAlert: Bool
    
    var body: some View {
        Text("Item added!")
            .font(.subheadline)
            .bold()
            .frame(width: 240, height: 30)
            .background(.red)
            .cornerRadius(10.0)
            .onAppear{
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                    withAnimation(.linear(duration: 0.5)){
                        self.presentAlert = false
                    }
                }
            }
            .transition(.move(edge: .top))
    }
    
}

struct AlertView_Previews: PreviewProvider {
    static var previews: some View {
        AlertView(presentAlert: Binding.constant(true))
    }
}
