//
//  NetworkManager.swift
//  NanoChallenge07
//
//  Created by Guilherme Nunes Lobo on 24/06/24.
//

import Foundation
import OSLog

protocol NetworkManager {
    func request<T: Codable>(session: URLSession,
                             _ endpoint: Endpoint,
                             type: T.Type) async throws -> T
}

final class NetworkingManager: NetworkManager {
    
    public static let shared: NetworkingManager = .init()
    
    private init(){}
    
    func request<T: Codable>(session: URLSession = .shared,
                             _ endpoint: Endpoint,
                             type: T.Type) async throws -> T {
        
        guard let url = endpoint.url else {
            Logger.networkingManager.error("Failed to make a request due to invalid url")
            throw URLError(.badURL)
        }
        
        let request = URLRequest(url: url)
        Logger.networkingManager.info("Making a request to: \(url)")
        let (data, response) = try await session.data(for: request)
        
        guard let response = response as? HTTPURLResponse,
              (200...300) ~= response.statusCode else {
            let statusCode = (response as! HTTPURLResponse).statusCode
            Logger.networkingManager.error("Bad server response: \(statusCode)")
            throw URLError(.badServerResponse)
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let res = try decoder.decode(T.self, from: data)
        return res
    }
}
