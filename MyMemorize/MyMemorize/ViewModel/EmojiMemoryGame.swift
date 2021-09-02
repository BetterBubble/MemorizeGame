//
//  EmojiMemoryGame.swift
//  MyMemorize
//
//  Created by Alex on 27.08.2021.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    
    typealias Card = MemoryGame<String>.Card
    
    private static func createMemoryGame() -> MemoryGame<String> {
      let emojis = schemes[0].emojies.shuffled()
      let count = Int.random(in: 2...emojis.count)
        return MemoryGame<String>(numberOfPairsOfCards: count) { pairIndex in
            emojis[pairIndex]
        }
    }
    
  func newGame(scheme: Scheme) {
    self.scheme = scheme
      let emojis = scheme.emojies.shuffled()
      let count = Int.random(in: 2...emojis.count)
      model.newGame(numberOfPairsOfCards: count) { pairIndex in
            emojis[pairIndex]
      }
    }
    
    static var num = 0
    
    @Published private var model = createMemoryGame()
    
    @Published var scheme = schemes[0]
    
    var cards: Array<Card> {
        return model.cards
    }
    
    
    // MARK: намерения View
    
    func choose(_ card: Card) {
        model.choose(card)
    }
    static let schemes = [
      Scheme(title: "TopicAnimals",
             color: .red,
             emojies: ["🐙","🦕","🦖","🐍","🐢","🕷","🐞","🐌","🐛","🐝","🐴","🐗","🦆","🐧","🐔","🐷","🐸","🦁","🐻‍❄️","🦊","🐱","🐶","🐹","🐮","🦉","🦐","🦧","🦔"]),
      Scheme(title: "TopicFood",
             color: .orange,
             emojies: ["🍎","🍋","🍇","🍓","🍑","🥥","🍆","🥑","🍅","🍍","🍒","🌶","🌽","🧄","🍞","🧀","🥚","🥩","🍗","🧇","🍔","🍟","🍕","🌭","🥗","🌮","🍱","🥟","🍤","🍚","🍡","🍰","🎂","🧁","🍭","🍪"]),
      Scheme(title: "TopicActivity",
             color: .purple,
             emojies: ["⚽️","🏀","🏐","🎱","🏓","🏸","🪃","🤿","🪁","🏹","🎣","🥋","🥊","🛼","🥌","🪂","🏂","🏋️‍♀️","🤼","🤺","🤸‍♂️","🤾‍♂️","🏇","🧘‍♀️","🏄‍♀️","🏊‍♀️","🚣‍♀️","🚴‍♀️","🎻","🎸","🎮"]),
      Scheme(title: "TopicObjects",
             color: .green,
             emojies: ["⌚️","📱","💻","🖥","🖱","🖨","🕹","💿","","📷","🎥","☎️","📺","📟","📻","🧭","⏰","📡","💡","🔌","🔋","🕯","🔦","🧯","💵","🪙","🛢","💳","💎","⚖️","🪛","🧲","⚙️","💣","🔫","🧨","🪓","🔪","🪦","🔮","🏺","💈","⚗️","💊","🧬","🩸","🚽","🛎","🔑","🪆","🎁"])
    ]
}
