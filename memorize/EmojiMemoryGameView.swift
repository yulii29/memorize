//
//  ContentView.swift
//  memorize
//
//  Created by Юлия Прищепкина on 14.02.2024.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    

    
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 85, maximum: 120))]){
            ForEach(viewModel.cards.indices, id: \.self){
                index in CardView(viewModel.cards[index])
                    .aspectRatio(2/3, contentMode: .fit)
                
            }
        }
        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
        
    }


   
    var body: some View {
        VStack{
            ScrollView {
                cards
            }
            Button ("Shuffle"){
                viewModel.shuffleCard()
            }
           
        }
        .imageScale(.large)
        .font(.largeTitle)
        .padding()
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
            base.fill().opacity(card.isFaceUp ? 0 : 1)
            
        }
        
    }
}
struct EmojiMemoryGameView_Previews: PreviewProvider{
    static var previews: some View{
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}



