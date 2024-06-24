//
//  Endpoint.swift
//  NanoChallenge07
//
//  Created by Fabio Freitas on 24/06/24.
//

import Foundation

enum Endpoint {
    case searchItem(String)
    case itemInfo(Int)
    case datacenters
    case worlds
    case itemPriceForWorld(Int, Int) // (WorldId, ItemId)
}

extension Endpoint {
    var host: String {
        switch self {
        case .searchItem(_), .itemInfo(_):
            return "xivapi.com"
        case .datacenters, .worlds, .itemPriceForWorld(_, _):
            return "universalis.app"
        }
    }
    
    var path: String {
        switch self {
        case .searchItem(_):
            return "/search"
        case .itemInfo(let itemId):
            return "/item/\(itemId)"
        case .datacenters:
            return "/api/v2/data-centers"
        case .worlds:
            return "/api/v2/worlds"
        case .itemPriceForWorld(let world, let itemId):
            return "/api/v2/\(world)/\(itemId)"
        }
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .searchItem(let search):
            return [.init(name: "string", value: search)]
        default:
            return nil
        }
    }
}

extension Endpoint {
    var url: URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = host
        urlComponents.path = path
        urlComponents.queryItems = queryItems
        return urlComponents.url
    }
}
