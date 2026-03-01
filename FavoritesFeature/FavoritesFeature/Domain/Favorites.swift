//
//  Favorites.swift
//  FavoritesFeature
//
//  Created by m47145 on 10/01/2026.
//

import Foundation

// Representa un identificador único para un elemento que se puede marcar como favorito.
// Usar un alias de tipo para mayor claridad y flexibilidad futura.
public typealias FavoriteItemID = String

// Representa la entidad del dominio principal.
// Es un objeto de valor simple por ahora.
public struct FavoriteStatus {
    public let id: FavoriteItemID
    public var isFavorited: Bool
}

// Este es el PUERTO en Arquitectura Hexagonal.
// Define el contrato sobre cómo la capa de aplicación puede interactuar con la capa de persistencia.
// La capa de dominio no sabe nada acerca de *cómo* se implementa esto.
public protocol FavoritesRepository {
    func getStatus(for itemID: FavoriteItemID) async -> FavoriteStatus
    func save(status: FavoriteStatus) async
}
