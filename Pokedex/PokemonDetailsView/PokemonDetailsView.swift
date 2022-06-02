//
//  PokemonDetailView.swift
//  Pokedex
//
//  Created by Johann Fong on 1/6/22.
//

import SwiftUI

struct PokemonDetailsView: View {
    @State var model: PokemonDetailsDisplayModel?
    
    var body: some View {
        if let model = model {
            VStack(alignment: .center, spacing: 24) {
                AsyncImage(url: model.imageURL) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 200, height: 200)
                Text(model.name.capitalized)
                    .font(.headline)
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
                                Text(String(stat.value))
                            }
                        }
                    }
                }
            }
        }
    }
    
    struct PokemonDetailsDisplayModel {
        var id: String
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
        id: "4",
        name: "charmander",
        description: "The flame that burns at the tip of its\ntail is an indication of its emotions.\nThe flame wavers when CHARMANDER is\nenjoying itself. If the POKéMON becomes\nenraged, the flame burns fiercely.",
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
        PokemonDetailsView(model: mockModel)
    }
}
