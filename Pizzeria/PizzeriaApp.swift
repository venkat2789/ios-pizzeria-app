//
//  PizzeriaApp.swift
//  Pizzeria
//
//  Created by Venkatachalapathy Sivaprakasam on 5/21/22.
//

import SwiftUI

@main
struct PizzeriaApp: App {
    @StateObject var viewRouter = ViewRouter() //changes views e.g. login to home
    let persistenceController = PersistenceController.shared //for CoreData

    var body: some Scene {
        WindowGroup {
            MainView().environmentObject(viewRouter)
            //pass viewContext as managedObjectContext for CoreData
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
