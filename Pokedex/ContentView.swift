//
//  ContentView.swift
//  Pokedex
//
//  Created by Johann Fong on 31/5/22.
//

import SwiftUI

struct ContentView: View {
    @State var searchText = ""
    @State var pokemons: [PokeAPIService.GetPokemons.Response.Pokemon] = []
    
    var filterePokemon: [PokeAPIService.GetPokemons.Response.Pokemon] {
        guard !searchText.isEmpty else { return pokemons }
        return pokemons.filter { $0.name.contains(searchText.lowercased()) }
    }
    
    var body: some View {
        NavigationView {
            List(filterePokemon, id: \.name) { pokemon in
                PokemonRow(name: pokemon.name, imageURL: PokeAPIService.shared.getPokemonImageURL(id: pokemon.id))
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

extension PokeAPIService.GetPokemons.Response.Pokemon {
    var id: String {
        URL(string: url)?.lastPathComponent ?? ""
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
