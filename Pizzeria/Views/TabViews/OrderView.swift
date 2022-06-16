//
//  OrderView.swift
//  Pizzeria
//
//  Created by Venkatachalapathy Sivaprakasam on 5/22/22.
//

import SwiftUI

let couponValue = 0.50 //to be made dynamic
let validCouponCode = "GET50OFF"

struct OrderView: View {
    @AppStorage("coupon_code") var coupon_code = ""
    @AppStorage("user_name") var user_name = ""
    @AppStorage("user_phone_number") var user_phone_number = ""
    @AppStorage("user_email") var user_email = ""
    @AppStorage("user_address") var user_address = ""
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(entity: PizzaOrder.entity(), sortDescriptors: [], predicate: NSPredicate(format: "status != %@", Status.completed.rawValue))
    var orders: FetchedResults<PizzaOrder>
    
    @State var showAccountInfoSheet: Bool = false
    @State var couponApplied: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack {
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
                                
                                Price(couponApplied: $couponApplied, order: order)
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
                        
                        if(orders.count > 0){
                            ApplyCouponCode(coupon_applied: $couponApplied, coupon_code: $coupon_code)
                            
                            NavigationLink(destination: ProfileView(user_name: $user_name, user_phone_number: $user_phone_number, user_email: $user_email, user_address: $user_address)) {
                                    OrderInformation(user_name: $user_name, user_phone_number: $user_phone_number, user_address: $user_address)
                            }
                            
                            NavigationLink(destination: NoItemsView(systemName: "pencil.and.outline", text: "Come back soon, we are still building this section of the app.")) {
                                PaymentInformation()
                            }
                            
                            HStack {
                                Spacer()
                                Button(action: {}) {
                                    Text("Disclaimers")
                                        .font(.caption)
                                        .foregroundColor(.green)
                                }
                                Spacer()
                            }
                            .padding(.top, 100)
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
                        AccountSheet(user_name: $user_name, user_phone_number: $user_phone_number, user_email: $user_email, user_address: $user_address)
                    }
                    
                    if(orders.count > 0) {
                        Total(couponApplied: $couponApplied, orders: orders)
                        
                        PlaceOrder()
                    }
                    
                }
                if(orders.count == 0) {
                    NoItemsView(systemName: "cart", text: "You haven't added any pizzas yet.")
                }
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
    @Binding var couponApplied: Bool
    var order: PizzaOrder
    
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
        print("Price per slice \(order.price)")
        print("# of slices \(Double(order.numberOfSlices))")
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
    @Binding var couponApplied: Bool
    var orders: FetchedResults<PizzaOrder>
    
    var body: some View {
        HStack {
            Text("Total")
                .font(.headline)
            
            Spacer()
            
            Text("$" + String(format: "%.2f", calcTotal(orders: orders)))
                .font(.headline)
        }
        .padding(.leading)
        .padding(.trailing)
    }
    
    func calcTotal(orders: FetchedResults<PizzaOrder>) -> Double {
        var totalPrice = 0.00
        
        orders.forEach { order in
            var pizzaPrice = order.price * Double(order.numberOfSlices)
            if(couponApplied) {
                pizzaPrice = pizzaPrice - (pizzaPrice * couponValue)
            }
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
        .padding(.leading)
        .padding(.trailing)
        .padding(.bottom)
    }
}

struct ApplyCouponCode: View {
    @Binding var coupon_applied: Bool
    @Binding var coupon_code: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10.0) {
            Text("Apply Coupon Code")
                .font(.headline)
            
            HStack {
                TextField("Code", text: $coupon_code)
                    .font(.subheadline)
                    .textInputAutocapitalization(.characters)
                    .disableAutocorrection(true)
                    .textFieldStyle(.roundedBorder)
                
                Button(action: {
                    print("Code \(coupon_code)")
                    if(coupon_code == validCouponCode){
                        print("Valid coupon")
                        coupon_applied = true
                    } else{
                        print("Invalid coupon")
                        coupon_applied = false
                    }
                    coupon_code = "" //resetting app storage

                }) {
                    Text("Apply")
                        .font(.subheadline)
                        .bold()
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 75, height: 25)
                        .background(Color.red)
                        .cornerRadius(15.0)
                }
            }
        }
        .padding(.top)
        .padding(.bottom)
    }
}

struct OrderInformation: View {
    @Binding var user_name: String
    @Binding var user_phone_number: String
    @Binding var user_address: String
    
    var body: some View {
        let infoAvailable: Bool = !user_name.isEmpty && !user_phone_number.isEmpty && !user_address.isEmpty
        
        VStack(alignment: .leading, spacing: 5) {
            Text("Order Information")
                .font(.headline)
                .padding(.bottom, 5)
            
            if(!infoAvailable){
                Text("Enter Delivery & Contact Information")
                    .font(.subheadline)
                    .foregroundColor(.red)
            } else {
                Text(user_name)
                    .font(.subheadline)
                Text(user_phone_number)
                    .font(.caption)
                    .foregroundColor(.secondary)
                HStack{
                    Text(user_address)
                        .font(.subheadline)
                    Spacer()
                    Text("Delivery")
                        .font(.subheadline)
                        .foregroundColor(.red)
                }
            }
        }
        .padding(.top)
        .padding(.bottom)
    }
}

struct PaymentInformation: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 5){
            Text("Payment Information")
                .font(.headline)
                .padding(.bottom, 5)
            Text("Credit/Debit Card")
                .font(.subheadline)
            HStack {
                Text("Visa...1234")
                    .font(.caption)
                Spacer()
                Image(systemName: "creditcard.fill")
                    .font(.headline)
                    .foregroundColor(.red)
            }
        }
        .padding(.top)
        .padding(.bottom)
    }
}
