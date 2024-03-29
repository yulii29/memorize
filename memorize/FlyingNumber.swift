//
//  FlyingNumber.swift
//  memorize
//
//  Created by Юлия Прищепкина on 28.03.2024.
//

import SwiftUI

struct FlyingNumber: View {
    let number: Int
    @State private var offset: CGFloat = 0
    
    var body: some View {
        if number != 0 {
            Text(number, format: .number.sign(strategy: .always()))
                .font(.largeTitle)
                .foregroundColor(number < 0 ? .red : .green)
                .shadow(color: /*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/, radius: 1.5, x: 1, y: 1)
                .offset(x: 0, y: offset)
                .opacity(offset != 0 ? 0 : 1 )
                .onAppear {
                    withAnimation(.easeInOut(duration: 2)) {
                        offset = number < 0 ? 200 : -200
                    }
                }
                
        }
        
    }
}

