//
//  Endpoint.swift
//  FidoHomeAssignment
//
//  Created by Nir Leshem on 08/09/2022.
//

import Foundation

enum Endpoint {
    case getArticles
}

extension Endpoint {
    var host: String {
        return "newsapi.org"
    }
    
    var path: String {
        switch self {
        case .getArticles:
            return "/v2/everything"
        }
    }

    var queryItems: [String : String]? {
        switch self {
        case .getArticles:
            return [
                "q" : "tesla",
                "from" : "2022-08-08",
                "sortBy" : "publishedAt",
                "apiKey" : "443a642bd46444ac8cafae672c0ffc30",
            ]
        }
    }
}
    
extension Endpoint {
    var url: URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = host
        urlComponents.path = path
             
        var requestQueryItems = [URLQueryItem]()
        queryItems?.forEach { item in
            requestQueryItems.append(URLQueryItem(name: item.key, value: item.value))
        }

        urlComponents.queryItems = requestQueryItems
        return urlComponents.url
    }
}

