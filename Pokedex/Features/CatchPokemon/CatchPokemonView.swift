//
//  CatchPokemonView.swift
//  Pokedex
//
//  Created by Johann Fong on 3/6/22.
//

import SwiftUI
import CodeScanner

struct CatchPokemonView: View {
    @State var isAlertPresented = false
    
    var body: some View {
        CodeScannerView(codeTypes: [.qr]) { response in
            switch response {
            case .success(let result):
                guard
                    let pokemonDetails = getPokemonDetails(from: result.string),
                    let pokemonID = Int(pokemonDetails.pokemonID)
                else {
                    return
                }
                let caughtPokemon = StorableObject.MyPokemon(
                    id: UUID().uuidString,
                    pokemonID: pokemonID,
                    name: pokemonDetails.name
                )
                save(pokemon: caughtPokemon)
                isAlertPresented = true
            case .failure(let error):
                print(error.localizedDescription)
            }
        }.alert("You caught a pokemon!", isPresented: $isAlertPresented) {
            Button("Got it!") { }
        }
    }
    
    func getPokemonDetails(from payload: String) -> (name: String, pokemonID: String)? {
        guard let nameRegex = try? NSRegularExpression(pattern: "[^name:][a-zA-Z]*"),
              let idRegex = try? NSRegularExpression(pattern: "[^pokemonId:]*[0-9]")
        else {
            return nil
        }
        let range = NSRange(location: 0, length: payload.utf16.count)
        let nameRange = nameRegex.firstMatch(in: payload, options: [], range: range)
        let nsString = payload as NSString
        let name = nsString.substring(with: nameRange!.range)
        let pokemonIDRange = idRegex.firstMatch(in: payload, options: [], range: range)
        let pokemonID = nsString.substring(with: pokemonIDRange!.range)
        return (name, pokemonID)
    }
    
    func save(pokemon: StorableObject.MyPokemon) {
        guard var pokemonCollection: [StorableObject.MyPokemon] = MainStore.shared.retrieve(key: .myPokemons) else {
            MainStore.shared.save(value: [pokemon], for: .myPokemons)
            return
        }
        pokemonCollection.append(pokemon)
        MainStore.shared.save(value: pokemonCollection, for: .myPokemons)
    }
}

struct CatchPokemonView_Previews: PreviewProvider {
    static var previews: some View {
        CatchPokemonView()
    }
}
