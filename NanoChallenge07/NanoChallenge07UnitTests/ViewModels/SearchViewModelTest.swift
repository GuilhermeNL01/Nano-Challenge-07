//
//  SearchViewModelTest.swift
//  NanoChallenge07UnitTests
//
//  Created by Fabio Freitas on 26/06/24.
//

import XCTest
@testable import NanoChallenge07

class SearchViewModelTest: XCTestCase {
    var sut: SearchPageViewModel!
    
    @MainActor override func setUpWithError() throws {
        sut = SearchPageViewModel(network: NetworkingManager.mock)
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }
    
    @MainActor func testSearchFunctionality() async throws {
        sut.textToSearch =  "search"
        XCTAssertFalse(sut.isSearching)
        await sut.performSearch()
        XCTAssertFalse(sut.result.Results.isEmpty)
        XCTAssertFalse(sut.isSearching)
    }
}

