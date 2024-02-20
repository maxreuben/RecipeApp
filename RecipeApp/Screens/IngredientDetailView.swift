// Copyright © 2024 Big Mountain Studio. All rights reserved. Twitter: @BigMtnStudio
import SwiftData
import SwiftUI

struct IngredientDetailView: View {
    @Environment(\.modelContext) private var modelContext
    let recipe: RecipeModel
    var editMode = false
    
    var body: some View {
        List {
            ForEach(recipe.viewSortedIngredients) { ingredient in
                @Bindable var ingredient = ingredient
                if editMode {
                    VStack {
                        TextField("qty", text: $ingredient.quantity)
                        TextField("ingredient", text: $ingredient.name)
                    }
                } else {
                    Text(ingredient.viewIngredient)
                }
            }
            .onDelete(perform: editMode ? delete : nil)
            .listRowBackground(Color.primary.opacity(0.05))
        }
        .scrollContentBackground(.hidden)
        .background(.regularMaterial)
        .background {
            if let image = recipe.viewImage {
                Image(uiImage: image)
                    .resizable()
                    .ignoresSafeArea()
                    .opacity(0.5)
            } else {
                Image("RecipeApp")
                    .opacity(0.5)
            }
        }
        .navigationTitle("Ingredients")
        .toolbar {
            if editMode {
                Button("", systemImage: "plus") {
                    recipe.ingredients.append(IngredientModel(name: "", quantity: ""))
                }
            }
        }
    }
    
    func delete(indexSet: IndexSet) {
        for index in indexSet {
            modelContext.delete(recipe.viewSortedIngredients[index])
        }
    }
}

#Preview("Read-Only") {
    let container = RecipeModel.preview
    let recipes = try! container.mainContext.fetch(
        FetchDescriptor<RecipeModel>(predicate: #Predicate { recipe in
            recipe.name == "Lobster Bisque"
        }))
    
    return NavigationStack {
        IngredientDetailView(recipe: recipes[0])
    }
}

#Preview("Edit Mode") {
    let container = RecipeModel.preview
    let recipes = try! container.mainContext.fetch(
        FetchDescriptor<RecipeModel>(predicate: #Predicate { recipe in
            recipe.name == "Lobster Bisque"
        }))
    
    return NavigationStack {
        IngredientDetailView(recipe: recipes[0], editMode: true)
    }
}
