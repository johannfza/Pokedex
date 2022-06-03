//
//  MainStore.swift
//  Pokedex
//
//  Created by Johann Fong on 3/6/22.
//

import Foundation

class MainStore {
    static let shared = MainStore()
    
    let store = UserDefaults.standard
    let encoder = JSONEncoder()
    let decoder = JSONDecoder()
    
    enum Keys: String {
        case myPokemons = "my_pokemons"
    }
    
    func save<T: Codable>(value: T, for key: Keys) {
        if let encoded = try? encoder.encode(value) {
            store.set(encoded, forKey: key.rawValue)
        }
    }
    
    func retrieve<T: Codable>(key: Keys) -> T? {
        guard
            let data = store.object(forKey: key.rawValue) as? Data,
            let value = try? decoder.decode(T.self, from: data)
        else {
            return nil
        }
        return value
    }
}
