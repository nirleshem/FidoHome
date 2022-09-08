//
//  Endpoint.swift
//  FidoHomeAssignment
//
//  Created by Nir Leshem on 08/09/2022.
//

import Foundation

protocol APIBuilder {
    var baseUrl: URL { get }
    var path: String { get }
    var urlRequest: URLRequest { get }
}

enum Endpoint {
    case getArticles
}

extension Endpoint: APIBuilder {
    var apiKey: String {
        return "443a642bd46444ac8cafae672c0ffc30"
    }
    
    var baseUrl: URL {
        return URL(string: "https://newsapi.org/v2/everything")!
    }
    
    var path: String {
        switch self {
        case .getArticles:
            return "?q=tesla&from=2022-08-08&sortBy=publishedAt&apiKey=\(apiKey)"//.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
        }
    }

    var urlRequest: URLRequest {
        return URLRequest(url: baseUrl.appendingPathComponent(path))
    }
}

