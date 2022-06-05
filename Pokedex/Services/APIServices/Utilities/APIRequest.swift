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

}

