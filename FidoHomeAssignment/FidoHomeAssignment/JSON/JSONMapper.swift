//
//  JSONMapper.swift
//  Tundsdev
//
//  Created by Nir Leshem on 25/08/2022.
//

import Foundation

struct JSONMapper {
    
    static func decode<T: Decodable>(file: String, type: T.Type) throws -> T {
        
        guard !file.isEmpty,
              let path = Bundle.main.path(forResource: file, ofType: "json"),
              let data = FileManager.default.contents(atPath: path) else {
            throw JSONMapperError.failedToGetContents
        }

        return try JSONDecoder().decode(T.self, from: data)
    }
}

extension JSONMapper {
    enum JSONMapperError: Error {
        case failedToGetContents
    }
}
