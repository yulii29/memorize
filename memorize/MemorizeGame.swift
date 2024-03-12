//
//  MemorizeGame.swift
//  memorize
//
//  Created by Юлия Прищепкина on 28.02.2024.
//

import Foundation

struct MemoryGame<CardContent> {
    private(set) var cards: Array<Card>
    
    init(numberOfPairs: Int, cardContentFacrory: (Int) -> CardContent){
        cards = Array<Card>()
        
        for pairIndex in 0..<max(2, numberOfPairs){
            let content = cardContentFacrory(pairIndex)
            cards.append(Card(content: content))
            cards.append(Card(content: content))
        }
    }
    
    func chooseCard(_ card: Card){
        
    }
    
    mutating func shuffle(){
        cards.shuffle()
    }
    
    struct Card {
        var isFaceUp = true
        var isMatched = false
        let content: CardContent
    }
}
