//
//  ContentView.swift
//  MathBrainBoosterCopy
//
//  Created by Hugo Peyron on 13/04/2023.
//

import SwiftUI

struct KeyBoardModeView: View {
    
    @State var tableNumber : Int
    
    var body: some View {
            VStack {

                Text("Select your practice table")
                    .font(.title)

                Picker("Choose the table number", selection: $tableNumber) {
                    
                    ForEach(1..<10){number in
                        Text("\(number)")
                    }
                    
                    // some code
                }.pickerStyle(.segmented)
                    .padding()
                
                Spacer()
                
                NavigationLink("Play", destination: GameView(tableNumber: tableNumber + 1))
                    .font(.title)
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 10)
                        .stroke(.blue)
                    )
                
                Spacer()
                
            }
            .padding()
    }
}

struct KeyboardModeView_Previews: PreviewProvider {
    static var previews: some View {
        KeyBoardModeView(tableNumber: 1)
    }
}
