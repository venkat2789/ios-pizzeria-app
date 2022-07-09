//
//  AlertView.swift
//  Pizzeria
//
//  Created by Venkatachalapathy Sivaprakasam on 6/8/22.
//

import SwiftUI

struct ToastMessage: View {
    @Binding var presentAlert: Bool
    
    var body: some View {
        Text("Yum! pizza added 🍕")
            .font(.subheadline)
            .kerning(0.5)
            .foregroundColor(.white)
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

struct ToastMessage_Previews: PreviewProvider {
    static var previews: some View {
        ToastMessage(presentAlert: Binding.constant(true))
    }
}
