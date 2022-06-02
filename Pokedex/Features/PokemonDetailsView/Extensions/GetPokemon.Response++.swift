//
//  GetPokemon.Response++.swift
//  Pokedex
//
//  Created by Johann Fong on 2/6/22.
//

import Foundation

extension PokemonDetailsView.PokemonDetailsDisplayModel {
    init?(model: GetPokemonResponse) {
        guard
            let id = model.id,
            let name = model.name,
            let height = model.height,
            let weight = model.weight,
            let abilities = model.abilities,
            let stats = model.stats
        else {
            return nil
        }
        
        self.init(
            id: id,
            name: name,
            description: "",
            height: height,
            weight: weight,
            abilities: abilities.compactMap {
                guard let name = $0.ability?.name else { return nil }
                return name
            },
            imageURL: URL(
                string: model.sprites?.other?.officialArtwork?.frontDefault ?? ""
            ) ?? PokeAPIService.GetPokemonSpriteURL.by(id: id),
            stats: stats.compactMap {
                guard
                    let name = $0.stat?.name,
                    let value = $0.baseStat
                else { return nil }
                return .init(name: name, value: value)
            } ?? []
        )
    }
}
