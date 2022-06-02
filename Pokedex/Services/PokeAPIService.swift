//
//  PokeAPIService.swift
//  Pokedex
//
//  Created by Johann Fong on 1/6/22.
//

import Foundation

protocol APIRequest {
    associatedtype Response: Decodable
    static var url: URL { get }
    static func dataTask(with url: URL, completion: @escaping (Response) -> Void)
}

extension APIRequest {
    static func dataTask(with url: URL, completion: @escaping (Response) -> Void) {
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
}

class PokeAPIService {
    static var shared = PokeAPIService()
    static let baseURL = "https://pokeapi.co/api/v2"
    
    enum Endpoint: String {
        case getPokemons = "/pokemon/?offset=0&limit=151"
        case getPokemon = "/pokemon/"
    }
    
    class GetPokemons: APIRequest {
        typealias Response = GetPokemonsResponse
        static var url: URL =  URL(string: PokeAPIService.baseURL + Endpoint.getPokemons.rawValue)!
        static func fetch(completion: @escaping (Response) -> Void) {
            GetPokemons.dataTask(with: url, completion: completion)
        }
    }
    
    class GetPokemon: APIRequest {
        typealias Response = GetPokemonResponse
        static var url: URL =  URL(string: PokeAPIService.baseURL + Endpoint.getPokemon.rawValue)!
        static func fetch(by id: Int, completion: @escaping (GetPokemonResponse) -> Void) {
            url.appendPathComponent(String(id))
            print(url)
            GetPokemon.dataTask(with: url, completion: completion)
        }
    }
    
    class GetPokemonSpriteURL {
        static func by(id: Int) -> URL? {
            GetPokemonSpriteURL.by(id: String(id))
        }
        
        static func by(id: String) -> URL? {
            URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(id).png")
        }
    }
}
