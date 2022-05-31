//
//  ContentView.swift
//  Pokedex
//
//  Created by Johann Fong on 31/5/22.
//

import SwiftUI

struct ContentView: View {
    @State var pokemons: [PokeAPIService.GetPokemons.Response.Pokemon] = []
    
    var body: some View {
        List(pokemons, id: \.name) { pokemon in
            PokemonRow(name: pokemon.name, imageURL: PokeAPIService.shared.getPokemonImageURL(id: pokemon.id))
        }.onAppear {
            PokeAPIService.GetPokemons.fetch { response in
                pokemons = response.results
            }
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
