// Copyright © 2024 Big Mountain Studio. All rights reserved. Twitter: @BigMtnStudio

import PhotosUI
import SwiftData
import SwiftUI

struct EditRecipeView: View {
    @Bindable var recipe: RecipeModel
    @State private var selectedPhoto: PhotosPickerItem?
    
    var body: some View {
        Form {
            Section("Details") {
                TextField("Recipe Name", text: $recipe.name)
                TextField("Minutes to Cook", value: $recipe.minutesToCook, formatter: NumberFormatter())
                TextField("Serving Size", value: $recipe.servingSize, formatter: NumberFormatter())
                HStack {
                    if let image = recipe.viewImage {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 100, height: 100)
                            .clipShape(.rect(cornerRadius: 8))
                            .shadow(radius: 2)
                    } else {
                        Image(systemName: "image")
                    }
                    PhotosPicker(
                        "Select Image",
                        selection: $selectedPhoto,
                        matching: .images,
                        photoLibrary: .shared()
                    )
                    .frame(maxWidth: .infinity)
                    .buttonStyle(.bordered)
                }
            }
            .listRowBackground(Color.primary.opacity(0.05))

            Section {
                NavigationLink("Edit Ingredients") {
                    IngredientDetailView(recipe: recipe, editMode: true)
                }
                NavigationLink("Edit Steps") {
                    StepDetailView(recipe: recipe, editMode: true)
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
        .navigationTitle("Edit Recipe")
        .headerProminence(.increased)
        .task(id: selectedPhoto) {
            if let data = try? await selectedPhoto?.loadTransferable(type: Data.self) {
                recipe.image = data
            }
        }
    }
}

#Preview {
    let container = RecipeModel.preview
    let recipes = try! container.mainContext.fetch(FetchDescriptor<RecipeModel>())
    
    return NavigationStack {
        EditRecipeView(recipe: recipes[0])
    }
}
