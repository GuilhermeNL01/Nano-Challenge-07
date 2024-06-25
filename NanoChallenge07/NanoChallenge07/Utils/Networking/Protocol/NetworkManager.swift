//
//  NetworkManager.swift
//  NanoChallenge07
//
//  Created by Fabio Freitas on 25/06/24.
//

import Foundation

protocol NetworkManager {
    func request<T: Codable>(session: URLSession,
                             _ endpoint: Endpoint,
                             type: T.Type) async throws -> T
}
