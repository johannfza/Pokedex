//
//  PokeAPIService.swift
//  Pokedex
//
//  Created by Johann Fong on 1/6/22.
//

import Foundation

protocol APIRequest {
    associatedtype Response: Decodable
    static var url: String { get }
    static func dataTask(with url: URL, completion: @escaping (Response) -> Void)
}

extension APIRequest {
    static func dataTask(with url: URL, completion: @escaping (Response) -> Void) {
        URLSession.shared.dataTask(with: url) { data, _, error in
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
let baseURL = "https://pokeapi.co/api/v2"

class PokeAPIService {
    static var shared = PokeAPIService()
    
    enum Endpoint: String {
        case getPokemons = "/pokemon/?offset=0&limit=151"
        case getPokemon = "/pokemon/"
    }
    
    class GetPokemons: APIRequest {
        typealias Response = GetPokemonsResponse
        static var url: String =  baseURL + Endpoint.getPokemons.rawValue
        static func fetch(completion: @escaping (Response) -> Void) {
            guard let url = URL(string: url) else { return }
            GetPokemons.dataTask(with: url, completion: completion)
        }
    }
    
    class GetPokemon: APIRequest {
        typealias Response = GetPokemonResponse
        static var url: String = baseURL + Endpoint.getPokemon.rawValue
        static func fetch(by id: Int, completion: @escaping (GetPokemonResponse) -> Void) {
            guard let url = URL(string: url + String(id)) else { return }
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
