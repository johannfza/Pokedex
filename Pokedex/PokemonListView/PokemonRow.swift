//
//  PokemonRow.swift
//  Pokedex
//
//  Created by Johann Fong on 31/5/22.
//

import SwiftUI

struct PokemonRow: View {
    var name: String
    var imageURL: URL?
    
    var body: some View {
        HStack(alignment: .center, spacing: 24) {
            AsyncImage(url: imageURL)
                .frame(width: 75, height: 75)
                .clipShape(Circle())
                .foregroundColor(.gray.opacity(0.6))
            Text(name.capitalized)
                .font(.headline)
        }
    }
}

struct PokemonRow_Previews: PreviewProvider {
    static var previews: some View {
        PokemonRow(name: "Charmander", imageURL: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/4.png"))
    }
}
