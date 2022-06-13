//
//  ProgressView.swift
//  Pizzeria
//
//  Created by Venkatachalapathy Sivaprakasam on 6/12/22.
//

import SwiftUI

struct ProgressView: View {
    @State var trimValue: Double = 0.0
    let progress: Double
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(
                    Color.pink.opacity(0.3),
                    lineWidth: 30
                )
            
            VStack {
                Image(systemName: "gift")
                    .font(.title)
                    .foregroundColor(.red)
                Text("\(progress * 100, specifier: "%.0f")/100")
                    .font(.subheadline)
                .bold()
            }
            
            Circle()
                .trim(from: 0, to: trimValue)
                .stroke( // 1
                    Color.accentColor,
                    style: StrokeStyle(
                         lineWidth: 30,
                         lineCap: .round
                     )
                )
                .animation(.easeIn(duration: 1.0), value: trimValue)
                .rotationEffect(.degrees(-90))
                .onAppear {
                        self.trimValue = progress
                }
        }
        .padding()
        .frame(width: 200, height: 200, alignment: .center)
    }
}

struct ProgressView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressView(progress: 0.25)
    }
}
