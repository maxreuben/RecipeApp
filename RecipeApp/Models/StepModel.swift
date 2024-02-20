// Copyright © 2023 Big Mountain Studio. All rights reserved. Twitter: @BigMtnStudio

import Foundation
import SwiftData
import UIKit

@Model
class StepModel {
    var stepNumber: Int
    var instruction: String
    var image: Data?
    var recipe: RecipeModel?
    
    init(stepNumber: Int, instruction: String, image: Data? = nil, recipe: RecipeModel? = nil) {
        self.stepNumber = stepNumber
        self.instruction = instruction
        self.image = image
        self.recipe = recipe
    }
}
