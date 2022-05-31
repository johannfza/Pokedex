//
//  PokemonRow.swift
//  Pokedex
//
//  Created by Johann Fong on 31/5/22.
//

import SwiftUI

struct PokemonRow: View {
    var name: String
    var imageURL: String
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: imageURL))
            Text(name)
        }
    }
}

struct PokemonRow_Previews: PreviewProvider {
    static var previews: some View {
        PokemonRow(name: "Charmander", imageURL: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/4.png")
    }
}
