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
    @NSManaged public var price: Double
    @NSManaged public var quantity: Int16
    @NSManaged public var size: String

}

extension PizzaOrder : Identifiable {

}
