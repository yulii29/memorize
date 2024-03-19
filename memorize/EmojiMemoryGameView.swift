//
//  ContentView.swift
//  memorize
//
//  Created by Юлия Прищепкина on 14.02.2024.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        VStack {
            
                cards
                    .animation(.default, value: viewModel.cards)
            
            Button ("Shuffle"){
                viewModel.shuffleCard()
            }
           
        }
        .imageScale(.large)
        .font(.largeTitle)
        .padding()
    }
    
    @ViewBuilder
    var cards: some View {
        let aspectRatio: CGFloat = 2/3
        GeometryReader { geometry in
            let gridItemSize = gridItemWidthThatFits(count: viewModel.cards.count, size: geometry.size, atAspectRatio: aspectRatio)
            
            
            LazyVGrid(columns: [GridItem(.adaptive(minimum: gridItemSize), spacing: 0)]) {
                ForEach(viewModel.cards) {
                    card in CardView(card)
                        .aspectRatio(aspectRatio, contentMode: .fit)
                        .padding(4)
                        .onTapGesture {
                            viewModel.choose(card)
                        }
                }
            }
        }
        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
            
        }
        func gridItemWidthThatFits(
            count: Int,
            size: CGSize,
            atAspectRatio aspectRatio: CGFloat) -> CGFloat {
                let count = CGFloat(count)
                var columnCount = 1.0
                repeat {
                    let width = size.width / columnCount
                    let height = width / aspectRatio
                    
                    
                    let rowCount = (count / columnCount).rounded(.up)
                    if rowCount * height < size.height{
                        return (size.width / columnCount).rounded(.down)
                    }
                    columnCount += 1
                } while columnCount < count
                
                return min(size.width / count, size.height * aspectRatio).rounded(.down)
        }

}




struct CardView: View {
    let card: MemoryGame<String>.Card
    
    init(_ card: MemoryGame<String>.Card) {
        self.card = card
    }
    
   var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius:12.0)
           Group{
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
               Text(card.content).font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            }
           .opacity(card.isFaceUp ? 1 : 0)
            base.fill()
           .opacity(card.isFaceUp ? 0 : 1)
            
        }
        .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
        
    }
}
struct EmojiMemoryGameView_Previews: PreviewProvider{
    static var previews: some View{
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}



