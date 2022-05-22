//
//  ContentView.swift
//  Pizzeria
//
//  Created by Venkatachalapathy Sivaprakasam on 5/21/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: PizzaOrder.entity(), sortDescriptors: [], predicate: NSPredicate(format: "status != %@", Status.completed.rawValue))
    var orders: FetchedResults<PizzaOrder>
    
    @State var showOrderSheet: Bool = false
    
    
    var body: some View {
        NavigationView {
            List {
                ForEach(orders) { order in
                    HStack {
                        VStack(alignment: .leading) {
                            Text("\(order.pizzaType) - \(order.numberOfSlices) slices")
                                .font(.headline)
                        }
                        Spacer()
                        Button(action: {
                            updateOrder(order: order)
                        }) {
                            Text(order.orderStatus == .pending ? "Prepare" : "Complete")
                                .foregroundColor(.blue)
                        }
                    }
                    .frame(height: 50)
                }
                .onDelete { indexSet in
                    for index in indexSet {
                        viewContext.delete(orders[index])
                    }
                    do {
                        try viewContext.save()
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
            .listStyle(PlainListStyle())
            .navigationTitle("My Orders")
            .navigationBarItems(trailing: Button(action: {
                showOrderSheet = true
            }, label: {
                Image(systemName: "plus.circle")
                    .imageScale(.large)
            }))
            .sheet(isPresented: $showOrderSheet){
                OrderSheet()
            }
        }
    }
    
    func updateOrder(order: PizzaOrder) {
            let newStatus = order.orderStatus == .pending ? Status.preparing : .completed
            viewContext.performAndWait {
                order.orderStatus = newStatus
                try? viewContext.save()
            }
        }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
