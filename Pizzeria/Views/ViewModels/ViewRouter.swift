//
//  ViewRouter.swift
//  Pizzeria
//
//  Created by Venkatachalapathy Sivaprakasam on 5/22/22.
//

import Foundation
import SwiftUI

class ViewRouter: ObservableObject { //observable object class
    @Published var currentPage: Page = .login //this gets observed by other views
}
