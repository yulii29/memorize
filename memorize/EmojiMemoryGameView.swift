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
    private let aspectRatio: CGFloat = 2/3
    
    var body: some View {
        VStack {
            cards
            HStack {
                score
                Spacer()
                deck.foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
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
           card in
           if isDealt(card) {
               CardView(card)
                   .matchedGeometryEffect(id: card.id, in: dealingNameSpace)
                   .padding(spacing)
                   .overlay(FlyingNumber(number: scoreChange(causedBy: card)))
                   .zIndex(scoreChange(causedBy: card) != 0 ? 100 : 0)
                   .onTapGesture {
                       choose(card)
                   }
                
           }
           
       }
        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
        .onAppear {
        
            
        }
     }
    
    @State private var dealt = Set<Card.ID>()
    
    private func isDealt(_ card: Card) -> Bool {
        dealt.contains(card.id)
    }
    
    private var undealtCard: [Card] {
        viewModel.cards.filter { !isDealt($0) }
    }
    
    @Namespace private var dealingNameSpace
    
    private var deck: some View {
        ZStack {
            ForEach(undealtCard) { card in
                CardView(card)
                    .matchedGeometryEffect(id: card.id, in: dealingNameSpace)
            }
        }
        .frame(width: deckWidth, height: deckWidth / aspectRatio)
        .onTapGesture {
            var delay: TimeInterval = 0
             
                for card in viewModel.cards {
                    withAnimation(.easeInOut(duration: 1).delay(delay)) {
                    _ = dealt.insert(card.id)
                }
                    delay += 0.15
            }
        }
    }
    
    private let deckWidth: CGFloat = 50
    
    
    private func choose(_ card: Card) {
        withAnimation {
            let scoreBeforeChoosing = viewModel.score
            viewModel.choose(card)
            let scoreChange = viewModel.score - scoreBeforeChoosing
            lastScoreChange = (scoreChange, causedByCardId: card.id)
        }
    }
    
    @State private var lastScoreChange = ( 0, causedByCardId: "")
    
    private func scoreChange(causedBy card: Card) -> Int {
        let (amount, id) = lastScoreChange
        return card.id == id ? amount : 0
    }
 }





struct EmojiMemoryGameView_Previews: PreviewProvider{
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}



