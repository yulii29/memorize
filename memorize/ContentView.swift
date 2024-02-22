//
//  ContentView.swift
//  memorize
//
//  Created by Юлия Прищепкина on 14.02.2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack {
            let emojis: Array<String> = ["🌚", "🌜", "🌓", "🌝" ]
            ForEach(emojis.indices, id: \.self){
                index in CardView(content: emojis[index])
            }
        }
        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
        .padding()
    }
}

struct CardView: View {
    let content: String
    @State var isFaceUp: Bool = false
    
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius:12.0)
            if isFaceUp {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            } else {
                base.fill()
            }
        }.onTapGesture(count: 2) {
            isFaceUp.toggle()
        }
        
    }
}

#Preview {
    ContentView()
}


