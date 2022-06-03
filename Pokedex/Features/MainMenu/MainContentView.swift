//
//  MainContentView.swift
//  Pokedex
//
//  Created by Johann Fong on 31/5/22.
//

import SwiftUI

struct MainContentView: View {
    var body: some View {
        TabView {
            PokedexView()
                .tabItem {
                    Image(systemName: "text.book.closed")
                    Text("Pokedex")
                }
            
            MyPokemonsView()
                .tabItem {
                    Image(systemName: "bag")
                    Text("MyPokemon")
                }
        }
    }
}

extension GetPokemonsResponse.Pokemon {
    var id: String {
        String(pokemonID)
    }
    
    var pokemonID: Int {
        Int(URL(string: url)?.lastPathComponent ?? "") ?? 0
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainContentView()
    }
}
