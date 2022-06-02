//
//  QRCodeView.swift
//  Pokedex
//
//  Created by Johann Fong on 3/6/22.
//

import SwiftUI

struct QRCodeView: View {
    let data: String
    @State var uiImage: UIImage?
    
    var body: some View {
        VStack {
            if let uiImage = uiImage {
                Image(uiImage: uiImage)
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
