//
//  NetworkingError.swift
//  FidoHomeAssignment
//
//  Created by Nir Leshem on 08/09/2022.
//

import Foundation

enum NetworkingError: LocalizedError {
    case invalidUrl
    case custom(error: Error)
    case invalidStatusCode(statusCode: Int)
    case invalidData
    case decodingError(error: Error)
}

extension NetworkingError {
    var errorDescription: String? {
        switch self {
        case .invalidUrl:
            return "URL is invalid"
        case .custom(let err):
            return "Something went wrong: \(err.localizedDescription)"
        case .invalidStatusCode(let statusCode):
            return "Response statusCode is invalid: \(statusCode)"
        case .invalidData:
            return "Response data is invalid"
        case .decodingError:
            return "Failed to decode"
        }
    }
}
