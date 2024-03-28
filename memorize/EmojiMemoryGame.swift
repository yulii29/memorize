//
//  EmojiMemoryGame.swift
//  memorize
//
//  Created by Юлия Прищепкина on 28.02.2024.
//

import SwiftUI



class EmojiMemoryGame: ObservableObject {
    typealias Card = MemoryGame<String>.Card
    private static let emojis = ["🌴", "🌜", "🍄", "🍂", "🌪️", "☃️", "💨"]
    
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
    
    var cards: Array<Card>{
        return model.cards
    }
    
    var score: Int {
        return model.score
    }
    
    func shuffleCard(){
        model.shuffle()
        
    }
    
    func choose(_ card: Card){
        model.chooseCard(card)
    }
}
