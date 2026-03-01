//
//  ContentView.swift
//  FavoritesFeature
//
//  Created by m47145 on 09/01/2026.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel: ContentViewModel

    init(viewModel: ContentViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: viewModel.favoriteStatus.isFavorited ? "star.fill" : "star")
                .imageScale(.large)
                .foregroundStyle(viewModel.favoriteStatus.isFavorited ? .yellow : .gray)
                .font(.largeTitle)
            
            Text("Item ID: \(viewModel.favoriteStatus.id)")
                .font(.caption)
                .foregroundStyle(.secondary)
            
            Button(action: {
                viewModel.toggleFavorite()
            }) {
                Text(viewModel.favoriteStatus.isFavorited ? "Unfavorite" : "Favorite")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .padding()
    }
}

// La vista previa debe actualizarse para proporcionar un entorno simulado/stub.
#Preview {
    // Aquí es donde ocurre la inyección de dependencia para la vista previa.
    let repository = InMemoryFavoritesRepository()
    let useCase = FavoriteToggleUseCase(repository: repository)
    let viewModel = ContentViewModel(useCase: useCase, repository: repository)
    return ContentView(viewModel: viewModel)
}
