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
                        score += 2 + cards[chosenIndex].bonus + cards[potentialMatchIndex].bonus
                    } else {
                        if cards[chosenIndex].hasBeenSeen {
                            score -= 1
                        }
                        if cards[potentialMatchIndex].hasBeenSeen {
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
                if isFaceUp {
                    startUsingBonusTime()
                } else {
                    stopUsingBonusTime()
                }
                if oldValue && !isFaceUp {
                    hasBeenSeen = true
                }
            }
        }
        var isMatched = false {
            didSet {
                if isMatched {
                    stopUsingBonusTime()
                }
            }
        }
        var hasBeenSeen = false
        let content: CardContent
        
        //bonus time
        private mutating func startUsingBonusTime() {
            if isFaceUp && !isMatched && bonusPercentReimaining > 0, lastFaceUpDate == nil {
                lastFaceUpDate = Date()
            }
        }
        private mutating func stopUsingBonusTime() {
            pastFaceUpTime = faceUpTime
            lastFaceUpDate = nil
        }
        
        var bonus: Int {
            Int(bonusTimeLimit * bonusPercentReimaining)
        }
        
        var bonusPercentReimaining: Double {
            bonusTimeLimit > 0 ? max(0, bonusTimeLimit - faceUpTime)/bonusTimeLimit : 0
        }
        
        var faceUpTime: TimeInterval {
            if let lastFaceUpDate {
                return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
            } else {
                return pastFaceUpTime
            }
        }
        var pastFaceUpTime: TimeInterval = 0
        var lastFaceUpDate: Date?
        var bonusTimeLimit: TimeInterval = 6
        
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
