//
//  QRCodeView.swift
//  Pokedex
//
//  Created by Johann Fong on 3/6/22.
//

import SwiftUI

struct QRCodeView: View {
    let data: String
    let opacity: Double = 0.0
    @State var uiImage: UIImage?
    
    var body: some View {
        ZStack {
            if let uiImage = uiImage {
                Image(uiImage: uiImage)
                    .opacity(opacity)
            }
        }.onAppear {
            QRCodeAPIService.GetQRCode.fetch(for: data) { uiImage in
                self.uiImage = uiImage
            }
        }
    }
}

struct QRCodeView_Previews: PreviewProvider {
    static var previews: some View {
        QRCodeView(data: "test")
    }
}
