//
//  SelectionButton.swift
//  ViewsAndModifers
//
//  Created by Hugo Peyron on 05/04/2023.
//
import SwiftUI

enum ButtonState {
    case normal
    case touched
    case valid
    case wrong
}

struct SelectionButton: View {
    
    let index: Int
    let selectedIndex: Int?
    let state: ButtonState
    let content: String
    let action: () -> Void
    
    var body: some View {
        
        Button {
            action()
            print(self.state)
        } label: {
            Text(content)
                .frame(maxWidth: 110, maxHeight: 80)
                .background(state == .normal ? .clear : buttonColor.opacity(0.3))
                .font(.title3)
                .bold()
                .foregroundColor(state == .normal ? .black : buttonColor)
                .cornerRadius(15)
                .overlay(RoundedRectangle(cornerRadius: 15)
                    .stroke(state == .normal ? .black : buttonColor, lineWidth: 2)
                )
                .opacity(state == .valid ? 0 : 1)
        }
    }
    
    private var buttonColor: Color {
           switch state {
           case .normal:
               return .clear
           case .touched:
               return .blue
           case .valid:
               return .green
           case .wrong:
               return .red
           }
       }
}
