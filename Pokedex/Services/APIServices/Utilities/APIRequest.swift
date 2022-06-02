//
//  APIRequest.swift
//  Pokedex
//
//  Created by Johann Fong on 3/6/22.
//

import Foundation

protocol APIRequest {
    associatedtype Response: Decodable
    static var url: String { get }
    static func dataTask(with url: URL, completion: @escaping (Response) -> Void)
}

extension APIRequest {
    static func dataTask(with url: URL, completion: @escaping (Response) -> Void) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else { return }
            do {
                let response = try JSONDecoder().decode(Response.self, from: data)
                completion(response)
            } catch let decodingError {
                print(decodingError.localizedDescription)
                return
            }
        }.resume()
    }
}

