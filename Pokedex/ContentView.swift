//
//  ContentView.swift
//  Pokedex
//
//  Created by Johann Fong on 31/5/22.
//

import SwiftUI

struct ContentView: View {
    @State var searchText = ""
    @State var pokemons: [GetPokemonsResponse.Pokemon] = []
    
    var filterePokemon: [GetPokemonsResponse.Pokemon] {
        guard !searchText.isEmpty else { return pokemons }
        return pokemons.filter { $0.name.contains(searchText.lowercased()) }
    }
    
    var body: some View {
        NavigationView {
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
}

extension GetPokemonsResponse.Pokemon {
    var id: Int {
        Int(URL(string: url)?.lastPathComponent ?? "") ?? 0
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
