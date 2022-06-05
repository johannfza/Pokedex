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
    @State var state: ViewState = .scanning
    
    enum ViewState {
        case scanning
        case saving
        case saved
    }
    
    var body: some View {
        CodeScannerView(codeTypes: [.qr], scanMode: .oncePerCode, shouldVibrateOnSuccess: true) { response in
            switch response {
            case .success(let result):
                guard state == .scanning else { break }
                state = .saving
                handle(result: result.string)
                state = .saved
            case .failure(let error):
                print(error.localizedDescription)
            }
        }.alert("You caught a Pokemon!", isPresented: $isAlertPresented) {
            Button("Got it!") {
                state = .scanning
            }
        }
        .overlay {
            if state == .saving {
                ProgressView()
            }
        }
    }
    
    func handle(result: String) {
        if let pokemonDetails = getPokemonDetails(from: result),
           let pokemonID = Int(pokemonDetails.pokemonID) {
            save(pokemonID: pokemonID, name: pokemonDetails.name)
            isAlertPresented = true
        } else {
            let randomPokemonID = Int.random(in: 1...151)
            PokeAPIService.GetPokemon.fetch(by: randomPokemonID) { pokemon in
                guard let pokemonName = pokemon.name else { return }
                save(pokemonID: randomPokemonID, name: pokemonName)
            }
            isAlertPresented = true
        }
    }
    
    func getPokemonDetails(from payload: String) -> (name: String, pokemonID: String)? {
        let range = NSRange(location: 0, length: payload.utf16.count)
        guard
            let nameRegex = try? NSRegularExpression(pattern: "[^name:][a-zA-Z]*"),
            let idRegex = try? NSRegularExpression(pattern: "[^pokemonId:]*[0-9]"),
            let nameRange = nameRegex.firstMatch(in: payload, options: [], range: range)?.range,
            let pokemonIDRange = idRegex.firstMatch(in: payload, options: [], range: range)?.range
        else {
            return nil
        }
        let nsString = payload as NSString
        let name = nsString.substring(with: nameRange)
        let pokemonID = nsString.substring(with: pokemonIDRange)
        return (name, pokemonID)
    }
    
    func save(pokemonID: Int, name: String) {
        let pokemon = StorableObject.MyPokemon(
            id: UUID().uuidString,
            pokemonID: pokemonID,
            name: name
        )
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
