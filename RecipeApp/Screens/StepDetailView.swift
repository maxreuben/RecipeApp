// Copyright © 2024 Big Mountain Studio. All rights reserved. Twitter: @BigMtnStudio
import SwiftData
import SwiftUI

struct StepDetailView: View {
    @Environment(\.modelContext) private var modelContext
    let recipe: RecipeModel
    var editMode = false
    @State private var scrollToBottom = false
    
    var body: some View {
        ScrollViewReader { proxy in
            List {
                ForEach(recipe.viewSortedSteps) { step in
                    @Bindable var step = step
                    if editMode {
                        VStack {
                            Stepper(value: $step.stepNumber) {
                                Image(systemName: "\(step.stepNumber).square")
                                    .font(.title)
                            }
                            
                            TextField("instruction", text: $step.instruction, axis: .vertical)
                                .lineLimit(10)
                        }
                        .id(step.stepNumber)
                    } else {
                        Label(step.instruction, systemImage: "\(step.stepNumber).square")
                    }
                }
                .onDelete(perform: editMode ? delete : nil)
                .listRowBackground(Color.primary.opacity(0.05))
            }
            .onChange(of: scrollToBottom, initial: false) { _, _ in
                proxy.scrollTo(recipe.steps.count)
            }
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
        .navigationTitle("Steps")
        .toolbar {
            if editMode {
                Button("", systemImage: "plus") {
                    let stepNumber = recipe.steps.count+1
                    recipe.steps.append(
                        StepModel(
                            stepNumber: stepNumber,
                            instruction: ""
                        )
                    )
                    scrollToBottom.toggle()
                }
            }
        }
    }
    
    func delete(indexSet: IndexSet) {
        for index in indexSet {
            modelContext.delete(recipe.viewSortedSteps[index])
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
        StepDetailView(recipe: recipes[0])
    }
}

#Preview("Edit Mode") {
    let container = RecipeModel.preview
    let recipes = try! container.mainContext.fetch(
        FetchDescriptor<RecipeModel>(predicate: #Predicate { recipe in
            recipe.name == "Lobster Bisque"
        }))
    
    return NavigationStack {
        StepDetailView(recipe: recipes[0], editMode: true)
    }
}
