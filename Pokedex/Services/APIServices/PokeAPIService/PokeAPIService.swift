//
//  PokeAPIService.swift
//  Pokedex
//
//  Created by Johann Fong on 1/6/22.
//

import Foundation

let pokeAPIbaseURL = "https://pokeapi.co/api/v2"

class PokeAPIService {    
    enum Endpoint: String {
        case getPokemons = "/pokemon/?offset=0&limit=151"
        case getPokemon = "/pokemon/"
    }
    
    class GetPokemons: APIRequest {
        typealias Response = GetPokemonsResponse
        static var url: String =  pokeAPIbaseURL + Endpoint.getPokemons.rawValue
        static func fetch(completion: @escaping (Response) -> Void) {
            guard let url = URL(string: url) else { return }
            GetPokemons.dataTask(with: url, completion: completion)
        }
    }
    
    class GetPokemon: APIRequest {
        typealias Response = GetPokemonResponse
        static var url: String = pokeAPIbaseURL + Endpoint.getPokemon.rawValue
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
