//
//  TopSongsList.swift
//  womptecnica
//
//  Created by Rodrigo Cuadra on 06-03-24.
//

import SwiftUI

struct TopSongsList: View {
    @ObservedObject var topSongsController = TopSongsController()
    
    var body: some View {
        VStack{
            NavigationView{
                List(self.topSongsController.topsongs){
                    song in
                    NavigationLink(destination: SongDetailView(song: song)){
                        HStack{
                            AsyncImage(
                                url: URL(string: song.artworkUrl100 ?? "none")) {
                                    phase in if let cover = phase.image {
                                        cover.resizable()
                                    } else if phase.error != nil{
                                        Image(systemName: "network.slash")
                                    } else {
                                        ProgressView().progressViewStyle(.circular)
                                    }
                                }
                            .frame(width: 100, height: 100)
                            VStack(
                                alignment: HorizontalAlignment.leading
                            ){
                                Text(song.trackCensoredName ?? "no song").fontWeight(.bold)
                                Text(song.artistName ?? "not found")
                            }
                        }
                    }
                }.navigationTitle("Top \(self.topSongsController.topsongs.count)")
            }
        }.onAppear(perform: {
            self.topSongsController.getList()
        })
    }
}


