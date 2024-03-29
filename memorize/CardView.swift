//
//  CardView.swift
//  memorize
//
//  Created by Юлия Прищепкина on 24.03.2024.
//

import SwiftUI

struct CardView: View {
    let card: MemoryGame<String>.Card
    
    init(_ card: MemoryGame<String>.Card) {
        self.card = card
    }
    
    struct Constants {
        static let cornerRadius: CGFloat = 12
        static let lineWidth: CGFloat = 2
        static let inset: CGFloat = 5
        struct FontSize {
            static let largest: CGFloat = 160
            static let smallest: CGFloat = 10
            static let scaleFactor = smallest /  largest
        }
        
    }
    
    var body: some View {
        Pie(endAngle: .degrees(240))
            .opacity(0.5)
            .overlay(
                Text(card.content)
                    .font(.system(size: Constants.FontSize.largest))
                    .minimumScaleFactor(Constants.FontSize.scaleFactor)
                    .padding(5)
                    .rotationEffect(.degrees(card.isMatched ? 360 : 0))
                    .animation(.spin(duration: 1), value: card.isMatched)
            )
        
            .padding(Constants.inset)
            .modifier(Cardify(isFaceUp: card.isFaceUp))
            .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
        
    }
}

extension Animation {
    static func spin(duration: TimeInterval) -> Animation {
        .linear(duration: 1).repeatForever(autoreverses: false)
    }
}
    
    
#Preview {
    VStack{
        HStack {
            CardView(MemoryGame<String>.Card(isFaceUp : true ,content: "⭐️", id: "test1"))
            CardView(MemoryGame<String>.Card(content: "X", id: "test2"))
        }
        
        HStack {
            CardView(MemoryGame<String>.Card(isFaceUp : true, isMatched: true ,content: "☀️", id: "test3"))
            CardView(MemoryGame<String>.Card(isMatched: true, content: "X", id: "test4"))
        }
    }
    .padding()
    .foregroundColor(.green)
}


