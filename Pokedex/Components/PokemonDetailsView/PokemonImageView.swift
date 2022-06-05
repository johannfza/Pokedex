//
//  PokemonImageView.swift
//  Pokedex
//
//  Created by Johann Fong on 5/6/22.
//

import SwiftUI

struct PokemonImageView: View {
    let pokemonID: Int
    @State var shouldShowQR: Bool = false
    
    var body: some View {
        ZStack {
            AsyncImage(url: PokeAPIService.GetPokemonOfficalArtworkURL.by(id: String(pokemonID))) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 240, height: 240)
        }
        .frame(width: 280, height: 280)
    }}

struct PokemonImageView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonImageView(pokemonID: 4)
    }
}
