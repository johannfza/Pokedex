//
//  PokemonDetailView.swift
//  Pokedex
//
//  Created by Johann Fong on 1/6/22.
//

import SwiftUI

struct PokemonDetailsView: View {
    var id: Int
    @State var model: PokemonDetailsDisplayModel?
    
    var body: some View {
        VStack {
            if let model = model {
                VStack(alignment: .center, spacing: 24) {
                    PokemonQRCodeImageView(url: model.imageURL, qrCodeData: "pokemonID:\(model.id)")
                    HStack(alignment: .center, spacing: 24) {
                        HStack {
                            Text("Height:")
                            Text(String(model.height))
                        }
                        HStack {
                            Text("Weight:")
                            Text(String(model.weight))
                        }
                    }
                    Text(model.description)
                        .multilineTextAlignment(.center)
                    List {
                        Section(header: Text("Abilities")) {
                            ForEach(model.abilities, id: \.self) { ability in
                                Text(ability.capitalized)
                            }
                        }
                        Section(header: Text("Stats")) {
                            ForEach(model.stats, id: \.name) { stat in
                                HStack {
                                    Text(stat.name.capitalized)
                                    Spacer()
                                    Text(String(stat.value))
                                }
                            }
                        }
                    }
                }
            }
        }.onAppear {
            PokeAPIService.GetPokemon.fetch(by: id) { response in
                model = .init(model: response)
            }
        }
        .navigationTitle(Text(model?.name.capitalized ?? ""))
    }
    
    struct PokemonDetailsDisplayModel {
        var id: Int
        var name: String
        var description: String
        var height: Int
        var weight: Int
        var abilities: [String]
        var imageURL: URL?
        var stats: [Stat]
        
        struct Stat {
            var name: String
            var value: Int
        }
    }
}

struct PokemonDetailView_Previews: PreviewProvider {
    static var mockModel: PokemonDetailsView.PokemonDetailsDisplayModel = .init(
        id: 4,
        name: "charmander",
        description: "The flame that burns at the tip of its\ntail is an indication of its emotions.\nThe flame wavers when CHARMANDER is\nenjoying itself. If the POK??MON becomes\nenraged, the flame burns fiercely.",
        height: 6,
        weight: 85,
        abilities: [
            "blaze", "solar-power"
        ],
        imageURL: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/4.png"),
        stats: [
            .init(name: "hp", value: 39),
            .init(name: "attack", value: 52),
            .init(name: "defense", value: 43),
            .init(name: "special-attack", value: 60),
            .init(name: "special-defense", value: 50),
            .init(name: "speed", value: 65)
        ]
    )
    
    static var previews: some View {
        PokemonDetailsView(id: 4)
    }
}
