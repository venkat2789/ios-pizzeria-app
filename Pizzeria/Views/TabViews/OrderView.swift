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
            VStack {
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
                
                Total(orders: orders)
                
                PlaceOrder()
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
    let couponApplied: Bool = false
    let couponValue = 0.50 //to be made dynamic
    
    var body: some View {
        VStack {
            if(couponApplied){
                Text("$" + String(format: "%.2f", calcCouponPrice(order: order, couponValue: couponValue)))
                    .font(.subheadline)
                
                Text("$" + String(format: "%.2f",  calcRoundedPrice(order: order)))
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .strikethrough()
            } else {
                Text("$" + String(format: "%.2f", calcRoundedPrice(order: order)))
                    .font(.subheadline)
            }
        }
    }
    
    func calcRoundedPrice(order: PizzaOrder) -> Double {
        let pizzaPrice = order.price * Double(order.numberOfSlices)
        let roundedPrice = round(pizzaPrice * 100)/100.00
        
        return roundedPrice
    }
    
    func calcCouponPrice(order: PizzaOrder, couponValue: Double) -> Double {
        let pizzaPrice = order.price * Double(order.numberOfSlices)
        let couponPrice = pizzaPrice - (pizzaPrice * couponValue)
        let roundedCouponPrice = round(couponPrice * 100)/100.00
        
        return roundedCouponPrice
    }
}

struct Total: View {
    var orders: FetchedResults<PizzaOrder>
    
    var body: some View {
        HStack {
            Text("Total")
                .font(.headline)
            
            Spacer()
            
            Text("$" + String(format: "%.2f", calcTotal(orders: orders)))
                .font(.headline)
        }
        .padding()
    }
    
    func calcTotal(orders: FetchedResults<PizzaOrder>) -> Double {
        var totalPrice = 0.00
        
        orders.forEach { order in
            let pizzaPrice = order.price * Double(order.numberOfSlices)
            totalPrice += pizzaPrice
        }
        let roundedTotalPrice = round(totalPrice * 100)/100.0
        
        return roundedTotalPrice
    }
}

struct PlaceOrder: View {
    var body: some View {
        Button(action: {}) {
            Text("Place Order")
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(width: 150, height: 45)
                .background(Color.red)
                .cornerRadius(15.0)
        }
        .padding()
    }
}
