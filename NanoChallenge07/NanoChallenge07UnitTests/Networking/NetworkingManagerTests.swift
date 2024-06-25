//
//  NetworkingManagerTests.swift
//  NanoChallenge07UnitTests
//
//  Created by Fabio Freitas on 25/06/24.
//

import XCTest
@testable import NanoChallenge07

final class NetworkingManagerTests: XCTestCase {
    
    private var session: URLSession!
    
    override func setUp() {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLSessionProtocol.self]
        session = URLSession(configuration: configuration)
    }
    
    override func tearDown() {
        session = nil
    }
    
    func testNetworkingManagerRequestSuccess() async throws {
        MockURLSessionProtocol.handler = {
            let response = HTTPURLResponse(url: Endpoint.datacenters.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
            let data = """
                [
                    {
                        "name": "Elemental",
                        "region": "Japan",
                        "worlds": [
                            45,
                            49,
                            50,
                            58,
                            68,
                            72,
                            90,
                            94
                        ]
                    }
                ]
                """.data(using: .utf8)!
            return (response, data)
        }
        do {
            let result = try await NetworkingManager.shared.request(session: session, .datacenters, type: [DataCenter].self)
            XCTAssertFalse(result.isEmpty)
            XCTAssertEqual(result.count, 1)
        } catch {
            XCTFail()
        }
    }
    
    func testNetworkingManagerRequestServerFailure() async throws {
        MockURLSessionProtocol.handler = {
            let response = HTTPURLResponse(url: Endpoint.datacenters.url!, statusCode: 500, httpVersion: nil, headerFields: nil)!
            return (response, nil)
        }
        
        do {
            _ = try await NetworkingManager.shared.request(session: session, .datacenters, type: [DataCenter].self)
            XCTFail()
        } catch {
            XCTAssertNotNil(error as? URLError)
            XCTAssertEqual(error as! URLError, URLError(.badServerResponse))
        }
    }
    
    func testNetworkingManagerRequestParseFailure() async throws {
        MockURLSessionProtocol.handler = {
            let response = HTTPURLResponse(url: Endpoint.datacenters.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
            let data = """
                [
                    {
                        "name": "Elemental",
                        "region": "Japan",
                        "worlds": [
                            45,
                            49,
                            50,
                            58,
                            68,
                            72,
                            90,
                            94
                        ]
                    }
                """.data(using: .utf8)!
            return (response, data)
        }
        do {
            let result = try await NetworkingManager.shared.request(session: session, .datacenters, type: [DataCenter].self)
            XCTFail()
        } catch {
            XCTAssertNotNil(error as? DecodingError)
        }
    }
    
}
