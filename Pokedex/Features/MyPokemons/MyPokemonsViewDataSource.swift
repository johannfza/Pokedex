//
//  MyPokemonsViewDataSource.swift
//  Pokedex
//
//  Created by Johann Fong on 3/6/22.
//

import Foundation

class MyPokemonsViewDataSource: PokemonListViewDataSource {
    func getPokemons(completion: @escaping ([PokemonListView.Pokemon]) -> Void) {
        guard let storedPokemons: [StorableObject.MyPokemon] = MainStore.shared.retrieve(key: .myPokemons) else {
            print("Error: no stored pokemons")
            return
        }
        let pokemons: [PokemonListView.Pokemon] = storedPokemons.map {
            .init(id: $0.id, pokemonID: $0.pokemonID, name: $0.name)
        }
        completion(pokemons)
    }
}
