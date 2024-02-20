// Copyright © 2023 Big Mountain Studio. All rights reserved. Twitter: @BigMtnStudio

import Foundation
import SwiftData
import UIKit

@Model
class IngredientModel {
    var name: String
    var quantity: String = ""
    var recipes: [RecipeModel] = []
    
    init(name: String, quantity: String = "", recipes: [RecipeModel] = []) {
        self.name = name
        self.quantity = quantity
        self.recipes = recipes
    }
}

extension IngredientModel {
    var viewIngredient: String {
        if quantity.isEmpty {
            return name
        } else {
            return "\(quantity) \(name)"
        }
    }
}
