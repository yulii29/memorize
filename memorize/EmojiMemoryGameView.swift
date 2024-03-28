//
//  ContentView.swift
//  memorize
//
//  Created by Юлия Прищепкина on 14.02.2024.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    typealias Card = MemoryGame<String>.Card
    @ObservedObject var viewModel: EmojiMemoryGame
    
    private let spacing: CGFloat = 4
    
    var body: some View {
        VStack {
            cards
            HStack {
                score
                Spacer()
                shuffle
            }
            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
        }
        
        
        .padding()
    }
    
    private var score: some View {
        Text("Score: \(viewModel.score)")
            .animation(nil)
    }
    
    private var shuffle: some View {
        Button ("Shuffle") {
            withAnimation {
                viewModel.shuffleCard()
            }
        }
    }
    
   var cards: some View {
        AspectVGridView( viewModel.cards) {
                    card in CardView(card)
                        .padding(spacing)
                        .overlay(FlyingNumber(number: scoreChange(cousedBy: card)))
                        .onTapGesture {
                            withAnimation {
                                viewModel.choose(card)
                            }
                    }
            }
        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
            
     }
    private func scoreChange(cousedBy card: Card) -> Int {
        return 0
    }
 }





struct EmojiMemoryGameView_Previews: PreviewProvider{
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}



