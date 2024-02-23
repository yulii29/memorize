//
//  ContentView.swift
//  memorize
//
//  Created by Юлия Прищепкина on 14.02.2024.
//

import SwiftUI

struct ContentView: View {
    @State var cardCount = 4
    let emojis: Array<String> = ["🌚", "🌜", "🌓", "🌝", "🌪️", "☃️"]
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 85, maximum: 120))]){
            ForEach(0..<cardCount, id: \.self){
                index in CardView(content: emojis[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }.foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
        
    }
    
    func cardAdjuster(by offset: Int, symbol: String) -> some View {
        Button(action: {
            cardCount += offset
        }, label: {
            Image(systemName: symbol)
        })
        .disabled(cardCount + offset < 1 || cardCount +  offset > emojis.count)
    }
    
    var cardRemover: some View {
        cardAdjuster(by: -1, symbol: "minus.circle.fill")
    }
    
    var cardAdder: some View{
      cardAdjuster(by: 1, symbol: "plus.circle.fill")
    }
    
    var body: some View {
        VStack{
            ScrollView {
                cards
            }
            Spacer()
            
            HStack{
                cardRemover
                Spacer()
                cardAdder
            }
        }
        .imageScale(.large)
        .font(.largeTitle)
        .padding()
    }
}




struct CardView: View {
    let content: String
    @State var isFaceUp: Bool = false
    
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius:12.0)
           Group{
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            }
           .opacity(isFaceUp ? 1 : 0)
            base.fill().opacity(isFaceUp ? 0 : 1)
            
            }.onTapGesture(count: 2) {
            isFaceUp.toggle()
        }
        
    }
}

#Preview {
    ContentView()
}


