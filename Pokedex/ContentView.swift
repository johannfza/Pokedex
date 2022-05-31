//
//  ContentView.swift
//  Pokedex
//
//  Created by Johann Fong on 31/5/22.
//

import SwiftUI

struct ContentView: View {
    @State var pokemons: [PokeAPIService.Response.Pokemon] = []
    
    var body: some View {
        List(pokemons, id: \.name) { pokemon in
            PokemonRow(name: pokemon.name, imageURL: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/4.png")
        }.onAppear {
            PokeAPIService.shared.getPokemons { response in
                pokemons = response.results
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
