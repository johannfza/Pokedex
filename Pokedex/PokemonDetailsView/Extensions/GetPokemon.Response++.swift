//
//  GetPokemon.Response++.swift
//  Pokedex
//
//  Created by Johann Fong on 2/6/22.
//

import Foundation

extension PokemonDetailsView.PokemonDetailsDisplayModel {
    init(model: GetPokemonResponse) {
        self.init(
            id: model.id,
            name: model.name,
            description: "",
            height: model.height,
            weight: model.weight,
            abilities: model.abilities.map { $0.ability.name },
            imageURL: PokeAPIService.GetPokemonSpriteURL.by(id: model.id),
            stats: model.stats.map { .init(name: $0.stat.name, value: $0.baseStat) }
        )
    }
}
