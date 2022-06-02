//
//  PokemonListView.swift
//  Pokedex
//
//  Created by Johann Fong on 3/6/22.
//

import SwiftUI

struct PokemonListView: View {
    @State var searchText = ""
    @State var pokemons: [GetPokemonsResponse.Pokemon] = []
    
    var filterePokemon: [GetPokemonsResponse.Pokemon] {
        guard !searchText.isEmpty else { return pokemons }
        return pokemons.filter { $0.name.contains(searchText.lowercased()) }
    }
    
    var body: some View {
        List(filterePokemon, id: \.id) { pokemon in
            NavigationLink(destination: PokemonDetailsView(id: pokemon.id)) {
                PokemonRow(name: pokemon.name, imageURL:PokeAPIService.GetPokemonSpriteURL.by(id: pokemon.id))
            }
        }.onAppear {
            PokeAPIService.GetPokemons.fetch { response in
                pokemons = response.results
            }
        }
        .searchable(text: $searchText)
        .navigationTitle("Pokedex")
    }
}

struct PokemonListView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonListView()
    }
}
