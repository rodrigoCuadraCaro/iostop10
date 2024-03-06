//
//  TopSongsRepo.swift
//  womptecnica
//
//  Created by Rodrigo Cuadra on 06-03-24.
//

import Foundation


class TopSongsRepository {
    private let api = itunesAPI()
    
    func getTopSongs(countryCode: String, completion: @escaping (Result<TopSongs, Error>) ->Void){
        api.fetchTunes(country: countryCode) { result in
            switch result {
            case .success(let data):
                do {
                    let topsongs = try JSONDecoder().decode(TopSongs.self, from: data)
                    completion(.success(topsongs))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
