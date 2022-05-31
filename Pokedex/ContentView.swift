//
//  ContentView.swift
//  Pokedex
//
//  Created by Johann Fong on 31/5/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        List {
            PokemonRow(name: "Charmander", imageURL: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/4.png")
        }.onAppear {
            PokeAPIService.shared.getPokemons { response in
                response.results.forEach { pokemon in
                    print(pokemon)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
