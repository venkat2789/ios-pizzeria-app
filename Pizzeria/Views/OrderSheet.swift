//
//  OrderSheet.swift
//  Pizzeria
//
//  Created by Venkatachalapathy Sivaprakasam on 5/22/22.
//

import SwiftUI

struct OrderSheet: View {
    let pizzaTypes = ["Pizza Margherita", "Greek Pizza", "Pizza Supreme", "Pizza California", "New York Pizza"]
    
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) private var presentationMode
    @State var selectedPizzaIndex = 1
    @State var numberOfSlices = 1
    
    
    var body: some View {
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
                
                Button(action: {
                    let newOrder = PizzaOrder(context: viewContext)
                    newOrder.pizzaType = self.pizzaTypes[self.selectedPizzaIndex]
                    newOrder.orderStatus = .pending
                    newOrder.numberOfSlices = Int16(self.numberOfSlices)
                    newOrder.id = UUID()
                    
                    do {
                        try viewContext.save()
                        print("Order saved.")
                        presentationMode.wrappedValue.dismiss()//close order sheet
                    } catch {
                        print(error.localizedDescription)
                    }
                }) {
                    Text("Add Order")
                }
            }
            .navigationTitle("Add Order")
        }
    }
}

struct OrderSheet_Previews: PreviewProvider {
    static var previews: some View {
        OrderSheet()
    }
}
