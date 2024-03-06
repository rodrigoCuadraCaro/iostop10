//
//  SongDetailView.swift
//  womptecnica
//
//  Created by Rodrigo Cuadra on 06-03-24.
//

import SwiftUI

struct SongDetailView: View {
    
    let song: Song
    @State private var isTextOverflowing = false
    
    var body: some View {
        VStack{
            HStack{
                Image(systemName: "star")
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .topTrailing)
                    .padding(.horizontal)
                    .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
            }
            AsyncImage(
                url: URL(string: song.artworkUrl100 ?? "none")) {
                    phase in if let cover = phase.image {
                        cover.resizable()
                            .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                            .clipShape(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/))
                    } else if phase.error != nil{
                        Image(systemName: "network.slash")
                    } else {
                        ProgressView().progressViewStyle(.circular)
                    }
                }
            .frame(width: 250, height: 250)
            VStack {
                if isTextOverflowing {
                    // Apply animation only when text is overflowing
                    Text("This is a long text that overflows")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .lineLimit(1)
                        .padding()
                        .background(
                            GeometryReader { proxy in
                                Color.clear
                                    .onAppear {
                                        // Check if text is overflowing
                                        let isOverflowing = proxy.size.width < proxy.frame(in: .local).size.width
                                        withAnimation {
                                            self.isTextOverflowing = isOverflowing
                                        }
                                    }
                            }
                        )
                } else {
                    // Default state without animation
                    Text(song.trackCensoredName ?? "song name")
                        .frame(maxWidth: .infinity, alignment: .center)
                        .lineLimit(1)
                        .padding()
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                }
            }
            Text(song.collectionCensoredName ?? "album name").font(.title2)
                .padding(.bottom, 5.0)
            Text(song.artistName ?? "artist name").font(.title3)
            Spacer()
            Button {
                print(song.trackViewURL ?? "xddd")
                if let url = URL(string: song.trackViewURL ?? "") {
                   UIApplication.shared.open(url)
                }
            } label: {
                HStack{
                    Image(systemName: "music.note").foregroundStyle(.white)
                    Text("Reproduce esta cancion")
                        .padding()
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                }
                .frame(width: 350)
                .background(Color.red)
                .clipShape(.capsule)
            }
            
        }
        .padding()
    }
}

struct SongDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let testSong = Song(wrapperType: Optional("track"), kind: Optional("song"), artistID: Optional(262836961), collectionID: Optional(1051331933), trackID: Optional(1051332387), artistName: Optional("Adele"), collectionName: Optional("25"), trackName: Optional("Hello"), collectionCensoredName: Optional("25"), trackCensoredName: Optional("Hello"), artistViewURL: Optional("https://music.apple.com/se/artist/adele/262836961?uo=4"), collectionViewURL: Optional("https://music.apple.com/se/album/hello/1051331933?i=1051332387&uo=4"), trackViewURL: Optional("https://music.apple.com/se/album/hello/1051331933?i=1051332387&uo=4"), previewURL: Optional("https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview116/v4/5e/46/de/5e46de64-70d7-01a9-438f-8395a0e41b58/mzaf_15694838464598234027.plus.aac.p.m4a"), artworkUrl30: Optional("https://is1-ssl.mzstatic.com/image/thumb/Music116/v4/62/bc/87/62bc8791-2a12-4b01-8928-d601684a951c/634904074005.png/30x30bb.jpg"), artworkUrl60: Optional("https://is1-ssl.mzstatic.com/image/thumb/Music116/v4/62/bc/87/62bc8791-2a12-4b01-8928-d601684a951c/634904074005.png/60x60bb.jpg"), artworkUrl100: Optional("https://is1-ssl.mzstatic.com/image/thumb/Music116/v4/62/bc/87/62bc8791-2a12-4b01-8928-d601684a951c/634904074005.png/100x100bb.jpg"), collectionPrice: Optional(109.0), trackPrice: Optional(12.0), releaseDate: Optional("2015-10-23T07:00:00Z"), collectionExplicitness: Optional("notExplicit"), trackExplicitness: Optional("notExplicit"), discCount: Optional(1), discNumber: Optional(1), trackCount: Optional(11), trackNumber: Optional(1), trackTimeMillis: Optional(295502), country: Optional("SWE"), currency: Optional("SEK"), primaryGenreName: Optional("Pop"), isStreamable: Optional(true), contentAdvisoryRating: nil)
        
        SongDetailView(song: testSong)
    }
}
