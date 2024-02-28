//
//  MemorizeGame.swift
//  memorize
//
//  Created by Юлия Прищепкина on 28.02.2024.
//

import Foundation

struct MemoryGame<CardContent> {
    var cards: Array<Card>
    
    func chooseCard(card: Card){
        
    }
    
    struct Card {
        var isFaceUp: Bool = false
        var isMatched: Bool
        var content: CardContent
    }
}
