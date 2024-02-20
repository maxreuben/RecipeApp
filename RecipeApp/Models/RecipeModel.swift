// Copyright © 2023 Big Mountain Studio. All rights reserved. Twitter: @BigMtnStudio

import Foundation
import SwiftData
import UIKit

@Model
class RecipeModel {
    var name: String
    @Relationship(deleteRule: .cascade, inverse: \IngredientModel.recipes)
    var ingredients: [IngredientModel] = []
    @Relationship(deleteRule: .cascade, inverse: \StepModel.recipe)
    var steps: [StepModel] = []
    var image: Data?
    var category: CategoryModel?
    var minutesToCook: Int = 0
    var servingSize: Int = 1
    
    init(name: String, ingredients: [IngredientModel] = [], steps: [StepModel] = [], image: Data? = nil, category: CategoryModel? = nil, minutesToCook: Int = 0, servingSize: Int = 1) {
        self.name = name
        self.ingredients = ingredients
        self.steps = steps
        self.image = image
        self.category = category
        self.minutesToCook = minutesToCook
        self.servingSize = servingSize
    }
}

extension RecipeModel {
    var viewImage: UIImage? {
        guard let image else { return nil }
        return UIImage(data: image)
    }
    var viewImageWithDefault: UIImage {
        guard let image else { return UIImage(systemName: "fork.knife.circle")! }
        return UIImage(data: image) ?? UIImage(systemName: "fork.knife.circle")!
    }
    var viewCategory: String {
        category?.name ?? ""
    }
    
    var viewSortedSteps: [StepModel] {
        steps.sorted { $0.stepNumber < $1.stepNumber }
    }
    
    var viewSortedIngredients: [IngredientModel] {
        ingredients.sorted { $0.name < $1.name }
    }
}

