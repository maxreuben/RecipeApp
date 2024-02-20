// Copyright © 2023 Big Mountain Studio. All rights reserved. Twitter: @BigMtnStudio
import SwiftData
import SwiftUI

struct HomeView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var categories: [CategoryModel]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(categories) { category in
                    Section(category.name) {
                        ForEach(category.recipes) { recipe in
                            NavigationLink {
                                RecipeDetailView(recipe: recipe)
                            } label: {
                                HStack {
                                    Image(uiImage: recipe.viewImageWithDefault)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 50, height: 50)
                                        .clipShape(.rect(cornerRadius: 8))
                                    Text(recipe.name)
                                        .font(.title2.weight(.semibold).width(.condensed))
                                }
                            }
                        }
                        .onDelete { indexSet in
                            for index in indexSet {
                                modelContext.delete(category.recipes[index])
                            }
                        }
                    }
                }
                .listRowBackground(Color.primary.opacity(0.05))
            }
            .navigationTitle("Recipes")
            .headerProminence(.increased)
            .scrollContentBackground(.hidden)
            .background(.regularMaterial)
            .background {
                Image("RecipeApp")
                    .opacity(0.5)
            }
        }
    }
}

#Preview {
    HomeView()
        .modelContainer(RecipeModel.preview)
}
