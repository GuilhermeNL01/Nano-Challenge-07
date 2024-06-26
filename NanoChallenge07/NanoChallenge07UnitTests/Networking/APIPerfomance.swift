//
//  APIPerfomance.swift
//  NanoChallenge07UnitTests
//
//  Created by Luca Lacerda on 25/06/24.
//

import XCTest
@testable import NanoChallenge07

///Teste de perfomance da  API no terminal
//curl -w "Tempo de resposta: %{time_total}\n" -o /dev/null -s "https://xivapi.com/item/1675"

final class perfomanceTest:XCTestCase{
    
    enum EndpointsToTestperfomance: String {
        case search = "https://xivapi.com/search?string=champion's lance"
        case detail = "https://xivapi.com/item/1879"
        case marketinfo = "universalis.app/api/v2/45/1879"
        
    }
    
    func testEndpointResponseTime() {
        let expectation = self.expectation(description: "API Response Time Expectation")
        let url = URL(string: EndpointsToTestperfomance.search.rawValue)!

         let startTime = Date()

         let task = URLSession.shared.dataTask(with: url) { data, response, error in
             XCTAssertNil(error, "Erro: \(error?.localizedDescription ?? "desconhecido")")

             if let httpResponse = response as? HTTPURLResponse {
                 XCTAssertEqual(httpResponse.statusCode, 200, "Código de status HTTP inesperado: \(httpResponse.statusCode)")
             }

             let endTime = Date()
             let responseTime = endTime.timeIntervalSince(startTime)
             print("Tempo de resposta: \(responseTime) segundos")

             XCTAssert(responseTime < 5.0, "Tempo de resposta superior a 5 segundo")

             expectation.fulfill()
         }

         task.resume()
         wait(for: [expectation], timeout: 10.0)
    }
    
    
}

