//
//  QRCodeAPIService.swift
//  Pokedex
//
//  Created by Johann Fong on 3/6/22.
//

import Foundation
import UIKit

let qrCodebaseURL = "https://api.qrserver.com/v1/create-qr-code/?size=240x240&data="

class QRCodeAPIService {
    class GetQRCode: APIRequest {
        typealias Response = Data
        static var url: String =  qrCodebaseURL
        static func fetch(for data: String, completion: @escaping (UIImage) -> Void) {
            guard let url = URL(string: url + data) else { return }
            GetQRCode.dataTask(with: url) { data in
                guard let image = UIImage(data: data) else {
                    print("Unable to parse into image")
                    return
                }
                completion(image)
            }
        }
        
        static func dataTask(with url: URL, completion: @escaping (Data) -> Void) {
            URLSession.shared.dataTask(with: url) { data, _, error in
                guard let data = data else { return }
                completion(data)
            }.resume()
        }
    }
}
