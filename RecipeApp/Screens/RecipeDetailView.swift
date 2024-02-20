// Copyright © 2024 Big Mountain Studio. All rights reserved. Twitter: @BigMtnStudio
import SwiftData
import SwiftUI

struct RecipeDetailView: View {
    @Environment(\.modelContext) private var modelContext
    let recipe: RecipeModel
    
    var body: some View {
        List {
            Section {
                if let image = recipe.viewImage {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .hidden()
                        .listRowBackground(
                            Image(uiImage: image)
                                .resizable())
                }
                LabeledContent("Category", value: "\(recipe.viewCategory)")
                LabeledContent("Minutes to Cook", value: "\(recipe.minutesToCook)")
                LabeledContent("Serving Size", value: "\(recipe.servingSize)")
                NavigationLink("Ingredients") {
                    IngredientDetailView(recipe: recipe)
                }
                NavigationLink("Instructions") {
                    StepDetailView(recipe: recipe)
                }
            }
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
        .navigationTitle(recipe.name)
        .toolbar {
            NavigationLink {
                EditRecipeView(recipe: recipe)
            } label: {
                Image(systemName: "square.and.pencil.circle")
            }
        }
    }
}

#Preview {
    let container = RecipeModel.preview
    let recipes = try! container.mainContext.fetch(
        FetchDescriptor<RecipeModel>(predicate: #Predicate { recipe in
            recipe.name == "Lobster Bisque"
        }))
    
    return NavigationStack {
        RecipeDetailView(recipe: recipes[0])
    }
}
