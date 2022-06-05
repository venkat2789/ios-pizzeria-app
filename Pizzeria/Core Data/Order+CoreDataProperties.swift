//
//  Order+CoreDataProperties.swift
//  Pizzeria
//
//  Created by Venkatachalapathy Sivaprakasam on 5/22/22.
//
//

import Foundation
import CoreData


extension PizzaOrder {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PizzaOrder> {
        return NSFetchRequest<PizzaOrder>(entityName: "PizzaOrder")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var pizzaType: String
    @NSManaged public var numberOfSlices: Int16
    @NSManaged public var status: String
    @NSManaged public var price: Double
        
        var orderStatus: Status {
            set {
                status = newValue.rawValue
            }
            get {
                Status(rawValue: status) ?? .pending
            }
        }

}

enum Status: String {
    case pending = "Pending"
    case preparing = "Preparing"
    case completed = "Completed"
}

extension PizzaOrder : Identifiable {

}
