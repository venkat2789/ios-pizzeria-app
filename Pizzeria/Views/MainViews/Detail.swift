//
//  DetailView.swift
//  Pizzeria
//
//  Created by Venkatachalapathy Sivaprakasam on 5/22/22.
//

import SwiftUI

struct Detail: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @EnvironmentObject var modelData: ModelData
    @State private var presentAlert = false
    @State private var quantity = 1
    @State private var sauceTypeIndex = 1
    @State private var crustTypeIndex = 1
    @State private var pizzaSizeIndex = 1
    
    var pizza: Pizza
    var pizzaIndex: Int {
        modelData.pizzas.firstIndex(where: { $0.id == pizza.id })!
    }
    
    let sauceTypes = ["Tomato Sauce", "Marinara Sauce", "Honey BBQ Sauce", "Garlic Parmesan Sauce", "Alfredo Sauce"]
    let crustTypes = ["Normal", "Thin Crust"]
    let pizzaSizes = ["Small", "Medium", "Large", "X Large"]
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                PizzaImage()
                
                HStack {
                    BackButton()
                        .padding(10)
                    Spacer()
                    FavoriteButton(isSet: $modelData.pizzas[pizzaIndex].isFavorite)
                        .padding(10)
                }
                
                PizzaName(pizza: pizza)
                
                ScrollView{
                    Ingredients()
                    
                    NavigationView {
                        SelectionForm(sauceTypeIndex: $sauceTypeIndex, crustTypeIndex: $crustTypeIndex, quantity: $quantity, pizzaSizeIndex: $pizzaSizeIndex, sauceTypes: sauceTypes, crustTypes: crustTypes, pizzaSizes: pizzaSizes)
                    }
                    .frame(height: 500, alignment: .center)
                    
                    AddToOrder(sauceTypeIndex: $sauceTypeIndex, crustTypeIndex: $crustTypeIndex, quantity: $quantity, presentAlert: $presentAlert, pizza: pizza, pizzaSize: pizzaSizes[pizzaSizeIndex], sauceTypes: sauceTypes, crustTypes: crustTypes)
                }
            }
            .background(Color("LightGrayBackground"))
            .navigationBarHidden(true)
            
            if(presentAlert){
                VStack {
                    ToastMessage(presentAlert: $presentAlert)
                        .padding()
                        .transition(.move(edge: .top))
                    Spacer()
                }
            }
        }
    }
}

struct Detail_Previews: PreviewProvider {
    static var previews: some View {
        Detail(pizza: ModelData().pizzas[0]).environmentObject(ViewRouter()).environmentObject(ModelData())
    }
}

struct BackButton: View {
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
    }
}

struct PizzaImage: View {
    var body: some View {
        Image("pizza-detail")
            .resizable()
            .aspectRatio(3/2, contentMode: .fit)
            .ignoresSafeArea(edges: .top)
            .frame(height: 264)
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
    @Binding var quantity: Int
    @Binding var pizzaSizeIndex: Int
    
    var sauceTypes: [String]
    var crustTypes: [String]
    var pizzaSizes: [String]
    
    var body: some View {
        Form {
            Section("Size and Quantity") {
                Picker("Size", selection: $pizzaSizeIndex) {
                    ForEach(0 ..< pizzaSizes.count, id:\.self) {
                        Text(self.pizzaSizes[$0]).tag($0)
                    }
                }
                .pickerStyle(.segmented)
                
                Stepper("Quantity: \(quantity)", value: $quantity, in: 1...5)
            }
            
            
            Picker(selection: $sauceTypeIndex, label: Text("Sauce")) {
                ForEach(0 ..< sauceTypes.count, id:\.self) {
                    Text(self.sauceTypes[$0]).tag($0)
                }
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
        .font(.subheadline)
        .navigationTitle("Customize")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AddToOrder: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Binding var sauceTypeIndex: Int
    @Binding var crustTypeIndex: Int
    @Binding var quantity: Int
    @Binding var presentAlert: Bool
    
    var pizza: Pizza
    var pizzaSize: String
    var sauceTypes: [String] //can be used to display in Order view
    var crustTypes: [String] //can be used to display in Order view
    
    var body: some View {
        Button(action: {
            let newOrder = PizzaOrder(context: viewContext)
            newOrder.pizzaType = pizza.name
            newOrder.quantity = Int16(self.quantity)
            newOrder.size = self.pizzaSize
            newOrder.id = UUID()
            let originalPrice = Double(pizza.price) ?? 0.00
            
            var tempPrice: Double
            switch newOrder.size{
            case "Small":
                tempPrice = originalPrice * 0.75
            case "Medium":
                tempPrice = originalPrice
            case "Large":
                tempPrice = originalPrice * 1.25
            case "X Large":
                tempPrice = originalPrice * 1.50
            default:
                tempPrice = originalPrice
            }
            
            print("Price: \(tempPrice)")
            newOrder.price = tempPrice
            
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
