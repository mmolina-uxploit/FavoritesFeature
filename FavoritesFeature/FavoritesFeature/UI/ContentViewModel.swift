//
//  ContentViewModel.swift
//  FavoritesFeature
//
//  Created by m47145 on 10/01/2026.
//

import Foundation
import Combine

// Este ViewModel actúa como un puente entre la Vista y la capa de Aplicación (Caso de Uso).
// Mantiene el estado de la interfaz de usuario e invoca el caso de uso en respuesta a las acciones del usuario.
@MainActor
final class ContentViewModel: ObservableObject {
    @Published private(set) var favoriteStatus: FavoriteStatus
    
    private let useCase: FavoriteToggleUseCase
    private let repository: FavoritesRepository
    private let itemID: FavoriteItemID = "sample-item"

    init(useCase: FavoriteToggleUseCase, repository: FavoritesRepository) {
        self.useCase = useCase
        self.repository = repository
        self.favoriteStatus = FavoriteStatus(id: self.itemID, isFavorited: false)
        loadInitialStatus()
    }
    
    private func loadInitialStatus() {
        Task {
            self.favoriteStatus = await repository.getStatus(for: itemID)
        }
    }

    func toggleFavorite() {
        Task {
            await useCase.execute(for: itemID)
            // Después de ejecutar el caso de uso, recargamos el estado desde la fuente de verdad.
            self.favoriteStatus = await repository.getStatus(for: itemID)
        }
    }
}
