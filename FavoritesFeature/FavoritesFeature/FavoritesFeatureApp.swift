//
//  FavoritesFeatureApp.swift
//  FavoritesFeature
//
//  Created by m47145 on 09/01/2026.
//

import SwiftUI

@main
struct FavoritesFeatureApp: App {
    
    private let contentView: ContentView
    
    init() {
        // Esta es la raíz de composición de la aplicación, donde están conectadas todas las dependencias.
        let repository = InMemoryFavoritesRepository()
        let useCase = FavoriteToggleUseCase(repository: repository)
        let viewModel = ContentViewModel(useCase: useCase, repository: repository)
        self.contentView = ContentView(viewModel: viewModel)
    }
    
    var body: some Scene {
        WindowGroup {
            contentView
        }
    }
}
