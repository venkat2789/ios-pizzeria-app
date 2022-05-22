//
//  PizzeriaApp.swift
//  Pizzeria
//
//  Created by Venkatachalapathy Sivaprakasam on 5/21/22.
//

import SwiftUI

@main
struct PizzeriaApp: App {
    @StateObject var viewRouter = ViewRouter()
//    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            MainView().environmentObject(viewRouter)
//            ContentView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
