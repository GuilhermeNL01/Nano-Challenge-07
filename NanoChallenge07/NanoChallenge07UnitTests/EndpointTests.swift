//
//  NanoChallenge07UnitTests.swift
//  NanoChallenge07UnitTests
//
//  Created by Fabio Freitas on 25/06/24.
//

import XCTest
@testable import NanoChallenge07

final class EndpointTests: XCTestCase {
    var sut: Endpoint!
    
    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testEndpointsGenerateValidURL() {
        let endpoints: [Endpoint] = [.searchItem("item"), .datacenters, .worlds,.itemInfo(49),.itemPriceForWorld(49, 420)]
        for endpoint in endpoints {
            XCTAssertNotNil(endpoint.url)
        }
    }
    
    func testSearchEndpointPath() {
        sut = .searchItem("item")
        XCTAssertFalse(sut.path.isEmpty)
        XCTAssertTrue(sut.path.contains("/"))
        XCTAssertTrue(sut.path.contains("search"))
    }
    
    func testSearchEndpointHost() {
        sut = .searchItem("item")
        XCTAssertFalse(sut.host.isEmpty)
    }
    
    func testSearchEndpointQueryItems() {
        sut = .searchItem("item")
        XCTAssertNotNil(sut.queryItems)
        XCTAssertFalse(sut.queryItems!.isEmpty)
        XCTAssertGreaterThan(sut.queryItems!.count, 0)
        XCTAssertTrue(sut.queryItems![0].name.contains("string"))
    }
}
