//
//  EmojiMemoryGameView.swift
//  MyMemorize
//
//  Created by Alex on 27.08.2021.
//

import SwiftUI

struct EmojiMemoryGameView: View {
  @State var showGame = false
  @EnvironmentObject var viewModel: EmojiMemoryGame
    
  let schemes = EmojiMemoryGame.schemes
    
  var body: some View {
    NavigationView {
      List {
        ForEach(schemes) { scheme in
          FirstWindow(scheme: scheme)
            .onTapGesture {
              showGame = true
              viewModel.newGame(scheme: scheme)
            }
        }
      }
      .navigationBarTitle("Topics")
    }
    .fullScreenCover(isPresented: $showGame) {
      NewGame()
    }
  }
}

struct FirstWindow: View {
  var scheme: Scheme
  
  var body: some View {
    VStack {
      Text(scheme.title)
        .font(.system(size: 30, weight: .semibold, design: .rounded))
        .foregroundColor(scheme.color)
      HStack {
        ForEach(scheme.emojies[0...6], id: \.self) { emoji in
          Text(emoji)
            .font(.largeTitle)
        }
      }
    }
    .padding(5)
    .border(scheme.color, width: 4)
    .cornerRadius(10)
    .padding(.bottom, 30)
  }
}

struct NewGame: View {
  @EnvironmentObject var viewModel: EmojiMemoryGame
  @Environment(\.presentationMode) var presentationMode
  var body: some View {
    NavigationView {
      ScrollView {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
          ForEach(viewModel.cards) { card in
            CardView(card: card)
              .aspectRatio(2/3, contentMode: .fit)
              .onTapGesture {
                viewModel.choose(card)
              }
          }
        }
      }
      .foregroundColor(viewModel.scheme.color)
      .padding(.horizontal)
      .navigationTitle(viewModel.scheme.title)
      .toolbar {
        Button {
          presentationMode.wrappedValue.dismiss()
        } label: {
          Text("Выбрать тему")
        }

      }
    }
    
  }
}

struct CardView: View {
  let card: MemoryGame<String>.Card
  
  var body: some View {
    GeometryReader { geometry in
      ZStack {
        let shape = RoundedRectangle(cornerRadius: DrawningConstans.cornerRadius)
        if card.isFaceUp {
          shape.fill().foregroundColor(.white)
          shape.strokeBorder(lineWidth: DrawningConstans.lineWidth)
          //Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: 110-90))
            //.padding(5).opacity(0.5)
          Text(card.content).font(font(in: geometry.size))
        } else if card.isMatched {
          shape.opacity(0)
        } else {
          shape.fill()
        }
      }
    }
  }
  
  private func font(in size: CGSize) -> Font {
    Font.system(size: min(size.width, size.height) * DrawningConstans.fontScale)
  }
  
  private struct DrawningConstans {
    static let cornerRadius: CGFloat = 20
    static let lineWidth: CGFloat = 3
    static let fontScale: CGFloat = 0.65
  }
}


struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    EmojiMemoryGameView()
      .environmentObject(EmojiMemoryGame())
  }
}


