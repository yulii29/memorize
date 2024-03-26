//
//  ContentView.swift
//  memorize
//
//  Created by Юлия Прищепкина on 14.02.2024.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    private let spacing: CGFloat = 4
    
    var body: some View {
        VStack {
            
                cards
                    .animation(.default, value: viewModel.cards)
            
            Button ("Shuffle"){
                viewModel.shuffleCard()
            }
           
        }
        
        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
        .padding()
    }
    
   var cards: some View {
        AspectVGridView( viewModel.cards) {
                    card in CardView(card)
                        .padding(spacing)
                        .onTapGesture {
                            viewModel.choose(card)
                    }
            }
        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
            
     }
 }





struct EmojiMemoryGameView_Previews: PreviewProvider{
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}



