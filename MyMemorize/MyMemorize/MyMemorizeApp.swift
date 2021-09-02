//
//  MyMemorizeApp.swift
//  MyMemorize
//
//  Created by Alex on 27.08.2021.
//

import SwiftUI

@main
struct MyMemorizeApp: App {
    @StateObject var game = EmojiMemoryGame()
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView()
                .environmentObject(game)
        }
    }
}
