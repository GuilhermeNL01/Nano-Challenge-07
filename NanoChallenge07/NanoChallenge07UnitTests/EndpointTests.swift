//
//  NanoChallenge07UnitTests.swift
//  NanoChallenge07UnitTests
//
//  Created by Fabio Freitas on 25/06/24.
//

import XCTest
@testable import NanoChallenge07

final class EndpointTests: XCTestCase {
    func testEndpointsGenerateValidURL() {
        var endpoints: [Endpoint] = [.searchItem("item"), .datacenters, .worlds,.itemInfo(49),.itemPriceForWorld(49, 420)]
        for endpoint in endpoints {
            XCTAssertNotNil(endpoint.url)
        }
    }
}
