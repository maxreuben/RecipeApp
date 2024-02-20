// Copyright © 2023 Big Mountain Studio. All rights reserved. Twitter: @BigMtnStudio

import Foundation
import SwiftData
import UIKit

@Model
class CategoryModel {
    var name: String
    @Relationship(inverse: \RecipeModel.category)
    var recipes: [RecipeModel] = []
    
    init(name: String, recipes: [RecipeModel] = []) {
        self.name = name
        self.recipes = recipes
    }
}
