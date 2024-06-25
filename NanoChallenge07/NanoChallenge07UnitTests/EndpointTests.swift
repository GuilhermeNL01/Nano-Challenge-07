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
    
    func testItemInfoEndpointHost() {
        sut = .itemInfo(69)
        XCTAssertFalse(sut.host.isEmpty)
    }
    
    func testItemInfoEndpointPath() {
        sut = .itemInfo(69)
        XCTAssertFalse(sut.path.isEmpty)
        XCTAssertTrue(sut.path.contains("69"))
        XCTAssertTrue(sut.path.contains("item"))
    }
    
    func testDatacentersEndpointHost() {
        sut = .datacenters
        XCTAssertFalse(sut.host.isEmpty)
    }
    
    func testDatacentersEndpointPath() {
        sut = .datacenters
        XCTAssertFalse(sut.path.isEmpty)
        XCTAssertTrue(sut.path.contains("data-centers"))
    }
    
    func testWorldsEndpointHost() {
        sut = .worlds
        XCTAssertFalse(sut.host.isEmpty)
    }
    
    func testWorldsEndpointPath() {
        sut = .worlds
        XCTAssertFalse(sut.path.isEmpty)
        XCTAssertTrue(sut.path.contains("worlds"))
    }
    
    func testItemPriceForWorldEndpointHost() {
        sut = .itemPriceForWorld(12, 34)
        XCTAssertFalse(sut.host.isEmpty)
    }
    
    func testItemPriceForWorldEndpointPath() {
        sut = .itemPriceForWorld(12, 34)
        XCTAssertFalse(sut.path.isEmpty)
        XCTAssertTrue(sut.path.contains("12"))
        XCTAssertTrue(sut.path.contains("12"))
    }
}
