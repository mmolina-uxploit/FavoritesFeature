//
//  FavoriteToggleUseCase.swift
//  FavoritesFeature
//
//  Created by m47145 on 10/01/2026.
//

import Foundation

// Este es el caso de uso principal de la aplicación.
// Orquesta la lógica del dominio, pero no contiene reglas comerciales.
// Depende de la abstracción (protocolo) del repositorio, no de la implementación concreta.
public final class FavoriteToggleUseCase {
    private let repository: FavoritesRepository

    public init(repository: FavoritesRepository) {
        self.repository = repository
    }

    public func execute(for itemID: FavoriteItemID) async {
        // 1. Obtener el estado actual del repositorio
        var status = await repository.getStatus(for: itemID)

        // 2. "Lógica de negocio": invertir el estado
        status.isFavorited.toggle()

        // 3. Guarda el nuevo estado en el repositorio
        await repository.save(status: status)
    }
}
