//
//  Score.swift
//  ViewsAndModifers
//
//  Created by Hugo Peyron on 05/04/2023.
//

import SwiftUI

struct Score: View {
    
    @Binding var score: Int
    
    var body: some View {
        Text("\(score)")
            .foregroundColor(.green)
            .font(.title2)
            .bold()
    }
}