extension RecipeModel {
    @MainActor
    static var preview: ModelContainer {
        let container = try! ModelContainer(for: RecipeModel.self,
                                            configurations: ModelConfiguration(isStoredInMemoryOnly: true))

        // MARK: - Categories
        let soups = CategoryModel(name: "Soups")
        let desserts = CategoryModel(name: "Desserts")
        let mainDishes = CategoryModel(name: "Main Dishes")
        container.mainContext.insert(soups)
        container.mainContext.insert(desserts)
        container.mainContext.insert(mainDishes)
        try? container.mainContext.save()
        
        // MARK: - Recipes
        // Soups
        let lobsterBisque = RecipeModel(name: "Lobster Bisque", image: UIImage(resource: .lobsterBisque).pngData()!, category: soups, minutesToCook: 90, servingSize: 6)
        container.mainContext.insert(lobsterBisque)
        let chickenNoodleSoup = RecipeModel(name: "Chicken Noodle Soup", image: UIImage(resource: .chickenNoodleSoup).pngData()!, category: soups, minutesToCook: 50, servingSize: 6)
        container.mainContext.insert(chickenNoodleSoup)
        let tomatoBasilSoup = RecipeModel(name: "Tomato Basil Soup", image: UIImage(resource: .tomatoBasilSoup).pngData()!, category: soups, minutesToCook: 30, servingSize: 6)
        container.mainContext.insert(tomatoBasilSoup)
        let vegetableMinestrone = RecipeModel(name: "Vegetable Minestrone", image: UIImage(resource: .vegetableMinestrone).pngData()!, category: soups, minutesToCook: 40, servingSize: 6)
        container.mainContext.insert(vegetableMinestrone)
        
        // Desserts
        let applePie = RecipeModel(name: "Apple Pie", image: UIImage(resource: .applePie).pngData()!, category: desserts, minutesToCook: 75, servingSize: 8)
        container.mainContext.insert(applePie)
        let chocolateCake = RecipeModel(name: "Chocolate Cake", image: UIImage(resource: .chocolateCake).pngData()!, category: desserts, minutesToCook: 60, servingSize: 8)
        container.mainContext.insert(chocolateCake)
        let strawberryCheesecake = RecipeModel(name: "Strawberry Cheesecake", image: UIImage(resource: .strawberryCheesecake).pngData()!, category: desserts, minutesToCook: 70, servingSize: 8)
        container.mainContext.insert(strawberryCheesecake)
        
        // Main Dishes
        let grilledSalmon = RecipeModel(name: "Grilled Salmon", image: UIImage(resource: .grilledSalmon).pngData()!, category: mainDishes, minutesToCook: 40, servingSize: 3)
        container.mainContext.insert(grilledSalmon)
        let spaghettiBolognese = RecipeModel(name: "Spaghetti Bolognese", image: UIImage(resource: .spaghettiBolognese).pngData()!, category: mainDishes, minutesToCook: 80, servingSize: 4)
        container.mainContext.insert(spaghettiBolognese)
        let chickenParmesan = RecipeModel(name: "Chicken Parmesan", image: UIImage(resource: .chickenParmesan).pngData()!, category: mainDishes, minutesToCook: 120, servingSize: 2)
        container.mainContext.insert(chickenParmesan)
        try? container.mainContext.save()

        // MARK: - Ingredients
        let lobster = IngredientModel(name: "Lobster", quantity: "2")
        let butter = IngredientModel(name: "Butter", quantity: "3 tablespoons")
        let onion = IngredientModel(name: "Onion", quantity: "1")
        let carrots = IngredientModel(name: "Carrots", quantity: "2")
        let tomatoPaste = IngredientModel(name: "Tomato Paste", quantity: "2 tablespoons")
        let chickenBroth = IngredientModel(name: "Chicken Broth", quantity: "1 (14.5 ounce) can")
        let salt = IngredientModel(name: "Salt", quantity: "⅛ teaspoon")
        let cayennePepper = IngredientModel(name: "Cayenne Pepper", quantity: "⅛ teaspoon")
        let halfAndHalf = IngredientModel(name: "Half-and-Half", quantity: "1 ½ cups")
        let whiteWine = IngredientModel(name: "Dry White Wine", quantity: "½ cup")
        let mushrooms = IngredientModel(name: "Mushrooms", quantity: "¼ cup")
        let celery = IngredientModel(name: "Celery", quantity: "½ cup")
        let chicken = IngredientModel(name: "Chicken")
        let noodles = IngredientModel(name: "Noodles")
        let tomato = IngredientModel(name: "Tomato")
        let basil = IngredientModel(name: "Basil")
        let vegetables = IngredientModel(name: "Vegetables")
        let apple = IngredientModel(name: "Apple")
        let chocolate = IngredientModel(name: "Chocolate")
        let strawberry = IngredientModel(name: "Strawberry")
        let salmon = IngredientModel(name: "Salmon")
        let spaghetti = IngredientModel(name: "Spaghetti")
        let parmesan = IngredientModel(name: "Parmesan")
        
        // Adding ingredients to the recipes
        lobsterBisque.ingredients = [lobster, butter, onion, carrots, tomatoPaste, chickenBroth, salt, cayennePepper, halfAndHalf, whiteWine, mushrooms, celery]
        chickenNoodleSoup.ingredients = [chicken, noodles]
        tomatoBasilSoup.ingredients = [tomato, basil]
        vegetableMinestrone.ingredients = [vegetables]
        applePie.ingredients = [apple]
        chocolateCake.ingredients = [chocolate]
        strawberryCheesecake.ingredients = [strawberry]
        grilledSalmon.ingredients = [salmon]
        spaghettiBolognese.ingredients = [spaghetti]
        chickenParmesan.ingredients = [chicken, parmesan]
        
        try? container.mainContext.save()
        
        // MARK: - Steps
        let step1 = StepModel(stepNumber: 1, instruction: "Bring a large pot of water to boil. Add lobster tails to water, and boil until cooked through and bright red.")
        let step2 = StepModel(stepNumber: 2, instruction: "Using tongs, transfer lobsters to a large bowl. Reserve 2 cups of cooking liquid, saving as much loose lobster meat with it.")
        let step3 = StepModel(stepNumber: 3, instruction: "Cool lobster tails by running under cool water. Crack the shells and remove the meat.")
        let step4 = StepModel(stepNumber: 4, instruction: "Melt the butter in a large saucepan. Gently fry the onion, garlic, celery, and carrot and cook until softened, which takes about 5 minutes.")
        let step5 = StepModel(stepNumber: 5, instruction: "Turn up the heat, tip in the lobster shells and stir vigorously for 2 minutes. Pour in the wine, giving it a stir then let it bubble until the liquid has halved.")
        let step6 = StepModel(stepNumber: 6, instruction: "Pour vegetable and broth mixture into the container of a blender, and add 1/4 cup of the lobster meat. Cover, and process until smooth.")
        let step7 = StepModel(stepNumber: 7, instruction: "Return to the saucepan, and stir in half-and-half, white wine, and remaining lobster meat. Cook over low heat, stirring frequently until thickened, about 30 minutes.")
        let step8 = StepModel(stepNumber: 8, instruction: "Just before serving, add the reserved lobster tail meat and chopped claw/leg meat to the pot. Heat through until the lobster is warmed but not overcooked.")
        let step9 = StepModel(stepNumber: 9, instruction: "Stir in 2 tablespoons of brandy or cognac and a pinch of cayenne pepper for a hint of spice. Taste and adjust seasoning as desired. Ladle the bisque into bowls and garnish with fresh chives.")
        
        lobsterBisque.steps = [step1, step2, step3, step4, step5, step6, step7, step8, step9]
        
        try? container.mainContext.save()

        
        return container
    }
}
