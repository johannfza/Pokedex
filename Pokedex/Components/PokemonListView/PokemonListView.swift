//
//  PokemonListView.swift
//  Pokedex
//
//  Created by Johann Fong on 3/6/22.
//

import SwiftUI

protocol PokemonListViewDataSource {
    func getPokemons(completion: @escaping ([PokemonListView.Pokemon]) -> Void)
}

struct PokemonListView: View {
    var navigationTitle: String
    var dataSource: PokemonListViewDataSource
    @State var searchText = ""
    @State var pokemons: [Pokemon] = []
    
    var filteredPokemons: [Pokemon] {
        guard !searchText.isEmpty else { return pokemons }
        return pokemons.filter { $0.name.contains(searchText.lowercased()) }
    }
    
    var body: some View {
        NavigationView {
            List(filteredPokemons, id: \.id) { pokemon in
                NavigationLink(
                    destination: PokemonDetailsView(id: pokemon.pokemonID)
                ) {
                    PokemonRow(name: pokemon.name, imageURL:PokeAPIService.GetPokemonSpriteURL.by(id: pokemon.pokemonID))
                }
            }
            .onAppear {
                dataSource.getPokemons { pokemons in
                    self.pokemons = pokemons
                }
            }
            .navigationTitle(navigationTitle)
            .searchable(text: $searchText)
        }
    }
    
    struct Pokemon {
        var id: String
        var pokemonID: Int
        var name: String
    }
}

class MockPokemonListViewDataSource: PokemonListViewDataSource {
    func getPokemons(completion: @escaping ([PokemonListView.Pokemon]) -> Void) {
        PokeAPIService.GetPokemons.fetch { response in
            let pokemons: [PokemonListView.Pokemon] = response.results.map {
                .init(id: $0.id, pokemonID: $0.pokemonID, name: $0.name)
            }
            completion(pokemons)
        }
    }
}

struct PokemonListView_Previews: PreviewProvider {
    
    static var previews: some View {
        PokemonListView(navigationTitle: "Pokemon List", dataSource: MockPokemonListViewDataSource())
    }
}
