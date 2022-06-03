//
//  StorableObject.swift
//  Pokedex
//
//  Created by Johann Fong on 3/6/22.
//

import Foundation

enum StorableObject {
    struct MyPokemon: Codable {
        var id: String
        var pokemonID: Int
        var name: String
    }
}
