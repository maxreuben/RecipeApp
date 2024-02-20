// Copyright © 2023 Big Mountain Studio. All rights reserved. Twitter: @BigMtnStudio
import SwiftData
import SwiftUI

@main
struct RecipeAppApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
                .modelContainer(RecipeModel.preview)
        }
    }
}
