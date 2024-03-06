//
//  tunesAPI.swift
//  womptecnica
//
//  Created by Rodrigo Cuadra on 06-03-24.
//

import Foundation

class itunesAPI {
    
    func fetchTunes(country: String, completion: @escaping (Result<Data, Error>) -> Void){
        if let url = URL(string: "https://itunes.apple.com/search?term=pop&country=\(country)&entity=song&lang=es&limit=10") {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, _, error in
                if let error = error {
                    completion(.failure(error))
                } else if let data = data {
                    completion(.success(data))
                }
            }
            task.resume()
        }
    }
}
