//
//  ContentView.swift
//  ViewsAndModifers
//
//  Created by Hugo Peyron on 04/04/2023.
//

import SwiftUI

struct ContentView: View {
        
    var body: some View {
        
        NavigationView {
            VStack (spacing: 20) {
                NavigationLink(destination: InfiniteGameView()) {Text ("Match the pairs mode")}
                NavigationLink(destination: KeyBoardModeView(tableNumber: 1)) {Text ("KeyBoard mode")}
                }
            }
        }
    }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
