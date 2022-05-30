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
    
    var category: Category
    enum Category: String, CaseIterable, Codable {
        case lakes = "Our Picks"
        case rivers = "Fan Favorites"
        case mountains = "Meatless Specials"
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
    
    //coordinates
    private var coordinates: Coordinates
    
    struct Coordinates: Hashable, Codable {
        var latitude: Double
        var longitude: Double
    }
    
    var locationCoordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(
            latitude: coordinates.latitude,
            longitude: coordinates.longitude
        )
    }
}
