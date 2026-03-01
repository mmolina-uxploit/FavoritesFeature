//
//  InMemoryFavoritesRepository.swift
//  FavoritesFeature
//
//  Created by m47145 on 10/01/2026.
//

import Foundation

// Este es un ADAPTADOR en Arquitectura Hexagonal.
// Implementa el protocolo `FavoritesRepository` (el puerto) para una tecnología específica.
// En este caso, la "tecnología" es sólo un diccionario en memoria, pero podría ser CoreData, UserDefaults, una API remota, etc.
public final class InMemoryFavoritesRepository: FavoritesRepository {
    // Un almacén privado en memoria para estados favoritos.
        // La clave es `FavoriteItemID`.
    private var store: [FavoriteItemID: FavoriteStatus] = [:]

    public init() {}

    public func getStatus(for itemID: FavoriteItemID) async -> FavoriteStatus {
        // Si el artículo no está en la tienda, asumimos que no está favorito de forma predeterminada.
        return store[itemID] ?? FavoriteStatus(id: itemID, isFavorited: false)
    }

    public func save(status: FavoriteStatus) async {
        // Guarda el estado actualizado en nuestra tienda en memoria.
        store[status.id] = status
        print("Repository saved status: \(status)")
    }
}
