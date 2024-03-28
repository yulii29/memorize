//
//  MemorizeGame.swift
//  memorize
//
//  Created by Юлия Прищепкина on 28.02.2024.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    private(set) var score = 0
    
    init(numberOfPairs: Int, cardContentFacrory: (Int) -> CardContent){
        cards = Array<Card>()
        
        for pairIndex in 0..<max(2, numberOfPairs){
            let content = cardContentFacrory(pairIndex)
            cards.append(Card(content: content, id: "\(pairIndex+1)a"))
            cards.append(Card(content: content, id: "\(pairIndex+1)b"))
        }
    }
    
    var indexOfOneandOnlyFaceUpCard: Int? {
        get {
            return  cards.indices.filter { index in cards[index].isFaceUp }.only
        }
        set {
            return cards.indices.forEach {
                cards[$0].isFaceUp = (newValue == $0)
            }
        }
    }
    
    mutating func chooseCard(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: {cardToCheck in cardToCheck.id == card.id}){
            if !cards[chosenIndex].isMatched && !cards[chosenIndex].isFaceUp {
                if let potentialMatchIndex = indexOfOneandOnlyFaceUpCard {
                    if cards[chosenIndex].content == cards[potentialMatchIndex].content{
                        cards[chosenIndex].isMatched = true
                        cards[potentialMatchIndex].isMatched = true
                        score += 2
                    } else {
                        if cards[chosenIndex].hasbeenSeen {
                            score -= 1
                        }
                        if cards[potentialMatchIndex].hasbeenSeen {
                            score -= 1
                        }
                    }
                    
                } else {
               
                    indexOfOneandOnlyFaceUpCard = chosenIndex
                }
                
                cards[chosenIndex].isFaceUp = true
            }
            
            
        }
    }
    

    
    mutating func shuffle(){
        cards.shuffle()
    }
    
    struct Card: Equatable, Identifiable, CustomDebugStringConvertible {
        var isFaceUp = false {
            didSet {
                if oldValue && !isFaceUp {
                    hasbeenSeen = true
                }
            }
        }
        var isMatched = false
        var hasbeenSeen = false
        let content: CardContent
        
        var id: String
        var debugDescription: String {
            return "\(id) : \(content) \(isFaceUp ? "up" : "down") \(isMatched ? "matched" : "")"
        }
    }
}
extension Array {
    var only: Element? {
        return count == 1 ? first : nil
    }
}
