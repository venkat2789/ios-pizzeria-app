//
//  DetailView.swift
//  Pizzeria
//
//  Created by Venkatachalapathy Sivaprakasam on 5/22/22.
//

import SwiftUI

struct DetailView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @State private var presentAlert = false
    @State private var sauceTypeIndex = 1
    @State private var crustTypeIndex = 1
    @State private var numberOfSlices = 1
    
    var pizza: Pizza
    let sauceTypes = ["Tomato Sauce", "Marinara Sauce", "Honey BBQ Sauce", "Garlic Parmesan Sauce", "Alfredo Sauce"]
    let crustTypes = ["Normal", "Thin Crust"]
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                PizzaImage()
                
                BackToMenu()
                
                PizzaName(pizza: pizza)
                
                ScrollView{
                    Ingredients()
                    
                    NavigationView {
                        SelectionForm(sauceTypeIndex: $sauceTypeIndex, crustTypeIndex: $crustTypeIndex, numberOfSlices: $numberOfSlices, sauceTypes: sauceTypes, crustTypes: crustTypes)
                    }
                    .frame(height: 400, alignment: .center)
                    
                    AddToOrder(sauceTypeIndex: $sauceTypeIndex, crustTypeIndex: $crustTypeIndex, numberOfSlices: $numberOfSlices, presentAlert: $presentAlert, pizza: pizza, sauceTypes: sauceTypes, crustTypes: crustTypes)
                }
            }
            .background(Color("LightGrayBackground"))
            .navigationBarHidden(true)
            
            if(presentAlert){
                VStack {
                    AlertView(presentAlert: $presentAlert)
                        .padding()
                        .transition(.move(edge: .top))
                    Spacer()
                }
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(pizza: ModelData().pizzas[0]).environmentObject(ViewRouter())
    }
}

struct BackToMenu: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "arrow.backward.circle.fill")
                    .foregroundColor(.red)
                Text("Back")
                    .foregroundColor(.red)
                    .font(.callout)
                    .padding(.leading, -5)
            }
            .padding(10)
    }
}

struct PizzaImage: View {
    var body: some View {
        Image("pizza-placeholder")
            .resizable()
            .aspectRatio(3/2, contentMode: .fill)
            .ignoresSafeArea(edges: .top)
            .frame(height: 200)
            .padding(.bottom)
    }
}

struct PizzaName: View {
    var pizza: Pizza
    
    var body: some View {
        HStack(spacing: -2) {
            Text(pizza.name)
                .font(.title2)
                .bold()
            Text("🍕")
                .font(.title)
                .padding(.top, -8)
        }
        .padding(.leading, 10)
    }
}

struct Ingredients: View {
    var body: some View {
        DisclosureGroup {
            Text("These are the ingredients. These are the ingredients. These are the ingredients. These are the ingredients.")
                .font(.subheadline)
        } label: {
            Text("Ingredients")
                .font(.headline)
        }
        .padding(.leading, 10)
        .padding(.trailing, 10)
        .foregroundColor(.primary)
    }
}

struct SelectionForm: View {
    @Binding var sauceTypeIndex: Int
    @Binding var crustTypeIndex: Int
    @Binding var numberOfSlices: Int
    
    var sauceTypes: [String]
    var crustTypes: [String]
    
    var body: some View {
        Form {
            Section(header: Text("Pizza")) {
                Picker(selection: $sauceTypeIndex, label: Text("Sauce")) {
                    ForEach(0 ..< sauceTypes.count, id:\.self) {
                        Text(self.sauceTypes[$0]).tag($0)
                    }
                }
                
                Stepper("\(numberOfSlices) Slices", value: $numberOfSlices, in: 1...12)
            }
            
            Section(header: Text("Crust")) {
                Picker("Crust", selection: $crustTypeIndex) {
                    ForEach(0 ..< crustTypes.count, id:\.self) {
                        Text(self.crustTypes[$0]).tag($0)
                    }
                }
                .pickerStyle(.segmented)
            }
        }
        .navigationTitle("Customize")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AddToOrder: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Binding var sauceTypeIndex: Int
    @Binding var crustTypeIndex: Int
    @Binding var numberOfSlices: Int
    @Binding var presentAlert: Bool
    
    var pizza: Pizza
    var sauceTypes: [String] //can be used to display in Order view
    var crustTypes: [String] //can be used to display in Order view
    
    var body: some View {
        Button(action: {
            let newOrder = PizzaOrder(context: viewContext)
            newOrder.pizzaType = pizza.name
            newOrder.orderStatus = .pending
            newOrder.numberOfSlices = Int16(self.numberOfSlices)
            newOrder.id = UUID()
            newOrder.price = Double(pizza.price) ?? 0.00
            
            do {
                try viewContext.save()
                print("Order saved.")
                withAnimation(.linear(duration: 0.5)){
                    presentAlert = true
                }
            } catch {
                print(error.localizedDescription)
            }
        }) {
            AddToOrderButton()
        }
        .padding()
//        .alert("Awesome!", isPresented: $presentAlert, actions: {
//            Button("OK", role: .cancel, action: {})
//        }, message: {
//            Text("Item added to your order.")
//        })
    }
}

struct AddToOrderButton: View {
    var body: some View {
        Text("Add to Order")
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(width: 150, height: 45)
            .background(Color.red)
            .cornerRadius(15.0)
    }
}
