//
//  PokedexView.swift
//  Pokedex
//
//  Created by Johann Fong on 3/6/22.
//

import SwiftUI

struct PokedexView: View {
    var body: some View {
        PokemonListView(
            navigationTitle: "Pokedex",
            dataSource: PokedexViewDataSource()
        )
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        PokedexView()
    }
}
