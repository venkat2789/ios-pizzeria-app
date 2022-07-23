//
//  AlertView.swift
//  Pizzeria
//
//  Created by Venkatachalapathy Sivaprakasam on 6/9/22.
//

import SwiftUI

struct AlertView: View {
    @Binding var presentAlert: Bool
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Awesome!".uppercased())
                .bold()
                .kerning(2.0)
                .multilineTextAlignment(.center)
                .lineSpacing(4.0)
                .font(.footnote)
                .foregroundColor(.primary)
            
            Text("Order \(Text("#\(randomString(length: 5))").bold().foregroundColor(.red)). Your pizza will be ready in 15-20 mins.")
                .font(.callout)
            
            Button(action: {
                withAnimation(){
                    presentAlert = false
                }
            }) {
                Text("Continue")
                    .font(.subheadline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 150, height: 45)
                    .background(Color.red)
                    .cornerRadius(15.0)
            }
        }
        .frame(maxWidth: 250)
        .padding()
        .background(colorScheme == .light ? Color("LightGrayBackground") : Color("BackgroundColor"))
        .cornerRadius(CGFloat(21.0))
        .shadow(radius: 10, x: 5, y: 5)
        .transition(.opacity)
        
    }
    
    func randomString(length: Int) -> String {
      let letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
      return String((0..<length).map{ _ in letters.randomElement()! })
    }
}

struct AlertView_Previews: PreviewProvider {
    static var previews: some View {
        AlertView(presentAlert: Binding.constant(true))
            
            
            
    }
}
