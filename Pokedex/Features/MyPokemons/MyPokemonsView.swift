//
//  MyPokemonsView.swift
//  Pokedex
//
//  Created by Johann Fong on 3/6/22.
//

import SwiftUI

struct MyPokemonsView: View {
    var body: some View {
        PokemonListView(
            navigationTitle: "My Pokemons",
            dataSource: MyPokemonsViewDataSource()
        )
    }
}

struct MyPokemonsView_Previews: PreviewProvider {
    static var previews: some View {
        MyPokemonsView()
    }
}

