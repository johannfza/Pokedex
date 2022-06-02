//
//  ContentView.swift
//  Pokedex
//
//  Created by Johann Fong on 31/5/22.
//

import SwiftUI

struct MainContentView: View {
    var body: some View {
        NavigationView {
            PokemonListView()
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
