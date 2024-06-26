//
//  DetailPageViewModelTest.swift
//  NanoChallenge07UnitTests
//
//  Created by Fabio Freitas on 26/06/24.
//

import XCTest
@testable import NanoChallenge07

class DetailPageViewModelTest: XCTestCase {
    var sut: DetailPageViewModel!
    
    @MainActor override func setUpWithError() throws {
        sut = DetailPageViewModel(network: NetworkingManager.mock)
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }
    
    @MainActor func testSearchDatacenters() async {
        XCTAssertFalse(sut.isLoadingDatacenters)
        XCTAssertTrue(sut.dataCenters.isEmpty)
        await sut.searchDataCenter()
        XCTAssertFalse(sut.dataCenters.isEmpty)
        XCTAssertFalse(sut.isLoadingDatacenters)
    }
    
    @MainActor func testSearchWorlds() async {
        XCTAssertTrue(sut.worlds.isEmpty)
        await sut.searchWorlds()
        XCTAssertFalse(sut.worlds.isEmpty)
    }
    
    @MainActor func testItemInfo() async {
        XCTAssertNil(sut.iteminfo)
        await sut.searchInfo(info: 123)
        XCTAssertNotNil(sut.iteminfo)
    }
    
    @MainActor func testItemPriceForWorld() async {
        XCTAssertTrue(sut.prices.isEmpty)
        XCTAssertFalse(sut.isLoadingPrices)
        await sut.searchInfo(info: 123)
        await sut.searchDataCenter()
        await sut.searchWorlds()
        await sut.searchMarketInfo()
        XCTAssertFalse(sut.prices.isEmpty)
        XCTAssertFalse(sut.isLoadingPrices)
    }
}
