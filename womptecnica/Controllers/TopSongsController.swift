//
//  TopSongsController.swift
//  womptecnica
//
//  Created by Rodrigo Cuadra on 06-03-24.
//

import Foundation

class TopSongsController: ObservableObject {
    @Published var topsongs = [Song]()
    
    func getList(){
        getSongs(country: "us")
        getSongs(country: "se")
    }
    
    private func getSongs(country: String){
        let repo = TopSongsRepository()
        repo.getTopSongs(countryCode: country){
            result in DispatchQueue.main.async {
                switch result {
                case .success(let songs):
                    let uniqueSongs = songs.results.filter { newSong in
                        !self.topsongs.contains { existingSong in
                            existingSong.id == newSong.id
                        }
                    }
                    self.topsongs += uniqueSongs
                case .failure(let error):
                    print("Error getting songs!: \(error)")
                }
            }
        }
    }
}
