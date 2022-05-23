//
//  DetailView.swift
//  Pizzeria
//
//  Created by Venkatachalapathy Sivaprakasam on 5/22/22.
//

import SwiftUI

struct DetailView: View {
    let pizzaTypes = ["Pizza Margherita", "Greek Pizza", "Pizza Supreme", "Pizza California", "New York Pizza"]
    
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var viewRouter: ViewRouter
    @State var selectedPizzaIndex = 1
    @State var numberOfSlices = 1
    
    var body: some View {
        VStack{
            Image("pizza-placeholder")
                .resizable()
                .ignoresSafeArea(edges: .top)
                .frame(height: 200)
            
            NavigationView {
                Form {
                    Section(header: Text("Pizza Details")) {
                        Picker(selection: $selectedPizzaIndex, label: Text("Pizza Type")) {
                            ForEach(0 ..< pizzaTypes.count, id:\.self) {
                                Text(self.pizzaTypes[$0]).tag($0)
                            }
                        }
                        
                        Stepper("\(numberOfSlices) Slices", value: $numberOfSlices, in: 1...12)
                    }
                }
                .navigationTitle("Order Details")
            }
            Button(action: {
                let newOrder = PizzaOrder(context: viewContext)
                newOrder.pizzaType = self.pizzaTypes[self.selectedPizzaIndex]
                newOrder.orderStatus = .pending
                newOrder.numberOfSlices = Int16(self.numberOfSlices)
                newOrder.id = UUID()
                
                do {
                    try viewContext.save()
                    print("Order saved.")
                    viewRouter.currentPage = .order
                    
                } catch {
                    print(error.localizedDescription)
                }
            }) {
                Text("Add to Order")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 150, height: 45)
                    .background(Color.red)
                    .cornerRadius(15.0)
            }
            .padding()
        }
        .background(Color("LightGrayBackground"))
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView().environmentObject(ViewRouter())
    }
}
