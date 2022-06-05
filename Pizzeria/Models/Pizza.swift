//
//  Pizza.swift
//
//  Created by Venkatachalapathy Sivaprakasam on 5/15/22.
//

import Foundation
import SwiftUI
import CoreLocation

struct Pizza: Hashable, Codable, Identifiable {
    var id: Int
    var name: String
    var park: String
    var state: String
    var description: String
    var isFavorite: Bool
    var isFeatured: Bool
    var price: String
    
    var category: Category
    enum Category: String, CaseIterable, Codable {
        case other = "Other Top Picks"
        case fan = "Fan Favorites"
        case meatless = "Meatless Specials"
    }
    
    //image
    private var imageName: String
    var image: Image {
        Image(imageName)
    }
    
    //featured image
    var featureImage: Image? {
        isFeatured ? Image(imageName + "_feature") : nil
    }
    
}
