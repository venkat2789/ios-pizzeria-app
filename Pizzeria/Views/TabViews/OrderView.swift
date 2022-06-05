//
//  OrderView.swift
//  Pizzeria
//
//  Created by Venkatachalapathy Sivaprakasam on 5/22/22.
//

import SwiftUI

struct OrderView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: PizzaOrder.entity(), sortDescriptors: [], predicate: NSPredicate(format: "status != %@", Status.completed.rawValue))
    var orders: FetchedResults<PizzaOrder>
    @State var showAccountInfoSheet: Bool = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(orders) { order in
                    HStack {
                        PizzaInfo(order: order)
                        
                        Spacer()
                        
//                        Button(action: {
//                            updateOrder(order: order)
//                        }) {
//                            Text(order.orderStatus == .pending ? "Prepare" : "Complete")
//                                .foregroundColor(.blue)
//                        }
                        
                        Price(order: order)
                    }
                    .frame(height: 100)
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
            .navigationTitle("My Order")
            .navigationBarItems(trailing: Button(action: {
                showAccountInfoSheet = true
            }, label: {
                Image(systemName: "person.circle")
                    .imageScale(.large)
            }))
            .sheet(isPresented: $showAccountInfoSheet){
                AccountSheet()
            }
        }
    }
    
//    func updateOrder(order: PizzaOrder) {
//            let newStatus = order.orderStatus == .pending ? Status.preparing : .completed
//            viewContext.performAndWait {
//                order.orderStatus = newStatus
//                try? viewContext.save()
//            }
//        }
}

struct OrderView_Previews: PreviewProvider {
    static var previews: some View {
        OrderView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

struct PizzaInfo: View {
    var order: PizzaOrder
    
    var body: some View {
        Group {
            Image("pizza-placeholder")
                .resizable()
                .frame(width: 50, height: 50)
            VStack(alignment: .leading) {
                Text("\(order.pizzaType)")
                    .font(.headline)
                Text(" - \(order.numberOfSlices) slices")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
    }
}

struct Price: View {
    var order: PizzaOrder
    let couponApplied: Bool = true
    
    var body: some View {
        let pizzaPrice = order.price * Double(order.numberOfSlices)
        
        VStack {
            if(couponApplied){
                let couponPrice = pizzaPrice - (pizzaPrice * 0.20)
                let roundedCouponPrice = round(couponPrice * 100)/100.0
                Text(String("$\(roundedCouponPrice)"))
                    .font(.subheadline)
                
                Text(String("$\(pizzaPrice)"))
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .strikethrough()
            } else {
                let roundedPrice = round(pizzaPrice * 100)/100.0
                Text(String("$\(roundedPrice)"))
                    .font(.subheadline)
            }
        }
    }
}
