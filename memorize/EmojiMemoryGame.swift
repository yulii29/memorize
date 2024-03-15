//
//  EmojiMemoryGame.swift
//  memorize
//
//  Created by Юлия Прищепкина on 28.02.2024.
//

import SwiftUI



class EmojiMemoryGame: ObservableObject {
    private static let emojis = ["🌚", "🌜", "🌓", "🌝", "🌪️", "☃️", "💨"]
    
    private static func createMemoryGame() -> MemoryGame<String> {
        return MemoryGame(numberOfPairs: 6,
                          cardContentFacrory: {
            index in if emojis.indices.contains(index){
                return emojis[index]
            } else {
                return "❌"
            }
        })
    }
    
    
   
    @Published private var model = createMemoryGame()
    
    var cards: Array<MemoryGame<String>.Card>{
        return model.cards
    }
    
    func shuffleCard(){
        model.shuffle()
        
    }
    
    func choose(_ card: MemoryGame<String>.Card){
        model.chooseCard(card)
    }
}
