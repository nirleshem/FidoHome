//
//  NetworkingManager.swift
//  FidoHomeAssignment
//
//  Created by Nir Leshem on 08/09/2022.
//

import Foundation

protocol NetworkingManagerProtocol {
    func request<T: Codable>(_ endpoint: Endpoint, type: T.Type) async throws -> T
}

final class NetworkingManager: NetworkingManagerProtocol {
    
    static let shared = NetworkingManager()
    
    private init() {}
    
    func request<T: Codable>(_ endpoint: Endpoint, type: T.Type) async throws -> T {

        guard let url = endpoint.url else {
            throw NetworkingError.invalidUrl
        }
        
        let (data, response) = try await URLSession.shared.data(for: URLRequest(url: url))
        
        guard let response = response as? HTTPURLResponse, (200...300) ~= response.statusCode else {
            let statusCode = (response as! HTTPURLResponse).statusCode
            throw NetworkingError.invalidStatusCode(statusCode: statusCode)
        }
        
        return try JSONDecoder().decode(T.self, from: data)
    }
}
