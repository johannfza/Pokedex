//
//  MainContentView.swift
//  Pokedex
//
//  Created by Johann Fong on 31/5/22.
//

import SwiftUI

struct MainContentView: View {
    var body: some View {
        NavigationView {
            TabView {
                PokemonListView()
                    .tabItem {
                        Image(systemName: "text.book.closed")
                        Text("Pokedex")
                    }
                
                Text("My Pokemon")
                    .tabItem {
                        Image(systemName: "bag")
                        Text("MyPokemon")
                    }
            }
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
        MainContentView()
    }
}
