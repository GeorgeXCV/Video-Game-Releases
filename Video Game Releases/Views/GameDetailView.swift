//
//  GameDetailView.swift
//  Video Game Releases
//
//  Created by George on 08/10/2019.
//  Copyright © 2019 George. All rights reserved.
//

import SwiftUI

struct GameDetailView: View {
    
    @ObservedObject var gameDetail = GameDetail()
    @ObservedObject var imageLoader = ImageLoader()
    
    var gameId: Int // Accept ID of the game as the parameter so we can fetch the game metadata from th eAPI when viwe is pushed onto navigation stack.
    
    var body: some View {
     Group {
                    if (self.gameDetail.game != nil) {
                        List {                                          // Create a List and put the Image on top, followed by section for text of storyline, summary etc.
                            PosterView(image: self.imageLoader.image)
                            .offset(y: 30)
                            .padding(.bottom, 30)
                                .onAppear {
                                    if let url = self.gameDetail.game?.coverURL {
                                        self.imageLoader.downloadImage(url: url)
                                    }
                            }
                            
                            GameSectionView(game: self.gameDetail.game!)
                        }
                    } else {
                        LoadingView()
                    }
                }
                .edgesIgnoringSafeArea([.top])
                .onAppear {
                    self.gameDetail.reload(id: self.gameId)
                }
            }
        }

        struct PosterView: View {
            
            var image: UIImage?
            var body: some View {
                ZStack() {
                    Rectangle()
                        .foregroundColor(.gray)
                        .aspectRatio(500/700, contentMode: .fit)
                    if (image != nil) {
                        Image(uiImage: self.image!)
                            .resizable()
                            .aspectRatio(500/750, contentMode: .fit)
                    }
                }
            }
        }


        struct GameSectionView: View {
            
            var game: Game

            var body: some View {
                Section {
                    Text(game.summary)
                        .font(.body)
                        .lineLimit(nil)
                    
                    if (!game.storyline.isEmpty) {
                        Text(game.storyline)
                            .font(.body)
                            .lineLimit(nil)
                    }
                    Text(game.genreText)
                        .font(.subheadline)
                    Text(game.releaseDateText)
                        .font(.subheadline)
                    Text(game.company)
                        .font(.subheadline)
                }
            }
        }

