//
//  PokeAPIService.swift
//  Pokedex
//
//  Created by Johann Fong on 1/6/22.
//

import Foundation

class PokeAPIService {
    let baseURL: String
    
    static let shared = PokeAPIService(baseURL: "https://pokeapi.co/api/v2")
    
    init(baseURL: String) {
        self.baseURL = baseURL
    }
    
    enum Endpoint: String {
        case getPokemons = "/pokemon/?offset=0&limit=151"
        case getPokemon = "/pokemon/"
    }
    
    func getPokemons(completion: @escaping (GetPokemonsResponse) -> Void) {
        guard let url = URL(string: baseURL + Endpoint.getPokemons.rawValue) else { return }
        dataTask(with: url, completion: completion)
    }
    
    func getPokemon(by id: Int, completion: @escaping (GetPokemonResponse) -> Void) {
        guard let url = URL(string: baseURL + Endpoint.getPokemon.rawValue + String(id)) else { return }
        dataTask(with: url, completion: completion)
    }
    
    func dataTask<T: Codable>(with url: URL, completion: @escaping (T) -> Void) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else { return }
            do {
                let response = try JSONDecoder().decode(T.self, from: data)
                completion(response)
            } catch let decodingError {
                print(decodingError.localizedDescription)
                return
            }
        }.resume()
    }
    
    func getPokemonSpriteURLby(id: Int) -> URL? {
        getPokemonSpriteURLby(id: String(id))
    }
    
    func getPokemonSpriteURLby(id: String) -> URL? {
        URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(id).png")
    }
    
    func getPokemonOfficalArtworkURLby(id: Int) -> URL? {
        getPokemonOfficalArtworkURLby(id: String(id))
    }
    
    func getPokemonOfficalArtworkURLby(id: String) -> URL? {
        URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/\(id).png")
    }
}
