//
//  PokedexViewDataSource.swift
//  Pokedex
//
//  Created by Johann Fong on 3/6/22.
//

import Foundation

class PokedexViewDataSource: PokemonListViewDataSource {
    func getPokemons(completion: @escaping ([PokemonListView.Pokemon]) -> Void) {
        PokeAPIService.GetPokemons.fetch { response in
            let pokemons: [PokemonListView.Pokemon] = response.results.map {
                .init(id: $0.id, pokemonID: $0.pokemonID, name: $0.name)
            }
            completion(pokemons)
        }
    }
}
