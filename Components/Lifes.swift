//
//  Lifes.swift
//  ViewsAndModifers
//
//  Created by Hugo Peyron on 07/04/2023.
//

import SwiftUI

struct Lifes: View {
    
    @State var lifesCount = 5
    @Binding var lostlifes: Int
    
    var body: some View {
            HStack {
                ForEach(0..<lifesCount, id: \.self) { item in
                    Image(systemName: item < lifesCount - lostlifes ? "heart.fill" : "heart")
                        .foregroundColor(.red)
                }
            }
    }
}
