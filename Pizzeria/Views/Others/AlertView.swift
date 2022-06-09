//
//  AlertView.swift
//  Pizzeria
//
//  Created by Venkatachalapathy Sivaprakasam on 6/9/22.
//

import SwiftUI

struct AlertView: View {
    @Binding var presentAlert: Bool
    
    var body: some View {
        VStack(spacing: 10) {
            Text("Awesome!".uppercased())
                .bold()
                .kerning(2.0)
                .multilineTextAlignment(.center)
                .lineSpacing(4.0)
                .font(.footnote)
                .foregroundColor(.primary)
            
//            Text("SubTitle")
//                .kerning(-1.0)
//                .font(.largeTitle)
//                .fontWeight(.black)
//                .foregroundColor(.primary)
            
            Text("Item added!")
                .font(.title2)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
                .lineSpacing(10)
            
            Button(action: {
                withAnimation(){
                    presentAlert = false
                }
            }) {
                Text("Continue")
                    .bold()
                    .foregroundColor(.primary)
                    .padding(20)
                    .frame(maxWidth: .infinity)
                    .background(.red)
                    .cornerRadius(12.0)
            }
        }
                .frame(maxWidth: 250)
                .padding()
//                .frame(maxWidth: 300)
                .background(Color("LightGrayBackground"))
                .cornerRadius(CGFloat(21.0))
                .shadow(radius: 10, x: 5, y: 5)
                .transition(.move(edge: .bottom))
    }
}

struct AlertView_Previews: PreviewProvider {
    static var previews: some View {
        AlertView(presentAlert: Binding.constant(true))
    }
}
