//
//  FavoriteToggleUseCaseTests.swift
//  FavoritesFeatureTests
//
//  Created by m47145 on 09/01/2026.
//

import XCTest
@testable import FavoritesFeature

// Una implementación simulada de FavoritesRepository con fines de prueba.
// Esto nos permite controlar la "base de datos" en nuestras pruebas.
class MockFavoritesRepository: FavoritesRepository {
    private var status: FavoriteStatus?
    private(set) var saveCalled = false
    
    init(status: FavoriteStatus?) {
        self.status = status
    }
    
    func getStatus(for itemID: FavoriteItemID) async -> FavoriteStatus {
        return status ?? FavoriteStatus(id: itemID, isFavorited: false)
    }
    
    func save(status: FavoriteStatus) async {
        self.status = status
        self.saveCalled = true
    }
}

final class FavoriteToggleUseCaseTests: XCTestCase {

    func testToggle_WhenItemIsUnfavorited_ShouldBecomeFavorited() async {
        // ARRANGE
        let itemID = "item-1"
        let initialStatus = FavoriteStatus(id: itemID, isFavorited: false)
        let repository = MockFavoritesRepository(status: initialStatus)
        let useCase = FavoriteToggleUseCase(repository: repository)
        
        // ACT
        await useCase.execute(for: itemID)
        
        // ASSERT
        let finalStatus = await repository.getStatus(for: itemID)
        XCTAssertTrue(repository.saveCalled, "Save should be called on the repository")
        XCTAssertTrue(finalStatus.isFavorited, "The item's status should be favorited")
    }
    
    func testToggle_WhenItemIsFavorited_ShouldBecomeUnfavorited() async {
        // ARRANGE
        let itemID = "item-2"
        let initialStatus = FavoriteStatus(id: itemID, isFavorited: true)
        let repository = MockFavoritesRepository(status: initialStatus)
        let useCase = FavoriteToggleUseCase(repository: repository)
        
        // ACT
        await useCase.execute(for: itemID)
        
        // ASSERT
        let finalStatus = await repository.getStatus(for: itemID)
        XCTAssertTrue(repository.saveCalled, "Save should be called on the repository")
        XCTAssertFalse(finalStatus.isFavorited, "The item's status should be unfavorited")
    }
    
    func testToggle_WhenItemDoesNotExist_ShouldBecomeFavorited() async {
        // ARRANGE
        let itemID = "item-new"
        let repository = MockFavoritesRepository(status: nil) // Simulate item not existing
        let useCase = FavoriteToggleUseCase(repository: repository)
        
        // ACT
        await useCase.execute(for: itemID)
        
        // ASSERT
        let finalStatus = await repository.getStatus(for: itemID)
        XCTAssertTrue(repository.saveCalled, "Save should be called on the repository")
        XCTAssertTrue(finalStatus.isFavorited, "A new item should become favorited")
    }
}
