//
//  PokemonQRCodeImageView.swift
//  Pokedex
//
//  Created by Johann Fong on 3/6/22.
//

import SwiftUI

struct PokemonQRCodeImageView: View {
    let url: URL?
    let qrCodeData: String
    @State var shouldShowQR: Bool = false
    
    var body: some View {
        ZStack {
            AsyncImage(url: url) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 240, height: 240)
            QRCodeView(data: qrCodeData)
                .opacity(shouldShowQR ? 0.6 : 0.0)
            Image(systemName: "qrcode")
                .font(.system(size: 24))
                .offset(x: 120, y: 120)
                .onTapGesture {
                    withAnimation {
                        shouldShowQR.toggle()
                    }
                }
        }
        .frame(width: 280, height: 280)
    }
}

struct PokemonQRCodeImageView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonQRCodeImageView(
            url: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/4.png"),
            qrCodeData: "test"
        )
    }
}
