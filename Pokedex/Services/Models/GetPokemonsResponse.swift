// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let getPokemonsResponse = try? newJSONDecoder().decode(GetPokemonsResponse.self, from: jsonData)

import Foundation

// MARK: - GetPokemonsResponse
struct GetPokemonsResponse: Codable {
    let count: Int
    let next: String
    let results: [Pokemon]
    
    // MARK: - Result
    struct Pokemon: Codable {
        let name: String
        let url: String
    }

}

