//
//  FlyingNumber.swift
//  memorize
//
//  Created by Юлия Прищепкина on 28.03.2024.
//

import SwiftUI

struct FlyingNumber: View {
    let number: Int
    
    var body: some View {
        if number != 0 {
            Text(number, format: .number)
        }
        
    }
}

