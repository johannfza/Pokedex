//
//  PokeAPIService.swift
//  Pokedex
//
//  Created by Johann Fong on 1/6/22.
//

import Foundation

class PokeAPIService {
    static var shared = PokeAPIService()
    
    func getPokemons(completion: @escaping (Response) -> Void) {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/?offset=0&limit=151") else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }
            do {
                let response = try JSONDecoder().decode(Response.self, from: data)
                completion(response)
            } catch {
                return
            }
        }.resume()
    }
    
    struct Response: Codable {
        var results: [Pokemon]
        
        struct Pokemon: Codable {
            var name: String
            var url: String
        }
    }
}
